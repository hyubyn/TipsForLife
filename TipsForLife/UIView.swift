//
//  UIView.swift
//  HyuKit
//
//  Created by NguyenVuHuy on 7/10/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     * Function's name: addCircle
     * Params: None
     * This function is to create circle view component
     **/
    func addCircle() {
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
    }
    
    /**
     * Function's name: addCornerRadius
     * Params: radius (CGFloat)
     * This function is to create corner radius for view component
     **/
    func addCornerRadius(radius: CGFloat = 5.0) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    /**
     * Function's name: addShadow
     * Params: radius (CGFloat)
     * This function is to create corner radius for view component
     **/
    func addShadow(with offset: CGSize = CGSize.zero, with radius: CGFloat = 5.0, andOpacity opacity: Float = 0.8) {
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    /**
     * Function's name: animateShow
     * This function is to create animate show a UIView
     **/
    func animateShow(with duration: TimeInterval = 0.4, and animTime: TimeInterval = 0.1) {
        isHidden = false
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: animTime, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: animTime, animations: { 
                    self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
    
    /**
     * Function's name: animateHide
     * This function is to create animate hide a UIView
     **/
    func animateHide(with duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            self.isHidden = true
        }
    }

}
