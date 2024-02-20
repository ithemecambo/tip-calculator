//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import UIKit

struct LabelFactory {
    
    static func build(text: String?, font: UIFont, backgroundColor: UIColor = .clear, textColor: UIColor = ThemeColor.text, textAlignemnt: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignemnt
        
        return label
    }
    
    static func buildAttribute(text: String?, smallFont: UIFont, bigFont: UIFont, backgroundColor: UIColor = .clear, textColor: UIColor = ThemeColor.text, textAlignemnt: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        let textValue = NSMutableAttributedString(
            string: text ?? "",
            attributes: [.font: bigFont]
        )
        textValue.addAttributes([.font: smallFont], range: NSMakeRange(0, 1))
        label.attributedText = textValue
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignemnt
        
        return label
    }
}
