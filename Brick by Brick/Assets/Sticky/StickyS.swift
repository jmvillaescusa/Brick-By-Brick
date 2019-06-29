//
//  StickyS.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-06-27.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class stickyS : SKSpriteNode{
    var image = SKSpriteNode(imageNamed: "StickyS")
    	
    func setup(){
        addChild(image)
        let physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "StickyS"), size: image.size)
        physicsBody.affectedByGravity = true
        physicsBody.restitution = 0
        self.physicsBody = physicsBody
    }
    
    func getImage() -> SKSpriteNode {
        return image
    }
}
