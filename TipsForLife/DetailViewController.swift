//
//  DetailViewController.swift
//  TipsForLife
//
//  Created by Hyubyn on 7/10/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class DetailViewController: BaseViewController {
    
    lazy var contentLabel: UITextView = {
        let label = UITextView()
        label.text = "Content"
        label.textAlignment = .left
        label.isEditable = false
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    lazy var colorPicker: ColorPicker = {
        let picker = ColorPicker()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        return picker
    }()
    
    lazy var changeThemeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Color", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupView() {
        view.addSubview(contentLabel)
        
        view.addSubview(changeThemeButton)
        
        view.addSubview(colorPicker)
        
        addCloseButton()
        
        contentLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(view)
            maker.bottom.equalTo(view).inset(AppTheme.shared.bottomHeight)
            maker.top.equalTo(closeButton.snp.bottom).offset(AppTheme.shared.smallMargin)
        }
        
        colorPicker.snp.makeConstraints { (maker) in
            maker.height.equalTo(80)
            maker.leading.trailing.equalTo(view).inset(AppTheme.shared.smallMargin)
            maker.center.equalTo(view)
        }
        
        changeThemeButton.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(view)
            maker.leading.trailing.bottom.equalTo(view).inset(AppTheme.shared.smallMargin)
        }
        
    }
    
    override func setupRx() {
        changeThemeButton.rx
            .tap
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe ( onNext: { _ in
                if self.colorPicker.isHidden {
                    self.colorPicker.showColorPicker()
                } else {
                    self.colorPicker.hideColorPicker()
                }
            }).addDisposableTo(disposeBag)
    }
    
}

extension DetailViewController: ColorPickerDelegate {
    func didSelectColor(color: UIColor) {
        AppTheme.shared.mainColor = color
        changeTheme()
    }
}
