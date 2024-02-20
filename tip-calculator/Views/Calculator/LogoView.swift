//
//  LogoView.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import UIKit
import SnapKit

class LogoView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "dollarsign.circle.fill")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mr. TIP",
            attributes: [.font: ThemeFont.demiBold(ofSize: 16)]
        )
        text.addAttributes([.font: ThemeFont.demiBold(ofSize: 24)], range: NSMakeRange(3, 3))
        label.textAlignment = .left
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        return LabelFactory.build(text: "Calculator", font: ThemeFont.demiBold(ofSize: 24), textAlignemnt: .left)
    }()
    
    private lazy var vstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = -4
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            vstackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
    }
}
