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
    
    let screenSize: CGRect = UIScreen.main.bounds
    var spawnLocation = CGPoint(x: 0, y: 0)
    
    var fallingBlock = SKSpriteNode()
    var savedBlock = SKSpriteNode()
    var nextBlock = SKSpriteNode()
    var showingNext = SKSpriteNode()
    
    var droppableBlocks = [SKSpriteNode]()
    
    
    
    override func didMove(to view: SKView) {
        base.setup()
        base.zPosition = 1
        addChild(base)
        
        showingNext = childNode(withName: "NextBlockShowing") as! SKSpriteNode
        
        
        fillBlockArray()
        if (droppableBlocks.count > 2){
                dropBlock()
        }
    }
    
    // This creates a block for the array to spawn
    func createBlock(){
            spawnLocation = CGPoint(x: screenSize.width * 0.3, y: screenSize.height + 50)
            var randNum = Int.random(in: 0..<7)
            if (randNum == 0){
                letterL()
            }
            if (randNum == 1){
                letterI()
            }
            if (randNum == 2){
                letterJ()
            }
            if (randNum == 3){
                letterO()
            }
            if (randNum == 4){
                letterS()
            }
            if (randNum == 5){
                letterT()
            }
            if (randNum == 6){
                letterZ()
            }
    }
    
    func updateNextBlock(){
        showingNext.texture = droppableBlocks[1].texture
    }
    
    // this spawns a block from the first element of the array
    //also, sets falling block to the dropped block, the next block to next block
    func SpawnBlock(){
        fallingBlock = droppableBlocks[0]
        updateNextBlock()
        droppableBlocks[0].position = spawnLocation
        addChild(droppableBlocks[0])
        droppableBlocks.remove(at: 0)
    }
    
    // this is a endless loop that spawns the blocks
    func dropBlock(){
        let CreateBlock = SKAction.run{
            self.createBlock()
        }
        
        let SpawnBlock = SKAction.run{
            self.SpawnBlock()
        }
        let repeatNewBlock = SKAction.repeatForever(SKAction.sequence([SpawnBlock, SKAction.wait(forDuration: 3)]))
        
        run(repeatNewBlock)
    }
 
    //this fills the block array to 50 blocks
    func fillBlockArray(){
        if (droppableBlocks.count == 0){
            for n in 0...50{
                createBlock()
            }
        }
    }
    
    //creation of letter L
    func letterL(){
        var l = L()
        l.setup()
        l.zPosition = 1
        l.name = "L"
        l.texture = l.getImage().texture
        droppableBlocks.append(l)
    }
    
    //creation of letter Z
    func letterZ(){
        var z = Z()
        z.setup()
        z.zPosition = 1
        z.texture = z.getImage().texture
        droppableBlocks.append(z)
    }
    
    //creation of letter O
    func letterO(){
        var o = O()
        o.setup()
        o.zPosition = 1
        o.texture = o.getImage().texture
        droppableBlocks.append(o)
    }
    
    //creation of letter J
    func letterJ(){
        var j = J()
        j.setup()
        j.zPosition = 1
        j.texture = j.getImage().texture
        droppableBlocks.append(j)
    }
    
    //creation of letter S
    func letterS(){
        var s = S()
        s.setup()
        s.zPosition = 1
        s.texture = s.getImage().texture
        droppableBlocks.append(s)
    }
    
    //creation of letter T
    func letterT(){
        var t = T()
        t.setup()
        t.zPosition = 1
        t.texture = t.getImage().texture
        droppableBlocks.append(t)
    }
    
    //creation of letter I
    func letterI(){
        var i = I()
        i.setup()
        i.zPosition = 1
        i.texture = i.getImage().texture
        droppableBlocks.append(i)
    }
    
    func rotateLeft(){
        //fallingBlock.zRotation = fallingBlock.zRotation 
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
