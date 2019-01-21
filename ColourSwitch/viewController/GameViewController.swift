//
//  GameViewController.swift
//  ColourSwitch
//
//  Created by Ant Milner on 05/12/2018.
//  Copyright © 2018 Ant Milner. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            //initalise a game scene class
            let scene =  MenuScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            
                view.ignoresSiblingOrder = true //view render visual element in no order but effiecnt performance wise
            
                view.showsFPS = true
                view.showsNodeCount = true
        }
    }
}
