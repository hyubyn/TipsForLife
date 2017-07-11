//
//  ViewController.swift
//  TipsForLife
//
//  Created by Hyubyn on 7/9/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: BaseViewController {

    lazy var englishButton: UIButton = {
        let button = UIButton()
        button.setTitle("English", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    lazy var vietnamButton: UIButton = {
        let button = UIButton()
        button.setTitle("VietNamese", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    lazy var changeThemeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Color", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    
    lazy var colorPicker: ColorPicker = {
        let picker = ColorPicker()
        picker.delegate = self
        picker.backgroundColor = UIColor.clear
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupView() {
        view.addSubview(englishButton)
        view.addSubview(vietnamButton)
        view.addSubview(changeThemeButton)
        view.addSubview(colorPicker)
        
        englishButton.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(view)
            maker.centerY.equalTo(view).offset(AppTheme.shared.margin)
            maker.height.equalTo(40)
            maker.width.equalTo(150)
        }
        
        
        vietnamButton.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(view)
            maker.top.equalTo(englishButton.snp.bottom).offset(AppTheme.shared.margin)
            maker.width.height.equalTo(englishButton)
        }
        
        colorPicker.snp.makeConstraints { (maker) in
            maker.height.equalTo(60)
            maker.leading.trailing.equalTo(view).inset(AppTheme.shared.smallMargin)
            maker.center.equalTo(view)
        }
        
        changeThemeButton.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(view)
            maker.leading.trailing.bottom.equalTo(view).inset(AppTheme.shared.smallMargin)
        }
    }
    
    override func setupRx() {
        
        vietnamButton.rx
            .tap
            .debug("Button tapped")
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.goToListViewController(with: "/Resource/VN/FirstAid")
            })
            .disposed(by: disposeBag)
        

        englishButton.rx
            .tap
            .debug("Button tapped")
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.goToListViewController(with: "/Resource/ENG/FirstAid")
                
            })
            .disposed(by: disposeBag)
        
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
    
    func goToListViewController(with path: String) {
        let listViewController = ListTableViewController()
        listViewController.path = path
        listViewController.listInformations = self.getListFile(path: path)
        listViewController.tableView.reloadData()
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    func getListFile(path: String) -> [String] {
        let docsPath = Bundle.main.resourcePath! + path
        let fileManager = FileManager.default
        
        do {
            let docsArray = try fileManager.contentsOfDirectory(atPath: docsPath).map{ getFileName(txtName: $0) }
            return docsArray
        } catch {
            print(error)
            return [String]()
        }
    }
    
    func getFileContent(fileName: String, path: String) -> String? {
        print(getFileName(txtName: fileName))
        let filePath = Bundle.main.resourcePath! + path + "/\(fileName)"
        let fileManager = FileManager.default
        let data = fileManager.contents(atPath: filePath)
        let content = String(data: data!, encoding: String.Encoding.utf8) as String!
        return content
    }
    
    func getFileName(txtName: String) -> String {
        let arr = txtName.components(separatedBy: ".")
        return arr.first!
    }
}


extension ViewController: ColorPickerDelegate {
    func didSelectColor(color: UIColor) {
        AppTheme.shared.mainColor = color
        changeTheme()
    }
}
