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
    
    // This var keeps track of whether there is one card faced up
    // Optional Int because there might or might not be a card faced up
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index:Int) {
        if !cards[index].isMatched  {
            // matchIndex is of type Int. If there is no faced up then matchIndex cannot be indexOf... because indexOf... is nil.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match   
                if cards[matchIndex].idetifier == cards[index].idetifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                //set back to nil because we flipped matched cards down
            } else {
                // either no cards or 2 cards are matching
                for flipDownIndex in cards.indices {
                    //everything is down
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // Function used to create pairs of cards. The matching pair has the same identifier.
    init(numberOfCardPairs: Int) {
        for _ in 1...numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
    }
}
