//
//  LoseScene.swift
//  Brick by Brick
//
//  Created by Rick Berenguer on 2019-07-02.
//  Copyright © 2019 Jaimeson Mario Villaescusa. All rights reserved.
//

import Foundation
import SpriteKit

class LoseScene: SKScene {
    var button = SKSpriteNode()
    var background = SKSpriteNode()
    
    let screenSize : CGRect = UIScreen.main.nativeBounds
    
    override func didMove(to view: SKView) {
        ////// present losing screen
        //button = childNode(withName: "returnbutton") as! SKSpriteNode
        setupLose()
        print(background.size.height)
    }
    
    func setupLose(){
        background = SKSpriteNode(imageNamed: "LoseMenu")
        background.position = CGPoint(x: 0, y: 0)
        background.size.width = 1350
        background.size.height = 2922
        background.zPosition = 0
        addChild(background)
        button = SKSpriteNode(imageNamed: "Menubutton")
        button.position = CGPoint(x: screenSize.width * -0.1 , y: screenSize.height * -0.25)
        button.zPosition = 100
        addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if(button.frame.contains(location)){
                var transition:SKTransition = SKTransition.fade(withDuration: 1)
                
                let scene:SKScene = MenuScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
