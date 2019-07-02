//
//  StickyT.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-06-27.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class stickyT : SKSpriteNode{
    var image = SKSpriteNode(imageNamed: "StickyT")
    var rotatable = true
    
    func setup(){
        addChild(image)
        let physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "StickyT"), size: image.size)
        physicsBody.affectedByGravity = true
        physicsBody.restitution = 0
        self.physicsBody = physicsBody
    }
    
    func getImage() -> SKSpriteNode {
        return image
    }
}
