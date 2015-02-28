//
//  rule.swift
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/03/01.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

import Foundation

class ruleViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if(appDelegate.charaId != 0){
            performSegueWithIdentifier("CharaShow",sender: nil)
        }
        
    }
    
    @IBAction func backPushed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if(appDelegate.charaId != 0){
            performSegueWithIdentifier("CharaShow",sender: nil)
        }
    }
}

