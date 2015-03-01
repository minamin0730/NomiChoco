//
//  ResultScene.swift
//  block3
//
//  Created by itsuki on 2015/03/01.
//  Copyright (c) 2015年 itsuki. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene{
    let buttonC = UIButton()
    var save: NSUserDefaults!
    var score: Int = 0
    var resultmes = SKLabelNode()
    let bg = SKSpriteNode(imageNamed: "okaikei.png")
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func didMoveToView(view: SKView) {
        if appDelegate.score != nil{
            self.score = appDelegate.score!
        }else{
            self.score = 0
        }

        
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(640, 1136)
        self.bg.zPosition = 0
        self.addChild(bg)
        
        self.resultmes.position = CGPointMake(CGRectGetMidX(self.frame)-10, CGRectGetMidY(self.frame))
        self.resultmes.fontColor = UIColor.blackColor()
        self.resultmes.fontName = "Marion-Bold"
        self.resultmes.text = String(self.score)
        self.resultmes.fontSize = 100
        self.resultmes.zPosition = 1.0
        self.addChild(self.resultmes)
        
        
        self.buttonC.setTitle("リトライ", forState: .Normal)
        self.buttonC.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonC.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonC.frame = CGRectMake(0, 0, 100, 50)
        self.buttonC.layer.position = CGPoint(x: 160, y:500)
        self.buttonC.backgroundColor = UIColor.whiteColor()
        self.buttonC.layer.cornerRadius = 10
        self.buttonC.addTarget(self, action: "down:", forControlEvents: .TouchDown)
        self.view?.addSubview(buttonC)
    }
    
    func down(sender: UIButton){
        self.removeAllActions()
        self.removeAllChildren()
        self.buttonC.removeFromSuperview()
        
        let newScene = GameScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
}
