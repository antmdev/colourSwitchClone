//
//  MenuScene.swift
//  ColourSwitch
//
//  Created by Ant Milner on 05/12/2018.
//  Copyright © 2018 Ant Milner. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    
    
    func addLogo() {
        
        let colorSwitchLogo: SKSpriteNode!

        
        colorSwitchLogo = SKSpriteNode(imageNamed: "logo")
        colorSwitchLogo.size = CGSize(width: frame.size.width / 2.5 , height: frame.size.width / 2.5)
        colorSwitchLogo.position = CGPoint(x: frame.midX, y: frame.maxY - colorSwitchLogo.size.height)
       
        addChild(colorSwitchLogo)
        
        
    }
    
    func addLabels() {
        
        //play game Label
        
        let playLabel = SKLabelNode(text: "Tap to Play!")
       
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        
        
        addChild(playLabel) //add to screen
        animate(label: playLabel)
        
        let difficultyLabel = SKLabelNode(text: "Difficulty")

        difficultyLabel.fontName = "AvenirNext-Bold"
        difficultyLabel.fontSize = 20
        difficultyLabel.fontColor = UIColor.yellow
        difficultyLabel.position = CGPoint(x: frame.midX, y:playLabel.position.y - difficultyLabel.frame.size.height*4 )


        addChild(difficultyLabel) //add to screen
        animateFlash(label: difficultyLabel)
   
        
        
        
        let highScoreLabel = SKLabelNode(text: "Highscore: " + "\(UserDefaults.standard.integer(forKey: "Highscore"))")
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 40.0
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*4 )
        
        addChild(highScoreLabel) //add to screen
        
        let recentScoreLabel = SKLabelNode(text: "Recent Score: " + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")
        
        recentScoreLabel.fontName = "AvenirNext-Bold"
        recentScoreLabel.fontSize = 40.0
        recentScoreLabel.fontColor = UIColor.white
//        recentScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY / 4 ) //his code
        recentScoreLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - recentScoreLabel.frame.size.height*2 )
        
        addChild(recentScoreLabel) //add to screen
    }
    
    
    func animate(label: SKLabelNode) {  //animate the label flash on / off
        
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        
        let sequence = SKAction.sequence([scaleUp,scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }
    
    func animateFlash(label: SKLabelNode) {  //animate the label stretch on / off
        
        //animate the label flash on / off
        
        let fadeOut = SKAction.fadeIn(withDuration: 0.5)
        let fadeIn = SKAction.fadeOut(withDuration: 0.5)
        
        
        let sequence = SKAction.sequence([fadeOut,fadeIn])
        label.run(SKAction.repeatForever(sequence))
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
    

}
