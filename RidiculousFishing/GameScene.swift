//
//  GameScene.swift
//  RidiculousFishing
//
//  Created by INDRAVADAN SHRIMALI on 2019-10-13.
//  Copyright © 2019 INDRAVADAN SHRIMALI. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate  {
    
    let hook = SKSpriteNode(imageNamed: "hook")
    //let background1 = SKSpriteNode(imageNamed: "b")
    //let background2 = SKSpriteNode(imageNamed: "b")
    
    var xd:CGFloat = 0
    var yd:CGFloat = 0
    
    // GAME STAT SPRITES
    let scoreLabel = SKLabelNode(text: "Score: ")
    
    var score = 0
    
    override func didMove(to view: SKView) {

        
        self.backgroundColor = SKColor.white;
        
        /*background1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background1.position = CGPoint(x: size.width/2, y: size.height/2)
        background1.zPosition = -1
        addChild(background1)
        
        background2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background2.position = CGPoint(x: size.width/2, y: size.height/2)
        background2.zPosition = -1
        addChild(background2)*/
        
        hook.position = CGPoint(x:self.size.width/2,
        y:550)
        addChild(hook)
        
        self.scoreLabel.text = "Score: \(self.score)"
        self.scoreLabel.fontName = "Avenir-Bold"
        self.scoreLabel.fontColor = UIColor.magenta
        self.scoreLabel.fontSize = 20;
        self.scoreLabel.position = CGPoint(x:70,
                                           y:640)
        
        
        addChild(self.scoreLabel)
        
        //createBackground()
        createSecondBackground()
        
        
    }//did move ended
    
    func createBackground() {
        let backgroundTexture = SKTexture(imageNamed: "b")

        for i in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -1
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint(x: 0, y: (backgroundTexture.size().height * CGFloat(i)) - CGFloat(1 * i))
            addChild(background)
            
            let moveUp = SKAction.moveBy(x: 0, y: backgroundTexture.size().height, duration: 3)
            let moveReset = SKAction.moveBy(x: 0, y: -backgroundTexture.size().height, duration: 0)
            let moveLoop = SKAction.sequence([moveUp, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)

            background.run(moveForever)
        }
    }
    
    func createSecondBackground() {
        let backgroundTexture = SKTexture(imageNamed: "b")

        for i in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -1
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint(x: 0, y: (backgroundTexture.size().height * CGFloat(i)) - CGFloat(1 * i))
            addChild(background)
            
            let moveDown = SKAction.moveBy(x: 0, y: -backgroundTexture.size().height, duration: 3)
            let moveReset = SKAction.moveBy(x: 0, y: backgroundTexture.size().height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)

            background.run(moveForever)
        }
    }
    
    var fishes1:[SKSpriteNode] = []
    var fishes2:[SKSpriteNode] = []
    var fishes3:[SKSpriteNode] = []
    
    func makeFish1() {
        let fish1 = SKSpriteNode(imageNamed: "fish1")
        
        // generate a random (x,y) for the cat
        let randX = Int(CGFloat(arc4random_uniform(UInt32(self.size.width ))))
        let randY = Int(CGFloat(arc4random_uniform(UInt32(self.size.height ))))
        
        fish1.position = CGPoint(x:randX, y:randY)
        
        addChild(fish1)
        
        self.fishes1.append(fish1)
    }
    
    func makeFish2(){
        let fish2 = SKSpriteNode(imageNamed: "fish2")
        
        let randX = Int(CGFloat(arc4random_uniform(UInt32(self.size.width))))
        let randY = Int(CGFloat(arc4random_uniform(UInt32(self.size.height))))
        
        fish2.position = CGPoint(x:randX, y:randY)
        
        addChild(fish2)
        
        self.fishes2.append(fish2)
    }
    
    func makeFish3(){
        let fish3 = SKSpriteNode(imageNamed: "fish3")
        
        let randX = Int(CGFloat(arc4random_uniform(UInt32(self.size.width))))
        let randY = Int(CGFloat(arc4random_uniform(UInt32(self.size.height))))
        
        fish3.position = CGPoint(x:randX, y:randY)
        
        addChild(fish3)
        
        self.fishes3.append(fish3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let locationTouched = touches.first

        if (locationTouched == nil) {
            // This is error handling
            // Sometimes the mouse detection doesn't work properly
            // and IOS can't get the position.
            return
        }
        
        let mousePosition = locationTouched!.location(in:self)
        
        
        // calculate those math variables (d, xd, yd)
        // (x2-x1)
        let a = mousePosition.x - self.hook.position.x
        // (y2-y1)
        let b = mousePosition.y - self.hook.position.y
        // d
        let d = sqrt( (a*a) + (b*b))
        
        self.xd = a/d
        self.yd = b/d
        
    }
    
    var timeOfLastUpdate:TimeInterval?
    
    override func update(_ currentTime: TimeInterval) {
        
        self.hook.position.x = self.hook.position.x + self.xd * 2
        self.hook.position.y = self.hook.position.y + self.yd * 2
        
        if (timeOfLastUpdate == nil) {
            timeOfLastUpdate = currentTime
        }
        // print a message every 3 seconds
        var timePassed = (currentTime - timeOfLastUpdate!)
        if (timePassed >= 2) {
            //print("HERE IS A MESSAGE!")
            timeOfLastUpdate = currentTime
            // make a cat
            self.makeFish1()
            self.makeFish2()
            self.makeFish3()
        }
        
        for (arrayIndex, fish1) in fishes1.enumerated() {
            if (self.hook.intersects(fish1) == true) {
                // 1. increase the score
                self.score = self.score + 1
                self.scoreLabel.text = "Score: \(self.score)"
                // ---- 2a. remove from the array
                self.fishes1.remove(at: arrayIndex)
                // ---- 2b. remove from scene (undraw the cat)
                fish1.removeFromParent()
            }
        }
        
        for (arrayIndex, fish2) in fishes2.enumerated() {
            if (self.hook.intersects(fish2) == true) {
                //print("CAT COLLISION DETECTED!")
                // 1. increase the score
                self.score = self.score + 2
                self.scoreLabel.text = "Score: \(self.score)"
                // ---- 2a. remove from the array
                self.fishes2.remove(at: arrayIndex)
                // ---- 2b. remove from scene (undraw the cat)
                fish2.removeFromParent()
            }
        }
        
        for (arrayIndex, fish3) in fishes3.enumerated() {
            if (self.hook.intersects(fish3) == true) {
                //print("CAT COLLISION DETECTED!")
                // 1. increase the score
                self.score = self.score + 3
                self.scoreLabel.text = "Score: \(self.score)"
                // ---- 2a. remove from the array
                self.fishes3.remove(at: arrayIndex)
                // ---- 2b. remove from scene (undraw the cat)
                fish3.removeFromParent()
            }
        }
        
    }
}
