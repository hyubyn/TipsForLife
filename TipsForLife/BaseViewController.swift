//
//  BaseViewController.swift
//  TipsForLife
//
//  Created by Hyubyn on 7/10/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "delete"), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    // list all view that display content by text, use for change theme
    
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppTheme.shared.backgroundColor
        
        setupView()
        
        setupRx()
        
        changeTheme()
    }

    func setupView() {
        
    }
    
    func setupRx() {
        
    }

    func changeTheme() {
        let color = AppTheme.shared.mainColor
        if var nearBy = color.getNearByColor() {
            nearBy.insert(color, at: 0)
            UIView.createGradientColors(for: view, with: nearBy, GradientStartPosition.top, layer: &gradientLayer)
        } else {
            UIView.createGradientColors(for: view, with: [color, AppTheme.shared.mainColor.getInverseColor()?.withAlphaComponent(0.5) ?? AppTheme.shared.mainColor.withAlphaComponent(0.5) ], GradientStartPosition.top, layer: &gradientLayer)
        }
        
        let textColor = UIColor.getTextColor(from: color).first!
        for view in view.subviews {
            if let button = view as? UIButton {
                button.setTitleColor(textColor, for: .normal)
            } else if let label = view as? UILabel {
                label.textColor = textColor
            } else if let textView = view as? UITextView {
                textView.textColor = textColor
            } else if let textField = view as? UITextField {
                textField.textColor = textColor
            }
        }
    }
    
    func addCloseButton() {
        
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { (maker) in
            maker.top.trailing.equalTo(view).inset(AppTheme.shared.margin)
        }
        
        closeButton.rx
            .tap
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.closeButtonTapped()
            })
            .disposed(by: disposeBag)
    }
    
    func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func backButtonTapped() {
        
    }
}
