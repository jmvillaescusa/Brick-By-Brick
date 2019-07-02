//
//  Base.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-06-25.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class Base : SKSpriteNode{
    var image = SKSpriteNode(imageNamed: "Base")
    
    func setup(){
        addChild(image)
        let physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Base"), size: image.size)
        physicsBody.affectedByGravity = false
        physicsBody.restitution = 0
        physicsBody.isDynamic = false
        self.physicsBody = physicsBody
    }
}
