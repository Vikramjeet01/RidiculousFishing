//
//  GameViewController.swift
//  RidiculousFishing
//
//  Created by INDRAVADAN SHRIMALI on 2019-10-13.
//  Copyright © 2019 INDRAVADAN SHRIMALI. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var musicEffect:AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size:self.view.bounds.size)
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        
        do{
            let musicFile = Bundle.main.path(forResource: "sound", ofType: "mp3")

           try musicEffect =  AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile!) as URL)
           
        }
        catch{
            print(error)
        }
        
        musicEffect.play()
        
        // property to show hitboxes
        skView.showsPhysics = true
        
        skView.presentScene(scene)
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
