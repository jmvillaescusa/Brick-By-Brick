//
//  GameScene.swift
//  Brick by Brick
//
//  Created by Jaimeson Mario Villaescusa on 2019-06-25.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var l = L()
    //var j = letterJ()
    var o = O()
    var z = Z()
    
    var base = Base()
    var fallingBlock = SKSpriteNode()
    var tetrisBlocks = [SKSpriteNode]()
    
    
    override func didMove(to view: SKView) {
        SpawnBlock()
        base.setup()
        base.zPosition = 1
        addChild(base)
    }
    
    func SpawnBlock(){
        z.setup()
        z.zPosition = 1
        addChild(z)
        
        o.setup()
        addChild(o)
    }
    
    func rotateLeft(){
        fallingBlock.zRotation = 90
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        print(l)
    }
}
