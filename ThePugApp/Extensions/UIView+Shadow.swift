//
//  UIView+Shadow.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import UIKit

public extension UIView {
    func addShadowBorder(
        radius: CGFloat,
        opacity: CGFloat,
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0,
        cache: Bool = false
    ) {
        setupShadow(radius: radius, opacity: opacity, offsetX: offsetX, offsetY: offsetY, color: .black, cache: cache)
    }

    func setupShadow(
        radius: CGFloat,
        opacity: CGFloat,
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0,
        color: UIColor? = .black,
        cache: Bool = false
    ) {
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowRadius = radius
        if let color = color {
            layer.shadowColor = color.cgColor
            clipsToBounds = false
        }
        layer.shadowOpacity = Float(opacity)
        if cache {
            createCachedShadow()
        }
    }

    func createCachedShadow() {
        let origin = CGPoint(x: bounds.origin.x + layer.shadowOffset.width, y: bounds.origin.y + layer.shadowOffset.height)
        let size = CGSize(width: bounds.size.width + layer.shadowOffset.width, height: bounds.size.height + layer.shadowOffset.height)
        let rect = CGRect(origin: origin, size: size)
        let path: UIBezierPath
        if layer.cornerRadius > 0 {
            let maskedRect = layer.maskedCorners.rect
            if maskedRect == .allCorners {
                path = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius)
            } else {
                path = UIBezierPath(
                    roundedRect: rect,
                    byRoundingCorners: maskedRect,
                    cornerRadii: CGSize(
                        width: layer.cornerRadius,
                        height: layer.cornerRadius
                    )
                )
            }
        } else {
            path = UIBezierPath(rect: rect)
        }
        layer.shadowPath = path.cgPath
    }

    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.07
        layer.shadowOffset = CGSize(width: -3.0, height: 6)
        layer.shadowRadius = 0.5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
