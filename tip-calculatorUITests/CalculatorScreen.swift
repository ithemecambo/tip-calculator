//
//  CalculatorScreen.swift
//  tip-calculatorUITests
//
//  Created by SENGHORT KHEANG on 1/15/24.
//

import XCTest

class CalculatorScreen {
    private let app: XCUIApplication!
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var logoView: XCUIElement {
        return app.staticTexts[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    var amountTextField: XCUIElement {
        return app.staticTexts[ScreenIdentifier.BillInputView.amountTextField.rawValue]
    }
    
    var tenPercentButton: XCUIElement {
        return app.staticTexts[ScreenIdentifier.TipInputView.tenPercentButton.rawValue]
    }
    
    var fifteenPercentButton: XCUIElement {
        return app.staticTexts[ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue]
    }
    
    var twentyPercentButton: XCUIElement {
        return app.staticTexts[ScreenIdentifier.TipInputView.twentyPercentButton.rawValue]
    }
    
    var customTipButton: XCUIElement {
        return app.staticTexts[ScreenIdentifier.TipInputView.customTipButton.rawValue]
    }
    
    var customTipAlertButton: XCUIElement {
        return app.staticTexts[ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue]
    }
    
    var minusButton: XCUIElement {
        return app.staticTexts[ScreenIdentifier.SplitInputView.minusButton.rawValue]
    }
    
    var plusButton: XCUIElement {
        return app.staticTexts[ScreenIdentifier.SplitInputView.plusButton.rawValue]
    }
    
    var totalPersonLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.SplitInputView.totalPersonLabel.rawValue]
    }
    
    // Actions
    func enterBill(amount: Double) {
        amountTextField.tap()
        amountTextField.typeText("\(amount)\n")
    }
    
    func selectTipButton(tip: Tip) {
        switch tip {
        case .tenPercent:
            tenPercentButton.tap()
        case .fifteenPercent:
            fifteenPercentButton.tap()
        case .twentyPercent:
            twentyPercentButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertButton.waitForExistence(timeout: 1.0))
            customTipAlertButton.typeText("\(value)\n")
        }
    }
    
    func selectMinusButton(numberOfTaps: Int) {
        minusButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func selectPlusButton(numberOfTaps: Int) {
        plusButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
    
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
    }
    
}
