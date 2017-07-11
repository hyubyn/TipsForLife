//
//  ListViewController.swift
//  TipsForLife
//
//  Created by NguyenVuHuy on 7/11/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit

class ListTableViewController:  BaseViewController {

    var listInformations = [String]()
    var path = "/Resource/ENG/FirstAid"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(view)
        }
    }
    
    func getFileContent(fileName: String, path: String) -> String? {
        let filePath = Bundle.main.resourcePath! + path + "/\(fileName).txt"
        let fileManager = FileManager.default
        let data = fileManager.contents(atPath: filePath)
        let content = String(data: data!, encoding: String.Encoding.utf8) as String!
        return content
    }
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listInformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        let contentName = listInformations[indexPath.row]
        if let tableCell = cell {
            if let label = tableCell.viewWithTag(1993) as? UILabel {
                label.text = contentName
            } else {
                let label = UILabel()
                label.tag = 1993
                label.textAlignment = .center
                tableCell.addSubview(label)
                label.snp.makeConstraints({ (maker) in
                    maker.edges.equalTo(tableCell).inset(AppTheme.shared.smallMargin)
                })
                label.text = contentName
                label.numberOfLines = 0
                label.textColor = UIColor.getTextColor(from: AppTheme.shared.mainColor).first!
            }
            tableCell.backgroundColor = UIColor.clear
            return tableCell
        } else {
            let tableCell = UITableViewCell(style: .default, reuseIdentifier: "TableViewCell")
            let label = UILabel()
            label.tag = 1993
            label.textAlignment = .center
            tableCell.addSubview(label)
            label.snp.makeConstraints({ (maker) in
                maker.edges.equalTo(tableCell).inset(AppTheme.shared.smallMargin)
            })
            label.text = contentName
            label.numberOfLines = 0
            return tableCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        let content = getFileContent(fileName: listInformations[indexPath.row], path: path)
        detail.contentLabel.text = content ?? "No content"
        randomPresentViewController(viewController: detail, nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
