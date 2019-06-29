//
//  LetterT.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-06-25.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class T : SKSpriteNode{
    var image = SKSpriteNode(imageNamed: "LetterT")
    
    func setup(){
        addChild(image)
        let physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "LetterT"), size: image.size)
        physicsBody.affectedByGravity = true
        physicsBody.restitution = 0
        self.physicsBody = physicsBody
    }
    
    func getImage() -> SKSpriteNode {
        return image
    }
}
