//
//  GameViewController.swift
//  FlappySeaver
//
//  Created by Brian Seaver on 3/31/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var jumpButtonOutlet: UIButton!
    var play : GameScene!
    var timer = Timer()
    var time = 0.0
    
    @IBOutlet weak var resetOutlet: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        resetOutlet.isHidden = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ tempTimer in
            self.time += 0.01
            self.time = round(self.time * 100.0)/100.0
            self.timerLabel.text = "\(self.time)"
            if self.play.hit{
                self.timer.invalidate()
                self.resetOutlet.isHidden = false
            }
        }
       
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                play = sceneNode
                // Copy gameplay related content over to the scene
               // sceneNode.entities = scene.entities
                //sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscapeRight
        } else {
            return .landscapeRight
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    
    @IBAction func jumpButtonDownAction(_ sender: UIButton) {
        play.block.physicsBody?.velocity.dy = CGFloat(700.0)
    }
    
    
    @IBAction func resetAction(_ sender: UIButton) {
        time = 0
        play.hit = false
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ tempTimer in
            self.time += 0.01
            self.time = round(self.time * 100.0)/100.0
            self.timerLabel.text = "\(self.time)"
            if self.play.hit{
                self.timer.invalidate()
                self.resetOutlet.isHidden = false
            }
        }
        play.block.position = CGPoint(x: -545, y: 71)
        play.block.physicsBody?.velocity.dx = 500.0
        play.block.physicsBody?.affectedByGravity = true
        play.gameOverLabel.isHidden = true
        resetOutlet.isHidden = true
    }
}
