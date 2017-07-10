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

    lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Click me!", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.sizeToFit()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(testButton)
        testButton.snp.makeConstraints { (maker) in
            maker.center.equalTo(view)
            maker.height.equalTo(40)
            maker.width.equalTo(70)
        }
        testButton.rx
            .tap
            .debug("Button tapped")
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let detail = DetailViewController()
                let path = "/Resource/VN/FirstAid"
                let listFile: [String] = (self?.getListFile(path: path))!
                let content = self?.getFileContent(fileName: listFile.first!, path: path)
                print(content ?? "")
                detail.contentLabel.text = content ?? "No content"
                
                self?.randomPresentViewController(viewController: detail, nil)

            })
            .disposed(by: disposeBag)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        textView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    func getListFile(path: String) -> [String] {
        let docsPath = Bundle.main.resourcePath! + path
        let fileManager = FileManager.default
        
        do {
            let docsArray = try fileManager.contentsOfDirectory(atPath: docsPath)
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

