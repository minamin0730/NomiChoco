//
//  GameScene.swift
//  block3
//
//  Created by itsuki on 2015/02/26.
//  Copyright (c) 2015年 itsuki. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let blockCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 1
    let paddleCategory: UInt32 = 0x1 << 2
    let startmes = SKLabelNode()
    var stage: Int = 0
    var paddle: SKSpriteNode!
    var blocks = [SKShapeNode]()
    var balls = [SKShapeNode]()
    var score: Int = 0
    var stagenum: Int = 0
    let radius: CGFloat = 40.0
    let numberOfBlocks = 1
    let numberOfBalls = 1
    let ballSpeed: Double = 600.0
    let scoreLabel = SKLabelNode()
    let buttonR = UIButton()
    let buttonL = UIButton()
  //  var charanum : Int = 0
    var Texture: SKTexture!
    let hashi = SKTexture(imageNamed: "50hashi.png")
    let bg = SKSpriteNode(imageNamed: "bg.png")
//    let sound = SKAction.playSoundFileNamed("game.mp3", waitForCompletion: true)
    var player : AVAudioPlayer! = nil

    
    override func didMoveToView(view: SKView) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if appDelegate.stagenum == nil{
            self.stagenum = 1
        }else{
            self.stagenum = appDelegate.stagenum!
        }
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("game", ofType: "mp3")!)
        player = AVAudioPlayer(contentsOfURL: audioPath, error: nil)
        player.prepareToPlay()
        player.play()
