//
//  Settings.swift
//  ColourSwitch
//
//  Created by Ant Milner on 05/12/2018.
//  Copyright © 2018 Ant Milner. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    
    static let none: UInt32 = 0 // Unassigned 32bit integer - when we want no physical simulation
    static let ballCategory: UInt32 = 0x1           //01
    static let switchCategory: UInt32 = 0x1 << 1    //10    // shifts all operators one to the left
    

}

enum ZPositions {  // puts the ball in front of the number assigns z-locations index for whats in front of what!
    
    static let label : CGFloat = 0
    static let ball : CGFloat = 1
    static let colorSwitch : CGFloat = 2
    
}
