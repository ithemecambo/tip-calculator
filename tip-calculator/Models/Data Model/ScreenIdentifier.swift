//
//  ScreenIdentifier.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/15/24.
//

import Foundation

enum ScreenIdentifier {
    enum LogoView: String {
        case logoView
    }
    
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case amountTextField
    }
    
    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }
    
    enum SplitInputView: String {
        case minusButton
        case totalPersonLabel
        case plusButton
    }
}
