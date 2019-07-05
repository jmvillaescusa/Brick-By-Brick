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
    var background = SKSpriteNode()
    
    let screenSize : CGRect = UIScreen.main.bounds
    
    override func didMove(to view: SKView) {
        setupStart()
        print(screenSize)
    }
    
    func setupStart(){
        background = SKSpriteNode(imageNamed: "Startmenu")
        background.position = CGPoint(x: screenSize.width - 420, y: 0)
        background.size.width = screenSize.width * 3.3
        background.size.height = screenSize.height * 3.3
        background.zPosition = 0
        addChild(background)
        startButton = SKSpriteNode(imageNamed: "Playbutton")
        startButton.position = CGPoint(x: screenSize.width - 420 , y: -700)
        startButton.zPosition = 100
        addChild(startButton)
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
