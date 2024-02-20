//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {
    
    // sut => System Under Test
    private var sut: CalculatorViewModel!
    private var cancellables: Set<AnyCancellable>!
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    private var audioPlayerService: DefaultAudioPlayService!

    override func setUp() {
        audioPlayerService = .init()
        sut = .init(audioPlayService: audioPlayerService)
        logoViewTapSubject = .init()
        cancellables = .init()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
        logoViewTapSubject = nil
        audioPlayerService = nil
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorViewModel.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewPublisher: logoViewTapSubject.eraseToAnyPublisher()
        )
    }
    
    func testResultWithoutTipFor1Person() {
        // give
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        // then
        output.updatePublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWithoutTipFor2Person() {
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        let output = sut.transform(input: input)
        output.updatePublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWith10PercentTipFor2Person() {
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        let output = sut.transform(input: input)
        output.updatePublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellables)
    }
    
    func testResultWithCustomTipFor4Person() {
        let bill: Double = 200.0
        let tip: Tip = .custom(value: 50)
        let split: Int = 4
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        let output = sut.transform(input: input)
        output.updatePublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 62.5)
            XCTAssertEqual(result.totalBill, 250)
            XCTAssertEqual(result.totalTip, 50)
        }.store(in: &cancellables)
    }
    
    func testSoundPlayedAndCalculatorResultOnLogoViewTap() {
        // give
        let input = buildInput(bill: 100.0, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called.")
        let expectation2 = audioPlayerService.expectation
        // then
        output.resultCalculatorPublisher.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellables)
        
        // when
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }
}

class DefaultAudioPlayService: AudioPlayService {
    let expectation = XCTestExpectation(description: "play sound called.")
    func playSound() {
        expectation.fulfill()
    }
}
