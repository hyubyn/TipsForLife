//
//  UIViewController.swift
//  HyuKit
//
//  Created by NguyenVuHuy on 7/10/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func randomPresentViewController(viewController: UIViewController, _ completion: (() -> Void)?) {
        if let modalStyle = UIModalTransitionStyle.init(rawValue: Int(arc4random_uniform(4))) {
            viewController.modalTransitionStyle = modalStyle
        }
        navigationController?.present(viewController, animated: true, completion: completion)
    }
    
}
