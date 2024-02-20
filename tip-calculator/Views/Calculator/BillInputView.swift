//
//  BillInputView.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    private var headerView: HeaderView = {
        return HeaderView(title: "Enter", subtitle: "your bill")
    }()
    
    private let dollarSymbol: UILabel = {
        let label = UILabel()
        label.text = "$"
        label.font = ThemeFont.demiBold(ofSize: 24)
        return label
    }()
    
    private lazy var amountTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.keyboardType = .decimalPad
        textfield.font = ThemeFont.bold(ofSize: 24)
        textfield.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textfield.tintColor = ThemeColor.text
        textfield.textColor = ThemeColor.text
        textfield.accessibilityIdentifier = ScreenIdentifier.BillInputView.amountTextField.rawValue
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped))
        toolbar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil, action: nil),
            doneButton
        ]
        toolbar.isUserInteractionEnabled = true
        textfield.inputAccessoryView = toolbar
        
        return textfield
    }()
    
    @objc private func doneButtonTapped() {
        endEditing(true)
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(10)
        
        return view
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private var billSubject: PassthroughSubject<Double, Never> = .init()
    
    init() {
        super.init(frame: .zero)
        self.layout
        self.observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe() {
        amountTextField.textPublisher.sink { text in
            self.billSubject.send(text?.doubleValue ?? 0.0)
        }.store(in: &cancellables)
    }
    
    func reset() {
        amountTextField.text = nil
        billSubject.send(0)
    }
    
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    private var layout: () {
        [headerView, containerView].forEach(addSubview(_:))
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(containerView.snp.leading).offset(-24)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        containerView.addSubview(dollarSymbol)
        containerView.addSubview(amountTextField)
        
        dollarSymbol.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(16)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(dollarSymbol.snp.leading).offset(24)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
    }
}
