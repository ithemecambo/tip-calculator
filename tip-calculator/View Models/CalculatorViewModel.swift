//
//  CalculatorViewModel.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import Foundation
import Combine

class CalculatorViewModel {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updatePublisher: AnyPublisher<Result, Never>
        let resultCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var audioPlayService: AudioPlayService
    
    init(audioPlayService: AudioPlayService = MockAudioPlayService()) {
        self.audioPlayService = audioPlayService
    }
    
    func transform(input: Input) -> Output {
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap {[unowned self] (bill, tip, split) in
            let totalTip = getTipAmount(bill: bill, tip: tip)
            let totalBill = bill + totalTip
            let amountPerPerson = totalBill / Double(split)
                
            let result = Result(
                amountPerPerson: amountPerPerson,
                totalBill: totalBill,
                totalTip: totalTip)
                
            return Just(result)
            }.eraseToAnyPublisher()
        
        let resultCalculatorPublisher = 
        input.logoViewPublisher.handleEvents(receiveOutput: { [unowned self] in
            audioPlayService.playSound()
        }).flatMap { _ in
            return Just(())
        }.eraseToAnyPublisher()
        
        return Output(updatePublisher: updateViewPublisher, 
                      resultCalculatorPublisher: resultCalculatorPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return bill * 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.20
        case .custom(let value):
            return Double(value)
        }
    }
}
