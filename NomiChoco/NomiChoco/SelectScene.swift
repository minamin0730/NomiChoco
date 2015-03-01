//
//  SelectScene.swift
//  block3
//
//  Created by itsuki on 2015/03/01.
//  Copyright (c) 2015年 itsuki. All rights reserved.
//

import SpriteKit

class SelectScene: SKScene{
    var table: SKShapeNode!
    let radius: CGFloat = 200.0
    var stagenum: Int = 1
    let buttonR = UIButton()
    let buttonL = UIButton()
    let buttonC = UIButton()
    let Texture = SKTexture(imageNamed: "50mujitable.png")
    let bg1 = SKSpriteNode(imageNamed: "kaiten.png")
    let bg2 = SKSpriteNode(imageNamed: "tatami.jpg")
    
    override func didMoveToView(view: SKView) {
        self.bg1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg1.size = CGSizeMake(640, 1136)
        self.bg1.zPosition = 1.0
        self.addChild(bg1)
        self.bg2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg2.size = CGSizeMake(640, 1136)
        self.bg2.zPosition = 0
        self.addChild(bg2)
        
        self.buttonR.setTitle("右", forState: .Normal)
        self.buttonL.setTitle("左", forState: .Normal)
        self.buttonC.setTitle("決定", forState: .Normal)
        self.buttonR.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonL.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonC.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonR.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonL.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonC.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonR.frame = CGRectMake(0,0,100,50)
        self.buttonL.frame = CGRectMake(0,0,100,50)
        self.buttonC.frame = CGRectMake(0, 0, 50, 50)
        self.buttonR.layer.position = CGPoint(x: 250, y: 500)
        self.buttonL.layer.position = CGPoint(x: 70, y: 500)
        self.buttonC.layer.position = CGPoint(x: 160, y:500)
        self.buttonR.backgroundColor = UIColor.whiteColor()
        self.buttonL.backgroundColor = UIColor.whiteColor()
        self.buttonC.backgroundColor = UIColor.whiteColor()
        self.buttonR.layer.cornerRadius = 10
        self.buttonL.layer.cornerRadius = 10
        self.buttonC.layer.cornerRadius = 10
        self.buttonR.addTarget(self, action: "downR:", forControlEvents: .TouchDown)
        self.buttonL.addTarget(self, action: "downL:", forControlEvents: .TouchDown)
        self.buttonR.addTarget(self, action: "upR:", forControlEvents: .TouchUpInside)
        self.buttonL.addTarget(self, action: "upL:", forControlEvents: .TouchUpInside)
        self.buttonC.addTarget(self, action: "downC:", forControlEvents: .TouchDown)
        
        self.view?.addSubview(buttonR)
        self.view?.addSubview(buttonL)
        self.view?.addSubview(buttonC)
        
        addTable()
    }
    
    private func addTable(){
        table = SKShapeNode(circleOfRadius: radius)
        table.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        table.fillColor = UIColor.brownColor()
        table.strokeColor = UIColor.brownColor()
        table.fillTexture = self.Texture
        
        table.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        table.physicsBody?.dynamic = false
        table.zPosition = 2.0
        
        addChild(table)
        
    }
    
    func downR(sender: UIButton){
        let move = SKAction.rotateByAngle( CGFloat(-M_PI/2), duration: 1.5)
        self.table.runAction(move)
        if stagenum == 4{
            stagenum = 1
        }else{
            stagenum++
        }
    }
    
    func downL(sender: UIButton){
        let move = SKAction.rotateByAngle( CGFloat(M_PI/2), duration: 1.5)
        self.table.runAction(move)
        if stagenum == 1{
            stagenum = 4
        }else{
            stagenum--
        }
    }
    
    func downC(sender: UIButton){
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.stagenum = self.stagenum
        
        self.buttonR.removeFromSuperview()
        self.buttonL.removeFromSuperview()
        self.buttonC.removeFromSuperview()
        
        let newScene = GameScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    func upR(sender: UIButton){

    }
    
    func upL(sender: UIButton){

    }
    
}

