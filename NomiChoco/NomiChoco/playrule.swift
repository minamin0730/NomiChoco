//
//  rule.swift
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/03/01.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

import Foundation

class playruleViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func returnPushed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

