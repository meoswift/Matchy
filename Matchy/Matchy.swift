//
//  Matchy.swift
//  Matchy
//
//  Created by Khanh Linh Tran on 9/9/19.
//  Copyright © 2019 Tufts University. All rights reserved.
//

import Foundation

class Matchy
{
    var cards = [Card]()
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    func chooseCard(at index:Int) {
        flipCount += 1
        if !cards[index].isMatched  {
            let matchIndex = indexOfOneAndOnlyFaceUpCard
            if matchIndex != nil, matchIndex != index {
                if cards[matchIndex!].idetifier == cards[index].idetifier {
                    cards[matchIndex!].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func randomizeCard() {
        for index in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let tempCard = cards[randomIndex]
            cards[randomIndex] = cards[index]
            cards[index] = tempCard
        }
    }
    
    // Function used to create pairs of cards. The matching pair has the same identifier.
    init(numberOfCardPairs: Int) {
        for _ in 1...numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        randomizeCard()
    }

}
