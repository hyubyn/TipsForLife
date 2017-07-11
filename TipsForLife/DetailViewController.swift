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
        label.font = AppTheme.shared.mainFont
        return label
    }()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        view.addSubview(contentLabel)
        
        addCloseButton()
        
        contentLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(view)
            maker.bottom.equalTo(view).inset(AppTheme.shared.bottomHeight)
            maker.top.equalTo(view).inset(AppTheme.shared.margin)
        }
        
               
    }
    
}
