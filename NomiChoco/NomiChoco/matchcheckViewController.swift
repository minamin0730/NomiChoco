//
//  matchcheckViewController.swift
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/02/28.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

import Foundation

class matchcheckViewController: UIViewController {
    
    
    @IBAction func ButtonTouched(sender: AnyObject) {
        let matching = TemplateMatch()
        let sampleImage:UIImage? = UIImage(named: "tozurusample.jpg")
        if let useImage = sampleImage {
            matching.recognizeMatch(useImage)
        }
    }
}