//        self.runAction(sound)
        
        start_gamen()
        
       // self.charanum = 2
        
        if appDelegate.charaId == 1 {
            self.Texture = SKTexture(imageNamed: "ball_tsuki.png")
        }else if appDelegate.charaId == 2{
            self.Texture = SKTexture(imageNamed: "ball_momo.png")
        }else if appDelegate.charaId == 3{
            self.Texture = SKTexture(imageNamed: "ball_tozuru.png")
        }else if appDelegate.charaId == 4{
            self.Texture = SKTexture(imageNamed: "ball_eikun.png")
        }
        
        var Points1 = [CGPointMake(0.0, 250.0),CGPointMake(200.0, self.size.height)]
        let Line1 = SKShapeNode(points: &Points1, count: UInt(Points1.count))
        Line1.position = CGPointMake(0.0, 30.0)
        Line1.strokeColor = UIColor.clearColor()
        Line1.physicsBody = SKPhysicsBody(edgeFromPoint: CGPointMake(0.0,250), toPoint: CGPointMake(200.0, self.size.height))
        Line1.physicsBody!.dynamic = false
        Line1.zPosition = 1.0
        self.addChild(Line1)
        
        var Points2 = [CGPointMake(self.size.width, 250.0),CGPointMake(445.0, self.size.height)]
        let Line2 = SKShapeNode(points: &Points2, count: UInt(Points2.count))
        Line2.position = CGPointMake(0.0,30.0)
        Line2.strokeColor = UIColor.clearColor()
        Line2.physicsBody = SKPhysicsBody(edgeFromPoint: CGPointMake(self.size.width, 250.0), toPoint: CGPointMake(445.0, self.size.height))
        Line2.zPosition = 1.0
        self.addChild(Line2)
        
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(640, 1136)
        self.bg.zPosition = 0
        self.addChild(bg)
        
        
        
        self.scoreLabel.position = CGPointMake(self.size.width-70, self.size.height-100)
        self.scoreLabel.fontColor = UIColor.whiteColor()
        self.scoreLabel.text = "0"
        self.scoreLabel.fontSize = 100
        self.scoreLabel.zPosition = 2.0
        self.addChild(self.scoreLabel)
        
        self.buttonR.setTitle("右", forState: .Normal)
        self.buttonL.setTitle("左", forState: .Normal)
        self.buttonR.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonL.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonR.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonL.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonR.frame = CGRectMake(0,0,100,50)
        self.buttonL.frame = CGRectMake(0,0,100,50)
        self.buttonR.layer.position = CGPoint(x: 250, y: 500)
        self.buttonL.layer.position = CGPoint(x: 70, y: 500)
        self.buttonR.backgroundColor = UIColor.whiteColor()
        self.buttonL.backgroundColor = UIColor.whiteColor()
        self.buttonR.layer.cornerRadius = 10
        self.buttonL.layer.cornerRadius = 10
        self.buttonR.addTarget(self, action: "downR:", forControlEvents: .TouchDown)
        self.buttonL.addTarget(self, action: "downL:", forControlEvents: .TouchDown)
        self.buttonR.addTarget(self, action: "upR:", forControlEvents: .TouchUpInside)
        self.buttonL.addTarget(self, action: "upL:", forControlEvents: .TouchUpInside)

        self.view?.addSubview(buttonR)
        self.view?.addSubview(buttonL)
        
        
        self.paddle = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(110, 40))
        self.paddle.position = CGPointMake(CGRectGetMidX(self.frame), 250.0)
        self.paddle.texture = self.hashi
        self.paddle.physicsBody = SKPhysicsBody(rectangleOfSize: self.paddle.size)
        self.paddle.physicsBody!.dynamic = false
        self.paddle.physicsBody?.categoryBitMask = paddleCategory
        self.paddle.zPosition = 1.0
        self.addChild(paddle)
        
        addBlock()
    }
    
    private func start_gamen(){
        self.startmes.text = "START"
        self.startmes.fontSize = 90
        self.startmes.fontName = "Marion-Bold"
        self.startmes.position = CGPointMake(-80, CGRectGetMidY(self.frame))
        self.startmes.zPosition = 2.0
        self.addChild(startmes)
        
        let move1 = SKAction.moveByX(400, y: 0, duration: 1)
        let move2 = SKAction.waitForDuration(2)
        let move3 = SKAction.moveByX(600, y: 0, duration: 1.5)
        let seq = SKAction.sequence([move1,move2,move3])
        self.startmes.runAction(seq)
    }
    
    private func addBlock(){
        var cnt: Int = 0
//        for i in 0..<self.numberOfBlocks{
//            let block = SKShapeNode(rectOfSize: CGSizeMake(50, 20))
//            var row: Int = i / 7
//            if cnt / 7 != 0{
//                cnt = 0
//            }
//            block.position = CGPointMake(40 + (90*CGFloat(cnt)), self.size.height - 30 - (30*CGFloat(row)))
//            block.fillColor = UIColor.blueColor()
//            block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 20))
//            block.physicsBody!.dynamic = false
//            block.physicsBody?.categoryBitMask = blockCategory
//            block.physicsBody?.collisionBitMask = ballCategory
//            block.physicsBody?.contactTestBitMask = ballCategory
//            
//            block.zPosition = 1.0
//            self.addChild(block)
//            self.blocks.append(block)
//            cnt++
//        }
        for i in 0..<self.numberOfBlocks{
            let block = SKShapeNode(rectOfSize: CGSizeMake(50, 20))
            if self.stagenum == 1{
                block.position = CGPointMake(150,300)
            }else if stagenum == 2{
                block.position = CGPointMake(300, 500)
            }else if stagenum == 3{
                block.position = CGPointMake(450, 700)
            }else if stagenum == 4{
                block.position = CGPointMake(150, 200)
            }

//            block.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
            block.fillColor = UIColor.blueColor()
            block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 20))
            block.physicsBody!.dynamic = false
            block.physicsBody?.categoryBitMask = blockCategory
            block.physicsBody?.collisionBitMask = ballCategory
            block.physicsBody?.contactTestBitMask = ballCategory
            
            block.zPosition = 1.0
            self.addChild(block)
            self.blocks.append(block)
            cnt++
        }
    }
    private func addBall(){
        var directionX: Double = 1;
        for i in 0..<self.numberOfBalls{
            let ball = SKShapeNode(circleOfRadius: radius)
            ball.position = CGPointMake(CGRectGetMidX(self.paddle.frame), CGRectGetMaxY(self.paddle.frame) + radius)
            ball.fillColor = UIColor.whiteColor()
            ball.strokeColor = UIColor.whiteColor()
            ball.fillTexture = Texture
            
            ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            
            let randX = arc4random_uniform(10) + 10
            let randY = arc4random_uniform(10) + 10
            let randV = sqrt(Double(randX * randX + randY * randY))
            let speedX = Double(randX) * self.ballSpeed / randV
            let speedY = Double(randY) * self.ballSpeed / randV
            ball.physicsBody!.velocity = CGVectorMake(CGFloat(speedX * directionX), CGFloat(speedY))
            directionX *= -1
            
            ball.physicsBody!.affectedByGravity = false
            ball.physicsBody!.restitution = 1.0
            ball.physicsBody!.linearDamping = 0
            ball.physicsBody!.friction = 0
            ball.physicsBody!.allowsRotation = false
            ball.physicsBody!.usesPreciseCollisionDetection = true
            ball.physicsBody?.categoryBitMask = ballCategory
            ball.physicsBody?.contactTestBitMask = blockCategory
            
            ball.zPosition = 1.0
            self.addChild(ball)
            self.balls.append(ball)
            
        }
    }
    
    func downR(sender: UIButton){
        if self.paddle.position.x < self.size.width-50{
            let move = SKAction.moveByX(400.0, y: 0, duration: 1.0)
            let repmove = SKAction.repeatActionForever(move)
            self.paddle.runAction(repmove)
        }
    }
    
    func downL(sender: UIButton){
        if self.paddle.position.x > 50{
            let move = SKAction.moveByX(-400.0, y: 0, duration: 1.0)
            let repmove = SKAction.repeatActionForever(move)
            self.paddle.runAction(repmove)
        }
    }
    
    func upR(sender: UIButton){
        self.paddle.removeAllActions()
    }
    
    func upL(sender: UIButton){
        self.paddle.removeAllActions()
    }
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        if self.balls.count == 0 {
//            // 中略
//        } else {
//            super.touchesBegan(touches, withEvent: event)
//            
//            let touch = touches.anyObject() as UITouch
//            let location = touch.locationInNode(self)
//            let speed: CGFloat = 0.001
//            let duration = NSTimeInterval(abs(location.x - self.paddle.position.x) * speed)
//            let move = SKAction.moveToX(location.x, duration: duration)
//            self.paddle.runAction(move)
//        }
//    }
    
    func didBeginContact(contact: SKPhysicsContact!) {
        
        var firstBody, secondBody: SKPhysicsBody
        
        //first=ball,second=block
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // ballとblockが接したときの処理。
        if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & blockCategory != 0 {
                secondBody.node?.removeFromParent()
                score++
        }
    }
    
    override func didSimulatePhysics() {
        var removed = [Int]()
        for i in 0..<balls.count {
            let ball = balls[i]
            if ball.position.y < self.radius * 3 {
                let sparkNode = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("spark", ofType: "sks")!)  as SKEmitterNode
                sparkNode.position = ball.position
                sparkNode.xScale = 0.3
                sparkNode.yScale = 0.3
                self.addChild(sparkNode)
                let fadeOut = SKAction.fadeOutWithDuration(0.3)
                let remove = SKAction.removeFromParent()
                sparkNode.runAction(SKAction.sequence([fadeOut, remove]))
                removed.append(i)
                ball.removeFromParent()
                
            } else {
                let threashold = CGFloat(ballSpeed * 0.1)
                if abs(ball.physicsBody!.velocity.dx) < threashold {
                    let vY  = Double(ball.physicsBody!.velocity.dy) * 0.8
                    ball.physicsBody!.velocity.dx = CGFloat(sqrt(ballSpeed * ballSpeed - vY * vY))
                    ball.physicsBody!.velocity.dy = CGFloat(vY)
                }
                if (abs(ball.physicsBody!.velocity.dy) <  threashold) {
                    let vX = Double(ball.physicsBody!.velocity.dx) * 0.8
                    ball.physicsBody!.velocity.dx = CGFloat(vX)
                    ball.physicsBody!.velocity.dy = CGFloat(sqrt(ballSpeed * ballSpeed - vX * vX))
                }
            }
        }
        for i in removed {
            balls.removeAtIndex(i)
        }
    }
    override func update(currentTime: CFTimeInterval) {
        self.scoreLabel.text = score.description
        
        if self.paddle.position.x < 50{
            self.paddle.position = CGPointMake(50.0,self.paddle.position.y)
        }
        
        if self.paddle.position.x > self.size.width - 50{
            self.paddle.position = CGPointMake(self.size.width-50.0 , self.paddle.position.y)
        }
        
        if self.startmes.position.x > 800{
            if stage == 0{
                addBall()
            }
            stage = 1
        }
        
        if self.balls.count == 0 && stage == 1{
            self.buttonR.removeFromSuperview()
            self.buttonL.removeFromSuperview()
            let newScene = ResultScene(size: self.size)
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view?.presentScene(newScene)
        }
        
        if self.score == 1{
            self.buttonR.removeFromSuperview()
            self.buttonL.removeFromSuperview()
            let newScene = SelectScene(size: self.size)
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view?.presentScene(newScene)

        }
        
    }
}
