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
        
        let sake = [
            ["id":"1", "name":"月の桂 「抱腹絶倒」8％純米酒", "alcohol":"8.5", "nohonshu":"-60"],
            ["id":"2", "name": "桃の滴 純米吟醸", "alcohol":"15.5", "nohonshu":"5"],
            ["id":"3", "name": "都鶴 長期熟成酒「うなぎのねどこ」", "alcohol":"19.5", "nohonshu":"4"],
            ["id":"4", "name": "英勲 古都千年 純米大吟醸", "alcohol":"15", "nohonshu":"3"]]
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
      //  label.text = String(appDelegate.charaId)
        
        
        //数字からデータを拾う
        // NSUserDefaultsインスタンスの生成
    //    let userDefaults = NSUserDefaults.standardUserDefaults()
        
        var loadText : String! = String(appDelegate.charaId)

        // 月の桂の場合
        if(loadText == "1"){
            //println("Name \(name!)")
            let id = sake[0]["id"]
            let name = sake[0]["name"]
            label.text = name!
            
            // UIImageViewを作成する
            let myImageView: UIImageView = UIImageView(frame: CGRectMake(0,0,250,250))
            
            // 表示する画像を設定する
            let myImage = UIImage(named: "syoukan_tsuki.png")
            
            // 画像をUIImageViewに設定する
            myImageView.image = myImage
            
            // 画像の表示する座標を指定する
            myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: 300.0)
            
            // UIImageViewをViewに追加する
            self.view.addSubview(myImageView)
        }
        
    }
    
    
}