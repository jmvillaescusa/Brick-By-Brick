//
//  LetterI.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-06-25.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class I : SKSpriteNode{
    var image = SKSpriteNode(imageNamed: "LetterI")
    
    func setup(){
        addChild(image)
        let physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "LetterI"), size: image.size)
        physicsBody.mass = 100
        physicsBody.affectedByGravity = true
        physicsBody.restitution = 0
        self.physicsBody = physicsBody
    }
    
    func getImage() -> SKSpriteNode {
        return image
    }
}
