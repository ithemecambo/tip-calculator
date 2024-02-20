//
//  tip_calculatorSnapshortTests.swift
//  tip-calculatorTests
//
//  Created by SENGHORT KHEANG on 1/15/24.
//

import XCTest
import SnapshotTesting
@testable import tip_calculator

final class tip_calculatorSnapshotTests: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    private var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWithLogoView() {
        // give
        let size = CGSize(width: screenWidth, height: 48)
        // when
        let view = LogoView()
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialResultView() {
        let size = CGSize(width: screenWidth, height: 224)
        let view = ResultView()
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testAssignValueWithResultView() {
        let size = CGSize(width: screenWidth, height: 224)
        let view = ResultView()
        let result = Result(
            amountPerPerson: 120.25,
            totalBill: 45,
            totalTip: 60)
        view.configView(result: result)
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialBillInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testAssignValueWithBillInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        let textfield = view.allSubViewsOff(type: UITextField.self).first
        textfield?.text = "500"
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        let size = CGSize(width: screenWidth, height: 56+56+16)
        let view = TipInputView()
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testAssignValueWithTipInputView() {
        let size = CGSize(width: screenWidth, height: 56+56+16)
        let view = TipInputView()
        let button = view.allSubViewsOff(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialSplitInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitInputView()
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testAssignValueWithSplitInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitInputView()
        let button = view.allSubViewsOff(type: UIButton.self).last
        for _ in 0..<5 {
            button?.sendActions(for: .touchUpInside)
        }
        assertSnapshot(matching: view, as: .image(size: size))
    }
}

extension UIView {
    func allSubViewsOff<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        func getSubView(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach { getSubView(view: $0) }
        }
        getSubView(view: self)
        return all
    }
}
