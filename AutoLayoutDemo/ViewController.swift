//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by Steve on 2017/8/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DividedbyController(), animated: true)
    }
}

