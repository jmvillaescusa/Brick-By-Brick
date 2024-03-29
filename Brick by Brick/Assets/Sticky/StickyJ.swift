//
//  StickyJ.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-06-27.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class stickyJ : SKSpriteNode{
    var image = SKSpriteNode(imageNamed: "StickyJ")
    
    func setup(){
        addChild(image)
        let physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "StickyJ"), size: image.size)
        physicsBody.mass = 100
        physicsBody.affectedByGravity = true
        physicsBody.restitution = 0
        self.physicsBody = physicsBody
    }
    
    func getImage() -> SKSpriteNode {
        return image
    }
}
