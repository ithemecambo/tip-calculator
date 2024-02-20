//
//  UIView+extension.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/14/24.
//

import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
    }
    
    func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.maskedCorners = [corners]
    }
}
