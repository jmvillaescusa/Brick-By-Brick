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
    
    var base = Base()
    
    
    //var spawnedBlock: Bool = false
    
    let screenSize: CGRect = UIScreen.main.bounds
    var spawnLocation = CGPoint(x: 0, y: -10)
    
    //var lArray = SKSpriteNode[100]()
    //struct Array <SKSpriteNode>
    
    var fallingBlock = SKSpriteNode()
    var fallingSpeed: CGFloat = 5
    var tetrisBlocks = [SKSpriteNode]()
    
    //UI Buttons
    let rotateLeft = SKSpriteNode(imageNamed: "left")
    let rotateRight = SKSpriteNode(imageNamed: "right")
    let holdPiece = SKSpriteNode(imageNamed: "hold") //Doesn't do anything yet
    
    //Movement
    var movingDown: Bool = false
    var movingLeft: Bool = false
    var movingRight: Bool = false
    
    override func didMove(to view: SKView) {
        setupButton()
        base.setup()
        base.zPosition = 1
        addChild(base)
        
        dropBlock()
    }
    
    func SpawnBlock(){
        spawnLocation = CGPoint(x: screenSize.width * 0.3, y: screenSize.height + 50)
        
        let randNum = Int.random(in: 0..<7)
        if (randNum == 0){ letterL() }        
        if (randNum == 1){ letterI() }
        if (randNum == 2){ letterJ() }
        if (randNum == 3){ letterO() }
        if (randNum == 4){ letterS() }
        if (randNum == 5){ letterT() }
        if (randNum == 6){ letterZ() }
    }
    
    func dropBlock(){
        let SpawnBlock = SKAction.run{
            self.SpawnBlock()
        }
        let repeatNewBlock = SKAction.repeatForever(SKAction.sequence([SpawnBlock, SKAction.wait(forDuration: 5)]))
        
        run(repeatNewBlock)
    }
    
    func letterL(){
        var l = L()
        l.setup()
        l.zPosition = 1
        l.position = spawnLocation
        fallingBlock = l
        
        addChild(l)
    }
    
    func letterZ(){
        var z = Z()
        z.setup()
        z.zPosition = 1
        z.position = spawnLocation
        fallingBlock = z
        
        addChild(z)
    }
    
    func letterO(){
        var o = O()
        o.setup()
        o.zPosition = 1
        o.position = spawnLocation
        fallingBlock = o
        
        addChild(o)
    }
    
    func letterJ(){
        var j = J()
        j.setup()
        j.zPosition = 1
        j.position = spawnLocation
        fallingBlock = j
        
        addChild(j)
    }
    
    func letterS(){
        var s = S()
        s.setup()
        s.zPosition = 1
        s.position = spawnLocation
        fallingBlock = s
        
        addChild(s)
    }
    
    func letterT(){
        var t = T()
        t.setup()
        t.zPosition = 1
        t.position = spawnLocation
        fallingBlock = t
        
        addChild(t)
    }
    
    func letterI(){
        var i = I()
        i.setup()
        i.zPosition = 1
        i.position = spawnLocation
        fallingBlock = i
        
        addChild(i)
    }
    
    func turnLeft() {
        fallingBlock.zRotation = fallingBlock.zRotation + CGFloat(90).degreesToRadians
    }
    func turnRight() {
        fallingBlock.zRotation = fallingBlock.zRotation - CGFloat(90).degreesToRadians
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //fallingBlock.position.y -= fallingSpeed
    }
    
    func setupButton() {
        rotateLeft.position = CGPoint(x: -250, y: -775)
        rotateLeft.zPosition = 100
        addChild(rotateLeft)
        
        rotateRight.position = CGPoint(x: 250, y: -775)
        rotateRight.zPosition = 100
        addChild(rotateRight)
        
        holdPiece.position = CGPoint(x: 0, y: -775)
        holdPiece.zPosition = 100
        addChild(holdPiece)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if (rotateLeft.frame.contains(location)){
                turnLeft()
            } else if (rotateRight.frame.contains(location)) {
                turnRight()
            } else if (holdPiece.frame.contains(location)) {
                print("piece held")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let newlocation = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            
            
            if (!rotateLeft.frame.contains(newlocation) && !rotateRight.frame.contains(newlocation) && !holdPiece.frame.contains(newlocation)) {
                if (newlocation.y < previousLocation.y - 20) {
                    movingDown = true
                }
                else if (newlocation.x > previousLocation.x) {
                    movingRight = true
                } else if (newlocation.x < previousLocation.x) {
                    movingLeft = true
                }
                
                if (movingDown && !movingRight && !movingLeft) {
                    //fallingBlock.position.y -= 40
                }
                if (movingRight && !movingLeft && !movingDown) {
                    fallingBlock.position.x += 25
                }
                if (movingLeft && !movingRight && !movingDown) {
                    fallingBlock.position.x -= 25
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches { fallingSpeed = 5 }
        movingDown = false
        movingLeft = false
        movingRight = false
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
