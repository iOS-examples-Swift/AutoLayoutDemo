//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by Steve on 2017/8/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var headerVeiw: UIView!
    var textField: UITextField!
    var leftView: UIView!
    var button: UIButton!
    var topConstraint: Constraint? = nil


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView()
        view.addSubview(tableView)
        self.headerVeiw = UIView()
        self.headerVeiw.backgroundColor = .red
        self.tableView.tableHeaderView = headerVeiw
        self.textField = UITextField()
        self.textField.layer.borderColor = UIColor.blue.cgColor
        self.textField.layer.borderWidth = 1
        self.leftView = UIView()
        self.leftView.backgroundColor = .brown
        self.textField.leftView = self.leftView
        self.textField.leftViewMode = .always
        self.headerVeiw.addSubview(self.textField)
        self.button = UIButton()
        self.button.addTarget(self, action: #selector(click), for: .touchUpInside)
        self.button.backgroundColor = .purple
        view.addSubview(self.button)

        layout()
    }

    func layout() {
        tableView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.view).offset(20)
            make.right.bottom.equalTo(self.view).offset(-20)
        }
        headerVeiw.snp.makeConstraints { (make) in
            make.width.equalTo(tableView.snp.width)
            make.height.equalTo(180)
        }
        headerVeiw.snp.updateConstraints { (make) in
            make.width.equalTo(tableView.snp.width)
            make.height.equalTo(180)
        }

        tableView.layoutIfNeeded()
        textField.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.headerVeiw).offset(40)
            make.bottom.right.equalTo(self.headerVeiw).offset(-40)
        }
        leftView.snp.updateConstraints { (make) in
            make.width.equalTo(69)
            make.height.equalTo(44)
        }
        button.snp.makeConstraints { (make) in
            self.topConstraint = make.top.equalTo(self.view).offset(100).constraint
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }

    func click() {
        UIView.animate(withDuration: 5) {
//            self.topConstraint?.update(offset: 200)
            self.button.snp.updateConstraints({ (make) in
                make.top.equalTo(200)
            })
            self.view.layoutIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

