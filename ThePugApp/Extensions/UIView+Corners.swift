//
//  UIView+Corners.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import UIKit

public struct RoundedCorners {
    public let radius: CGFloat
    public let corners: UIRectCorner

    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
}

public extension UIView {
    func setup(roundedCorners: RoundedCorners) {
        setupRoundedCorners(radius: roundedCorners.radius, corners: roundedCorners.corners)
    }

    func setupRoundedCorners(
        radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) {
        setupRoundedCorners(radius: radius, corners: corners, smoothCorners: true)
    }

    func setupRoundedCorners(
        radius: CGFloat,
        corners: UIRectCorner = .allCorners,
        smoothCorners: Bool
    ) {
        layer.cornerRadius = radius
        if smoothCorners {
            if #available(iOS 13.0, *) {
                layer.cornerCurve = .continuous
            }
        }
        clipsToBounds = true
        if let mask = corners.mask {
            layer.maskedCorners = mask
        }
        if layer.shadowPath != nil {
            createCachedShadow()
        }
    }

    func makeItCircular() {
        layoutIfNeeded()
        setupRoundedCorners(radius: min(frame.size.height, frame.size.width) / 2)
    }

    func resetCornerRadius() {
        layer.cornerRadius = 0.0
        if layer.shadowPath != nil {
            createCachedShadow()
        }
    }
}

extension UIRectCorner {
    var mask: CACornerMask? {
        guard self != .allCorners else { return nil }
        var cornerMask = CACornerMask()
        if contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        return cornerMask
    }
}

extension CACornerMask {
    var rect: UIRectCorner {
        var cornersCount = 0
        var rect = UIRectCorner()
        if contains(.layerMinXMinYCorner) {
            rect.insert(.topLeft)
            cornersCount += 1
        }
        if contains(.layerMaxXMinYCorner) {
            rect.insert(.topRight)
            cornersCount += 1
        }
        if contains(.layerMinXMaxYCorner) {
            rect.insert(.bottomLeft)
            cornersCount += 1
        }
        if contains(.layerMaxXMaxYCorner) {
            rect.insert(.bottomRight)
            cornersCount += 1
        }
        guard cornersCount != 4 else { return .allCorners }
        return rect
    }
}
