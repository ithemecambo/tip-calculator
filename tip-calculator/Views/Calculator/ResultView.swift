//
//  ResultView.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import UIKit
import SnapKit

class ResultView: UIView {
    
    private let totalPersonLabel: UILabel = {
        LabelFactory.build(text: "Total/Person", font: ThemeFont.bold(ofSize: 24))
    }()
    
    private let totalLabel: UILabel = {
        let lable = LabelFactory.buildAttribute(text: "$0", smallFont: ThemeFont.bold(ofSize: 24), bigFont: ThemeFont.bold(ofSize: 50))
        lable.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue
        return lable
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        
        return view
    }()
    
    private let billLabel: UILabel = {
        LabelFactory.build(text: "Total bill", font: ThemeFont.regular(ofSize: 16), textAlignemnt: .left)
    }()
    
    private let totalBillLabel: UILabel = {
        let label = LabelFactory.buildAttribute(text: "$0", smallFont: ThemeFont.bold(ofSize: 16), bigFont: ThemeFont.bold(ofSize: 24), textColor: ThemeColor.primary, textAlignemnt: .left)
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalBillValueLabel.rawValue
        
        return label
    }()
    
    private lazy var billStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            billLabel, totalBillLabel
        ])
        view.axis = .vertical
        view.spacing = 2
        
        return view
    }()
    
    private let tipLabel: UILabel = {
        LabelFactory.build(text: "Total tip", font: ThemeFont.regular(ofSize: 16), textAlignemnt: .right)
    }()
    
    private let totalTipLabel: UILabel = {
        let label = LabelFactory.buildAttribute(text: "$0", smallFont: ThemeFont.bold(ofSize: 16), bigFont: ThemeFont.bold(ofSize: 24), textColor: ThemeColor.primary, textAlignemnt: .right)
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalTipValueLabel.rawValue
        
        return label
    }()
    
    private lazy var tipStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            tipLabel, totalTipLabel
        ])
        view.axis = .vertical
        view.spacing = 2
        
        return view
    }()
    
    private lazy var hstackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            billStackView, tipStackView
        ])
        view.axis = .horizontal
        view.spacing = 10
        
        return view
    }()
    
    private lazy var mainView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            totalPersonLabel, totalLabel,
            lineView, hstackView
        ])
        view.axis = .vertical
        view.spacing = 10
        
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        self.layout
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView(result: Result) {
        let totalText = NSMutableAttributedString(
            string: "\(result.amountPerPerson.currencyFormatted)",
            attributes: [.font: ThemeFont.bold(ofSize: 50)])
        totalText.addAttributes([.font: ThemeFont.bold(ofSize: 24)],
                                range: NSMakeRange(0, 1))
        totalLabel.attributedText = totalText
        
        let billText = NSMutableAttributedString(
            string: "\(result.totalBill.currencyFormatted)",
            attributes: [.font: ThemeFont.bold(ofSize: 24),
                         .foregroundColor: ThemeColor.primary
                        ])
        billText.addAttributes([
            .font: ThemeFont.bold(ofSize: 16),
            .foregroundColor: ThemeColor.primary
        ],
                                range: NSMakeRange(0, 1))
        totalBillLabel.attributedText = billText
        
        let tipText = NSMutableAttributedString(
            string: "\(result.totalTip.currencyFormatted)",
            attributes: [.font: ThemeFont.bold(ofSize: 24),
                         .foregroundColor: ThemeColor.primary
                        ])
        tipText.addAttributes([
            .font: ThemeFont.bold(ofSize: 16),
            .foregroundColor: ThemeColor.primary
        ],
                                range: NSMakeRange(0, 1))
        totalTipLabel.attributedText = tipText
    }
    
    private var layout: () {
        backgroundColor = .white
        addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leadingMargin).offset(16)
            make.trailing.equalTo(snp.trailingMargin).offset(-16)
            make.top.equalTo(snp.topMargin).offset(16)
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
