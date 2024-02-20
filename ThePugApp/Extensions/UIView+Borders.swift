//
//  UIView+Borders.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import UIKit

public extension UIView {
    func setupBorder(width: CGFloat = 1.0, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
