//
//  HeaderView.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import UIKit

class HeaderView: UIView {
    private var title: String
    private var subtitle: String
    
    private lazy var topLabel: UILabel = {
        LabelFactory.build(text: title, font: ThemeFont.bold(ofSize: 18), textAlignemnt: .left)
    }()
    private lazy var bottomLabel: UILabel = {
        LabelFactory.build(text: subtitle, font: ThemeFont.regular(ofSize: 16), textAlignemnt: .left)
    }()
    
    private lazy var mainView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            UIView(),
            topLabel,
            bottomLabel,
            UIView()
        ])
        view.axis = .vertical
        view.spacing = 0
        
        return view
    }()
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
    }
}
