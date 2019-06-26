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
        physicsBody.affectedByGravity = true
        self.physicsBody = physicsBody
    }
}
