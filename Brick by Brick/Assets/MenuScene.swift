//
//  MenuScene.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-07-02.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    var startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        startButton = childNode(withName: "startbutton") as! SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if(startButton.frame.contains(location)){
                var transition:SKTransition = SKTransition.fade(withDuration: 1)
                
                let scene:SKScene = GameScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
