//
//  StickyL.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-06-27.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class stickyL : SKSpriteNode{
    var image = SKSpriteNode(imageNamed: "StickyL")
    
    var rotatable = true
    
    func setup(){
        addChild(image)
        let physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "StickyL"), size: image.size)
        physicsBody.affectedByGravity = true
        physicsBody.restitution = 0
        self.physicsBody = physicsBody
    }
    
    func getImage() -> SKSpriteNode {
        return image
    }
}
