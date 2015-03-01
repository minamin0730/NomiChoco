//
//  ResultScene.swift
//  block3
//
//  Created by itsuki on 2015/03/01.
//  Copyright (c) 2015年 itsuki. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene{
    let button = UIButton()
    let bg = SKSpriteNode(imageNamed: "okaikei.png")
    override func didMoveToView(view: SKView) {
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(640, 1136)
        self.bg.zPosition = 0
        self.addChild(bg)
        
        self.button.setTitle("決定", forState: .Normal)
        self.button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.button.frame = CGRectMake(0, 0, 100, 50)
        self.button.layer.position = CGPoint(x: CGRectGetMidX(self.frame), y:500)
        self.button.backgroundColor = UIColor.whiteColor()
        self.button.layer.cornerRadius = 10
        self.button.addTarget(self, action: "down:", forControlEvents: .TouchDown)
    }
    
    func down(sender: UIButton){
        
        
    }
}
