//
//  UIButton+Extension.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func makeRounded() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.height / 2.0
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
