//
//  GameScene.swift
//  FlappySeaver
//
//  Created by Brian Seaver on 3/31/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let cam = SKCameraNode()
    var block = SKSpriteNode()
    var barriers : [SKSpriteNode] = []
    var hit = false
    var gameOverLabel = SKLabelNode()
    
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
        self.camera = cam
        block = self.childNode(withName: "block") as! SKSpriteNode
        gameOverLabel = self.childNode(withName: "gameOver") as! SKLabelNode
        gameOverLabel.isHidden = true
        for i in 1...5{
            barriers.append(self.childNode(withName: "yellow\(i)") as! SKSpriteNode)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        for barrier in barriers{
            if contact.bodyA.node!.name! == barrier.name || contact.bodyB.node!.name! == barrier.name{
                print("Hit Barrier")
                hit = true
                block.physicsBody?.affectedByGravity = false
                block.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                gameOverLabel.position = cam.position
                gameOverLabel.isHidden = false
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        cam.position.x = block.position.x + 500
    }
    
    
}
