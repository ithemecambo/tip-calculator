//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
    private let headerView: HeaderView = {
        return HeaderView(title: "Split", subtitle: "the total")
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 40)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addRoundedCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 8)
        button.tapPublisher.flatMap({ [unowned self] _ in
            Just(spliteSubject.value == 1 ? 1 : spliteSubject.value - 1)
        }).assign(to: \.value, on: spliteSubject).store(in: &cancellables)
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.minusButton.rawValue
        
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 30)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addRoundedCorners(corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 8)
        button.tapPublisher.flatMap({ [unowned self] _ in
            Just(spliteSubject.value + 1)
        }).assign(to: \.value, on: spliteSubject).store(in: &cancellables)
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.plusButton.rawValue
        
        return button
    }()
    
    private lazy var totalPersonLabel: UILabel = {
        let label = LabelFactory.build(text: "2", font: ThemeFont.bold(ofSize: 20))
        label.accessibilityIdentifier = ScreenIdentifier.SplitInputView.totalPersonLabel.rawValue
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            minusButton,
            totalPersonLabel,
            plusButton
        ])
        view.axis = .horizontal
        view.spacing = 16
        view.distribution = .fillEqually
        view.backgroundColor = .white
        view.addCornerRadius(8)
        
        return view
    }()
    
    private var spliteSubject: CurrentValueSubject<Int, Never> = .init(1)
    private var cancellables = Set<AnyCancellable>()
    
    var valuePublisher: AnyPublisher<Int, Never> {
        return spliteSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        self.layout
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe() {
        spliteSubject.sink { [unowned self] person in
            totalPersonLabel.text = person.stringValue
        }.store(in: &cancellables)
    }
    
    func reset() {
        spliteSubject.send(1)
    }
    
    private var layout: () {
        [headerView, buttonStackView].forEach(addSubview(_:))
        buttonStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-24)
            make.width.height.equalTo(68)
            make.centerY.equalTo(buttonStackView.snp.centerY)
        }
    }
}
