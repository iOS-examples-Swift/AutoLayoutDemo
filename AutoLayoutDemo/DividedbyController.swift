//
//  ALD1Controller.swift
//  AutoLayoutDemo
//
//  Created by Steve on 16/11/2017.
//  Copyright © 2017 Jack. All rights reserved.
//

import UIKit
import SnapKit


class DividedbyController: UIViewController {
    var tableView: UITableView!
    var headerVeiw: UIView!
    var textField: UITextField!
    var leftView: UIView!
    var button: UIButton!
    var topConstraint: Constraint? = nil
    var textLabel: UILabel!
    var moreTextLabel: UILabel!
    var segmentControl: SegmentControl!
    
    
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
        self.textLabel = UILabel()
        self.textLabel.backgroundColor = .gray
        self.textLabel.textColor = .black
        self.textLabel.text = "这是一窜测试数据"
        self.textLabel.textAlignment = .center
        view.addSubview(self.textLabel)
        self.moreTextLabel = UILabel()
        self.moreTextLabel.backgroundColor = .yellow
        self.moreTextLabel.textColor = .black
        self.moreTextLabel.preferredMaxLayoutWidth = 300
        self.moreTextLabel.numberOfLines = 0
        self.moreTextLabel.text = "这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据这是多窜测试数据"
        view.addSubview(self.moreTextLabel)
        self.segmentControl = SegmentControl(
            style: SetmentStyle(),
            titles: ["1", "2", "3", "4"],
            selectedIndex: nil
        )
        self.segmentControl.backgroundColor = .lightGray
        view.addSubview(segmentControl)
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
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(200)
            make.left.equalTo(self.view.snp.left).offset(40)
        }
        moreTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(10)
            make.left.equalTo(textLabel.snp.left)
        }
        segmentControl.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    @objc func click() {
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

extension UILabel {
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(
            width: super.intrinsicContentSize.width + 10,
            height: super.intrinsicContentSize.height + 10
        )
    }
}
