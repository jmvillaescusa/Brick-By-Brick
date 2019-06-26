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
    var j = J()
    var o = O()
    
    var base = Base()
    
    var tetrisBlocks = [SKSpriteNode]()
    
    let rotateLeft = SKSpriteNode(imageNamed: "LetterO")
    
    override func didMove(to view: SKView) {
        SpawnBlock()
        setupButton()
        base.setup()
        base.zPosition = 1
        addChild(base)
    }
    
    func SpawnBlock(){
        l.setup()
        l.zPosition = 1
        addChild(l)
        
        o.setup()
        addChild(o)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //print(l)
    }
    
    func setupButton() {
        rotateLeft.position = CGPoint(x: 100, y: 100)
        rotateLeft.size = CGSize(width: 50, height: 50)
        rotateLeft.zPosition = 100
        rotateLeft.name = "left"
        addChild(rotateLeft)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touch = touches.first!
        //if rotateLeft.containsPoint(touch.locationInNode(self)) {
           // print("touched")
        //}
    }
}
