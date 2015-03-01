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
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var charaView: UIImageView!
    @IBOutlet weak var whiteout: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*  let sake = [
            ["id":"1", "name":"月の桂 「抱腹絶倒」8％純米酒", "alcohol":"8.5", "nohonshu":"-60"],
            ["id":"2", "name": "桃の滴 純米吟醸", "alcohol":"15.5", "nohonshu":"5"],
            ["id":"3", "name": "都鶴 長期熟成酒「うなぎのねどこ」", "alcohol":"19.5", "nohonshu":"4"],
            ["id":"4", "name": "英勲 古都千年 純米大吟醸", "alcohol":"15", "nohonshu":"3"]]
       */
        
        let sake = [
            ["id":"1", "name":"月の桂", "alcohol":"8.5", "nohonshu":"-60"],
            ["id":"2", "name": "桃の滴", "alcohol":"15.5", "nohonshu":"5"],
            ["id":"3", "name": "都鶴", "alcohol":"19.5", "nohonshu":"4"],
            ["id":"4", "name": "英勲", "alcohol":"15", "nohonshu":"3"]]
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
      //  label.text = String(appDelegate.charaId)
        
        
        //数字からデータを拾う
        // NSUserDefaultsインスタンスの生成
    //    let userDefaults = NSUserDefaults.standardUserDefaults()
        
        var loadText : String! = String(appDelegate.charaId)

        // 月の桂の場合
        if(loadText == "1"){
            let id = sake[0]["id"]
            let name = sake[0]["name"]
            label.text = name!
    
            // 表示する画像を設定する
            let myImage = UIImage(named: "syoukan_tsuki.png")
            // 画像をUIImageViewに設定する
            charaView.image = myImage
            
        }else if(loadText == "2"){
            let id = sake[1]["id"]
            let name = sake[1]["name"]
            label.text = name!
            
            // 表示する画像を設定する
            let myImage = UIImage(named: "syoukan_momo.png")
            // 画像をUIImageViewに設定する
            charaView.image = myImage
            
        }else if(loadText == "3"){
            let id = sake[2]["id"]
            let name = sake[2]["name"]
            label.text = name!
            
            // 表示する画像を設定する
            let myImage = UIImage(named: "syoukan_tozuru.png")
            // 画像をUIImageViewに設定する
            charaView.image = myImage
            
            
        }else if(loadText == "4"){
            let id = sake[3]["id"]
            let name = sake[3]["name"]
            label.text = name!
            
            // 表示する画像を設定する
            let myImage = UIImage(named: "syoukan_eikun.png")
            // 画像をUIImageViewに設定する
            charaView.image = myImage
            
        }
        
        UIView.animateWithDuration(3.0, animations: {() -> Void in
        self.whiteout.alpha = 0.0;
        }, completion: {(Bool) -> Void in
        })
        

    }
    
    
}