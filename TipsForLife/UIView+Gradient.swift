//
//  CAGradientLayer.swift
//  HyuKit
//
//  Created by Hyubyn on 2/28/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        get { return points.startPoint }
    }
    
    var endPoint : CGPoint {
        get { return points.endPoint }
    }
    
    var points : GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint.init(x: 0.0,y: 1.0), CGPoint.init(x: 1.0,y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint.init(x: 0.0,y: 0.0), CGPoint.init(x: 1,y: 1))
            case .horizontal:
                return (CGPoint.init(x: 0.0,y: 0.5), CGPoint.init(x: 1.0,y: 0.5))
            case .vertical:
                return (CGPoint.init(x: 0.0,y: 0.0), CGPoint.init(x: 0.0,y: 1.0))
            }
        }
    }
}

enum GradientStartPosition: Int {
    case top = 0
    case topLeft = 1
    case topRight = 2
    case left = 3
}


extension UIView {
    
    func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
   
    class func createGradientColors(for view: UIView, with colors: [UIColor], _ startPosition: GradientStartPosition, layer gradientLayer: inout CAGradientLayer) {
        gradientLayer.removeFromSuperlayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        switch startPosition {
        case .top:
            gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
        case .topLeft:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        case .topRight:
            gradientLayer.startPoint = CGPoint.init(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        default:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        }
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
