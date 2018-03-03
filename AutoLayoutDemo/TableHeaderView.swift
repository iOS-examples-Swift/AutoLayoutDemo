//
//  TableHeaderView.swift
//  AutoLayoutDemo
//
//  Created by Steve on 03/03/2018.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit
import SnapKit

class TableHeaderView: UIView {
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        titleLabel = UILabel();
        addSubview(titleLabel);
        titleLabel.numberOfLines = 0
        titleLabel.text = "看看有没有什么问题"
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(60)
            make.right.equalTo(self.snp.right).offset(-60)
            make.bottom.equalTo(self.snp.bottom).offset(-30)
            make.top.equalTo(self.snp.top).offset(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
