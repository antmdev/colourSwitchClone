//
//  GameScene.swift
//  ColourSwitch
//
//  Created by Ant Milner on 05/12/2018.
//  Copyright © 2018 Ant Milner. All rights reserved.
//

import SpriteKit

enum PlayColors {
    
    //build a colour array
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    
    ]
    
}

enum SwitchState: Int {
    
    case red, yellow, green, blue //switch statement
    
}


class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.red //initial state of the game
    var currenColorIndex : Int?
    
    let scoreLabel = SKLabelNode(text: "0") //score
    var score = 0
    
    
    override func didMove(to view: SKView) {
        setUpPhysics()
        layoutScene()
    }
    
    func setUpPhysics(){
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0) //reduce gravity speed by about 5 times
        physicsWorld.contactDelegate = self
    }
    
    func layoutScene() {
    
     backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        //intialise the coloursiwtch CIRCLE sprite
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        
        //make a third the size of the screen
        colorSwitch.size = CGSize(width: frame.size.width / 3 , height: frame.size.width / 3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        
        colorSwitch.zPosition = ZPositions.colorSwitch
        
        //assigning a physics body to our colorswitch item and making the radius as half the width
        
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width / 2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory //contains UInt32
        colorSwitch.physicsBody?.isDynamic = false //stops physics body being affected by forces
        
        
        addChild(colorSwitch)
        
        //adding score
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
       
        scoreLabel.zPosition = ZPositions.label
        
        addChild(scoreLabel) //add to screen
        
        spawnBall()
        
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(score)"
    }
    
    func spawnBall() {
        
        currenColorIndex = Int(arc4random_uniform(UInt32(4)))                   //creates a randomw integer for colorIndex
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currenColorIndex!], size: CGSize(width: 30.0, height: 30.0))                                                      //init ball - assigns random color from our array
        ball.colorBlendFactor = 1.0                                             //make sure colour is applied tro the texture
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)                   //put ball top of screen middle
        ball.zPosition = ZPositions.ball                                        // puts the ball in front of the number
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)   // assign physics to ball adapts if we chaneg the size
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory      //
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory //Defines whether contact should be tested between physcis body
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none             //Define whether physics categories should collide with each other
        addChild(ball)
        
    }
    
    func turnWheel() {
        
        if let newState = SwitchState(rawValue: switchState.rawValue + 1) {
            
            switchState = newState
            
        } else {
            
            switchState = .red
            
        }
        
        //Actually turn the Wheel
        
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25)) //rotates the circle by a quarter in 0.25 seconds
        
    }
    
    func gameOver(){
//        print("GameOver!")
        
        
        UserDefaults.standard.set(score, forKey: "RecentScore") //assigns score valiue and assigns a key recent score
        
        if score > UserDefaults.standard.integer(forKey: "Highscore") { //setting high score
            UserDefaults.standard.set(score, forKey: "Highscore")
        }
        
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene) //return to menu screen
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
    
    
    
    
}



extension GameScene: SKPhysicsContactDelegate { //this protocol only contains option methods
    
    func didBegin(_ contact: SKPhysicsContact) {  //gets called when a colision is registered
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
         
//            print("Contact!")  //above code recognises if contact between two objects has occured
            
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                
                if currenColorIndex == switchState.rawValue { //when color of ball matches color of circle
//                    print("correct")
                    
                    run(SKAction.playSoundFileNamed("bling", waitForCompletion: false))
                    
                    score += 1
                    updateScoreLabel()
                    
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                    
                } else  {
                    
                    run(SKAction.playSoundFileNamed("crash", waitForCompletion: true)) //doesnt work!!!
                    
                    gameOver()
                    
                }
            }
        }
    }
}
