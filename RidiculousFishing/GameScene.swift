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
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.white;
        
        hook.position = CGPoint(x:self.size.width/2,
        y:700)
        addChild(hook)
        
        // write the code to generate a fishes
        let generateFish1Sequence = SKAction.sequence(
            [
                SKAction.run {
                    [weak self] in self?.makeFish1()
                },
                SKAction.wait(forDuration: 3)
            ]
        )
        self.run(SKAction.repeatForever(generateFish1Sequence))
        
        let generateFish2Sequence = SKAction.sequence(
            [
                SKAction.run {
                    [weak self] in self?.makeFish2()
                },
                SKAction.wait(forDuration: 2)
            ]
        )
        self.run(SKAction.repeatForever(generateFish2Sequence))

        let generateFish3Sequence = SKAction.sequence(
            [
                SKAction.run {
                    [weak self] in self?.makeFish3()
                },
                SKAction.wait(forDuration: 5)
            ]
        )
        self.run(SKAction.repeatForever(generateFish3Sequence))
        
    }
    
    func makeFish1() {
        // lets add some cats
        let fish1 = SKSpriteNode(imageNamed: "fish1")
        
        // generate a random (x,y) for the cat
        let randX = Int(CGFloat(arc4random_uniform(UInt32(self.size.width ))))
        let randY = Int(CGFloat(arc4random_uniform(UInt32(self.size.height ))))
        
        fish1.position = CGPoint(x:randX, y:randY)
        
        addChild(fish1)
        
        //print("Where is cat? \(randX), \(randY)")
    }
    
    func makeFish2(){
        let fish2 = SKSpriteNode(imageNamed: "fish2")
        
        let randX = Int(CGFloat(arc4random_uniform(UInt32(self.size.width))))
        let randY = Int(CGFloat(arc4random_uniform(UInt32(self.size.height))))
        
        fish2.position = CGPoint(x:randX, y:randY)
        
        addChild(fish2)
    }
    
    func makeFish3(){
        let fish3 = SKSpriteNode(imageNamed: "fish3")
        
        let randX = Int(CGFloat(arc4random_uniform(UInt32(self.size.width))))
        let randY = Int(CGFloat(arc4random_uniform(UInt32(self.size.height))))
        
        fish3.position = CGPoint(x:randX, y:randY)
        
        addChild(fish3)
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        //self.makefishes()
        
    }
}
