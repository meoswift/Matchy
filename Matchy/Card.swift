//
//  Card.swift
//  Matchy
//
//  Created by Khanh Linh Tran on 9/9/19.
//  Copyright © 2019 Tufts University. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var idetifier: Int
    
    static var identifierFactory = 0
    
    // Function generates unique identifier everytime it is called
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.idetifier = Card.getUniqueIdentifier()
    }
} 

