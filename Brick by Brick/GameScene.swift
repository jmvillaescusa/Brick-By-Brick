//
//  GameScene.swift
//  Brick by Brick
//
//  Created by Jaimeson Mario Villaescusa on 2019-06-25.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var base = Base()
    let cameraNode = SKCameraNode()
    
    let screenSize: CGRect = UIScreen.main.bounds
    var spawnLocation = CGPoint(x: 0, y: 0)
    
    var fallingBlock = SKSpriteNode()
    var tetrisBlocks = [SKSpriteNode]()
    //var savedBlock = SKSpriteNode()
    var heldBlock = SKSpriteNode()
    var nextBlock = SKSpriteNode()
    var tempBlock = SKSpriteNode()
    
    //var showingNext = SKSpriteNode()
    
    var held: Bool = false
    var pieceOnHold: Bool = false
    
    var lives = 5
    
    var droppableBlocks = [SKSpriteNode]()
    var spawnedBlocks = [SKSpriteNode]()
    
    var count: Int = 0
    
    var killBox1 = SKSpriteNode()
    var killBox2 = SKSpriteNode()
    
    var rotatable = true
    
    enum CategoryMask: UInt32 {
        case blocks = 0b01 // 1
        case killbox = 0b10 // 2
        case base = 0b11 // 3
        case sticky = 0b100 // 4
    }
    
    //UI Buttons
    let rotateLeft = SKSpriteNode(imageNamed: "left")
    let rotateRight = SKSpriteNode(imageNamed: "right")
    let holdPiece = SKSpriteNode(imageNamed: "hold")
    
    //Movement
    var movingDown: Bool = false
    var movingLeft: Bool = false
    var movingRight: Bool = false
    
    ////////////////////////// Start of setup Elements //////////////////////////////////
    //Camera
    func setupCamera() {
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: 0, y: 0)
        //cameraNode.setScale(2)
    }

    func setupBase() {
        base.setup()
        base.zPosition = 1
        base.physicsBody?.categoryBitMask = CategoryMask.base.rawValue
        base.physicsBody?.contactTestBitMask = CategoryMask.blocks.rawValue | CategoryMask.sticky.rawValue
        base.physicsBody?.collisionBitMask = CategoryMask.blocks.rawValue | CategoryMask.sticky.rawValue
        addChild(base)
    }

    func setupKillboxes(){
        killBox1.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "LetterI"), size: killBox1.size)
        killBox1.zPosition = 1
        killBox1.physicsBody?.isDynamic = false
        killBox1.physicsBody?.categoryBitMask = CategoryMask.killbox.rawValue
        killBox1.physicsBody?.collisionBitMask = CategoryMask.blocks.rawValue
        killBox1.physicsBody?.contactTestBitMask = CategoryMask.blocks.rawValue
        
        killBox2.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "LetterI"), size: killBox2.size)
        killBox2.zPosition = 1
        killBox2.physicsBody?.categoryBitMask = CategoryMask.killbox.rawValue
        killBox2.physicsBody?.collisionBitMask = CategoryMask.blocks.rawValue
        killBox2.physicsBody?.contactTestBitMask = CategoryMask.blocks.rawValue
        killBox2.physicsBody?.isDynamic = false
    }
    //Buttons
    func setupButton() {
        rotateLeft.position = CGPoint(x: -400, y: -1100)
        rotateLeft.setScale(2)
        rotateLeft.zPosition = 100
        addChild(rotateLeft)
        
        rotateRight.position = CGPoint(x: 400, y: -1100)
        rotateRight.setScale(2)
        rotateRight.zPosition = 100
        addChild(rotateRight)
        
        holdPiece.position = CGPoint(x: 0, y: -1100)
        holdPiece.setScale(2)
        holdPiece.zPosition = 100
        addChild(holdPiece)
    }
    ////////////////////////////////////////////////////////////
    
    override func didMove(to view: SKView) {
        setupCamera()
        setupButton()
        
        //physicsWorld.contactDelegate = self
        
        setupKillboxes()
        setupBase()
    
        //showingNext = childNode(withName: "NextShowingBlock") as! SKSpriteNode
        //savedBlock = childNode(withName: "SavedBlock") as! SKSpriteNode
        
        if (droppableBlocks.count < 2){
            fillBlockArray()
        }
        
        if (droppableBlocks.count >= 1){
            dropBlock()
        }
        
        view.showsPhysics = true
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        contact.bodyA.angularVelocity = 0
        contact.bodyB.angularVelocity = 0
        
        // collision for blocks hitting kill box
        if (collision == CategoryMask.blocks.rawValue | CategoryMask.killbox.rawValue){
            if (contact.bodyA.categoryBitMask == CategoryMask.killbox.rawValue){
                contact.bodyB.node?.removeFromParent()
                lives = lives - 1

                if (lives <= 0){
                    hasDied()
                }
                print("delete A, Lives: \(lives)")
            }
        }
        // collision for stickyhitting kill box
        else if (collision == CategoryMask.sticky.rawValue | CategoryMask.killbox.rawValue){
            if (contact.bodyA.categoryBitMask == CategoryMask.killbox.rawValue){
                contact.bodyB.node?.removeFromParent()
                lives = lives - 1
                print("delete A, Lives: \(lives)")
            }
        }
        // collision for sticky block hitting blocks
        else if (collision == CategoryMask.sticky.rawValue | CategoryMask.blocks.rawValue){
            if (contact.bodyA.categoryBitMask == CategoryMask.sticky.rawValue){
                // create a fixed joint between bodyA and bodyB
                var collisionBox = SKPhysicsJointFixed.joint(withBodyA: contact.bodyA, bodyB: contact.bodyB, anchor: contact.contactPoint)

                rotatable = false
                contact.bodyA.angularVelocity = 0
                contact.bodyB.angularVelocity = 0
                
                run(SKAction.wait(forDuration: 20))
                
                scene?.physicsWorld.add(collisionBox)
            }
            else if (contact.bodyB.categoryBitMask == CategoryMask.sticky.rawValue){
                var collisionBox = SKPhysicsJointFixed.joint(withBodyA: contact.bodyA, bodyB: contact.bodyB, anchor: contact.contactPoint)
                rotatable = false
                contact.bodyA.angularVelocity = 0
                contact.bodyB.angularVelocity = 0
                
                run(SKAction.wait(forDuration: 20))

                scene?.physicsWorld.add(collisionBox)
            }
        }
        // collision for sticky block hitting sticky block
        else if (collision == CategoryMask.sticky.rawValue | CategoryMask.sticky.rawValue){
            var collisionBox = SKPhysicsJointFixed.joint(withBodyA: contact.bodyA, bodyB: contact.bodyB, anchor: contact.contactPoint)
            rotatable = false
            contact.bodyA.angularVelocity = 0
            contact.bodyB.angularVelocity = 0

            run(SKAction.wait(forDuration: 20))
            scene?.physicsWorld.add(collisionBox)
        }
        else {
        }
    }
    
    func setupKillBoxetc(){
        //killBox1 = childNode(withName: "killbox1") as! SKSpriteNode
        //killBox2 = childNode(withName: "killbox2") as! SKSpriteNode
        //showingNext = childNode(withName: "NextShowingBlock") as! SKSpriteNode
        
    }
    
    func hasDied(){
        var transition:SKTransition = SKTransition.fade(withDuration: 1)
        
        let scene:SKScene = LoseScene(size: self.size)
        scene.view?.presentScene(scene, transition: transition)
    }
    
    
    // This creates a block for the array to spawn
    func createBlock(){
        spawnLocation = CGPoint(x: screenSize.width/2 - 208, y: 0)
        var randNum = Int.random(in: 0...94)
        //let randNum: Int = 7
        
        if (randNum > 0 && randNum <= 9){
            letterL()
        }
        if (randNum >= 10 && randNum <= 19){
            letterI()
        }
        if (randNum >= 20 && randNum <= 29){
            letterJ()
        }
        if (randNum >= 30 && randNum <= 39){
            letterO()
        }
        if (randNum >= 40 && randNum <= 52){
            letterS()
        }
        if (randNum >= 53 && randNum <= 69){
            letterT()
        }
        if (randNum >= 70 && randNum <= 86){
            letterZ()
        }
        if (randNum >= 87 && randNum <= 94){
            StickyI()
        }

    }
    
    func updateNextBlock(){
        //showingNext.texture = droppableBlocks[1].texture
    }
    
    //This spawns a block from the first element of the array
    //Also, sets falling block to the dropped block, the next block to next block
    func SpawnBlock(){
        fallingBlock = droppableBlocks[0]
        //updateNextBlock()

        droppableBlocks[0].position = spawnLocation
        addChild(droppableBlocks[0])
        spawnedBlocks.append(fallingBlock)
        droppableBlocks.remove(at: 0)
        rotatable = true
        
        fallingBlock.position = spawnLocation
        //addChild(fallingBlock)
        droppableBlocks.remove(at: 0)
        
        held = false
        
        //Update camera
        count += 1
        if count > 3 {
            updateCamera()
            count = 0
        }
    }
    
    
    //This is a endless loop that spawns the blocks
    func dropBlock(){
        let SpawnBlock = SKAction.run{
            self.SpawnBlock()
        }
        let repeatNewBlock = SKAction.repeatForever(SKAction.sequence([SpawnBlock, SKAction.wait(forDuration: 4)]))
        
        run(repeatNewBlock)
    }
    
    func swapBlock(){
        fallingBlock.position = spawnLocation
        addChild(fallingBlock)
        
        let SpawnBlock = SKAction.run{
            self.SpawnBlock()
        }
        let repeatNewBlock = SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 4), SpawnBlock]))
        
        run(repeatNewBlock)
    }
 
    //This fills the block array to 50 blocks
    func fillBlockArray(){
        if (droppableBlocks.count == 0){
            for n in 0...50{
                createBlock()
            }
        }
    }
    
    ////////////////////////// Start of setup Letters //////////////////////////////////
    
    //creation of letter L
    func letterL(){
        var l = L()
        l.setup()
        l.zPosition = 1
        l.name = "L"
        l.texture = l.getImage().texture
        l.physicsBody?.categoryBitMask = CategoryMask.blocks.rawValue
        l.physicsBody?.collisionBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        l.physicsBody?.contactTestBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        droppableBlocks.append(l)
    }
    
    //creation of letter Z
    func letterZ(){
        var z = Z()
        z.setup()
        z.zPosition = 1
        z.texture = z.getImage().texture
        z.physicsBody?.categoryBitMask = CategoryMask.blocks.rawValue
        z.physicsBody?.collisionBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        z.physicsBody?.contactTestBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        droppableBlocks.append(z)
    }
    
    //creation of letter O
    func letterO(){
        var o = O()
        o.setup()
        o.zPosition = 1
        o.texture = o.getImage().texture
        o.physicsBody?.categoryBitMask = CategoryMask.blocks.rawValue
        o.physicsBody?.collisionBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        o.physicsBody?.contactTestBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        droppableBlocks.append(o)
    }
    
    //creation of letter J
    func letterJ(){
        var j = J()
        j.setup()
        j.zPosition = 1
        j.texture = j.getImage().texture
        j.physicsBody?.categoryBitMask = CategoryMask.blocks.rawValue
        j.physicsBody?.collisionBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        j.physicsBody?.contactTestBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        droppableBlocks.append(j)
    }
    
    //creation of letter S
    func letterS(){
        var s = S()
        s.setup()
        s.zPosition = 1
        s.texture = s.getImage().texture
        s.physicsBody?.categoryBitMask = CategoryMask.blocks.rawValue
        s.physicsBody?.collisionBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        s.physicsBody?.contactTestBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        droppableBlocks.append(s)
    }
    
    //creation of letter T
    func letterT(){
        var t = T()
        t.setup()
        t.zPosition = 1
        t.texture = t.getImage().texture
        t.physicsBody?.categoryBitMask = CategoryMask.blocks.rawValue
        t.physicsBody?.collisionBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        t.physicsBody?.contactTestBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        droppableBlocks.append(t)
    }
    
    //creation of letter I
    func letterI(){
        var i = I()
        i.setup()
        i.zPosition = 1
        i.texture = i.getImage().texture
        i.physicsBody?.categoryBitMask = CategoryMask.blocks.rawValue
        i.physicsBody?.collisionBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        i.physicsBody?.contactTestBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.sticky.rawValue
        droppableBlocks.append(i)
    }

    func StickyI(){
        var sticky_i = stickyI()
        sticky_i.setup()
        sticky_i.zPosition = 1
        sticky_i.texture = sticky_i.getImage().texture
        sticky_i.physicsBody?.categoryBitMask = CategoryMask.sticky.rawValue
        sticky_i.physicsBody?.collisionBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.blocks.rawValue | CategoryMask.sticky.rawValue
        sticky_i.physicsBody?.contactTestBitMask = CategoryMask.killbox.rawValue | CategoryMask.base.rawValue | CategoryMask.blocks.rawValue | CategoryMask.sticky.rawValue
        droppableBlocks.append(sticky_i)
    }
    
    ///////////////////////////////////End of Setups Letters//////////////////////
    
    // Movement of Falling Block
    func turnLeft() {
        fallingBlock.zRotation = fallingBlock.zRotation + CGFloat(90).degreesToRadians
    }
    func turnRight() {
        fallingBlock.zRotation = fallingBlock.zRotation - CGFloat(90).degreesToRadians
    }
    func pieceMovement() {
        if (movingDown && !movingRight && !movingLeft) {
            fallingBlock.position.y -= 40
        }
        if (movingRight && !movingDown) {
            fallingBlock.position.x += 25
        }
        if (movingLeft && !movingDown) {
            fallingBlock.position.x -= 25
        }
    }
    
    func hold() {
        if (!held) {
            held = true
            if (pieceOnHold) {
                print("piece swaped")
                
                tempBlock = heldBlock
                heldBlock = fallingBlock
                fallingBlock.removeFromParent()
                fallingBlock = tempBlock
                
                
                self.removeAllActions()
                swapBlock()
                print("\(String())")
                
            } else {
                pieceOnHold = true
                print("piece held")
                
                heldBlock = fallingBlock
                fallingBlock.removeFromParent()
                
                self.removeAllActions()
                dropBlock()
                print("\(String(describing: heldBlock.texture))")
            }
        }
    }
    
    func updateUI() {
        //UI Buttons
        rotateLeft.position.y = cameraNode.position.y - 1100
        rotateRight.position.y = cameraNode.position.y - 1100
        holdPiece.position.y = cameraNode.position.y - 1100
        
        //Spawn Location
        spawnLocation.y = cameraNode.position.y + 1700
        
        //Next & Saved Piece
        //showingNext.position.y = cameraNode.position.y + 1145
        //savedBlock.position.y = cameraNode.position.y + 1145
        
        //Kill Box
        killBox1.position.y = cameraNode.position.y - 1372.306
        killBox2.position.y = cameraNode.position.y - 1372.306
    }
    func updateCamera() {
        cameraNode.position.y = cameraNode.position.y + 180
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        updateUI()
        //cameraNode.position.y += 0.5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if (rotateLeft.frame.contains(location) && rotatable){
                turnLeft()
            } else if (rotateRight.frame.contains(location) && rotatable) {
                turnRight()
            } else if (holdPiece.frame.contains(location)) {
                hold()
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
                    movingLeft = false
                    movingRight = false
                }
                else if (newlocation.x > previousLocation.x) {
                    movingRight = true
                    movingDown = false
                } else if (newlocation.x < previousLocation.x) {
                    movingLeft = true
                    movingDown = false
                }
                pieceMovement()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            movingDown = false
            movingLeft = false
            movingRight = false
        }
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
    }
