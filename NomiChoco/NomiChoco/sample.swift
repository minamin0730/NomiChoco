//
//  sample.swift
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/03/01.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

import Foundation
class sampleViewController: UIViewController{
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        label.text = String(appDelegate.charaId)
        
    }
    
    
}