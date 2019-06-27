//
//  LetterL.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-06-25.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class L : SKSpriteNode{
    var image = SKSpriteNode(imageNamed: "LetterL")
    
    func setup(){
        addChild(image)
           let physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "LetterL"), size: image.size)
        physicsBody.affectedByGravity = true
        self.physicsBody = physicsBody
	    }
    
    func getImage() -> SKSpriteNode {
        return image
    }
}
