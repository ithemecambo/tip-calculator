//
//  UIResponder+extension.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/15/24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
