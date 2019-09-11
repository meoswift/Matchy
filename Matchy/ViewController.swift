//
//  ViewController.swift
//  Matchy
//
//  Created by Khanh Linh Tran on 9/8/19.
//  Copyright © 2019 Tufts University. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Matchy(numberOfCardPairs: (cardButtons.count + 1 / 2))
    // in case there are odd number of cards
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber) //This function determines if a card is matched
            updateViewFromModel()
        } else {
            print("can't find")
        }
    }
    
    // Fuction to update View after deciding which card is faced up and which is faced down
    // Also updates after checking if cards matched.
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal) //emoji(for: card) returns a string
                button.backgroundColor = #colorLiteral(red: 1, green: 0.9655000567, blue: 0.8827727437, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.6206576228, blue: 0.2871945202, alpha: 0) : #colorLiteral(red: 0.5039266348, green: 0.8744559288, blue: 0.7127764821, alpha: 1) // this means of a card is matched then the color turns clear -> disappear
            }
        }
    }
    
    var emojiChoices = ["🎄","🎁","🎅🏻","❄️","🎉","🍗"]
    
    //Declare a emoji dictionary (but empty)
    var emoji = [Int:String]()
    
    //Function to populate the emoji dictionary. remove is used so that the emoji doesn't have repeated value.
    func emoji(for card: Card) -> String {
        if emoji[card.idetifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.idetifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.idetifier] ?? "?" // this means if there is no emoji at card.identifier then return "?"
    }
    
}

