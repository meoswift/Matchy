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
    lazy var game = Matchy(numberOfCardPairs: numberOfCardPairs)
    
    var numberOfCardPairs: Int {
        return (cardButtons.count / 2);
    }
    
    var theme = [
        "animals"   : ["🐱","🐭","🐹","🐶","🐰","🐻","🐼","🦄","🐿","🐘"],
        "christmas" : ["🎄","🎁","🎅🏻","❄️","🍗", "🤶🏻", "🍪", "🥂", "☃️"],
        "tree"      : ["☘️","🌱","🌳","🌵","🍂","🌼","🌴","🎍","🌸"],
        "food"      : ["🌯","🥙","🍣","🥓","🍟","🍔","🍕","🥘","🍱"],
        "fruit"     : ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🥝","🍓"],
        "pastry"    : ["🎂","🍮","🍪","🥐","🍞","🥨","🍡","🍥","🥠"],
        "outfit"    : ["👘","👚","👖","👢","👞","🧤","👗","👒","🧣"],
    ]
    
    @IBAction func newGameButton(_ sender: UIButton) {
        flipCardsOnNewGame()
        game = Matchy(numberOfCardPairs: numberOfCardPairs)
        flipCountLabel.text = "Flips: \(game.flipCount)"
        emoji = [:]
        emojiChoices = chooseTheme
    }
    
    var chooseTheme: [String] {
        let randomTheme = Int(arc4random_uniform(UInt32(theme.count)))
        let key = Array(theme.keys)[randomTheme]
        return theme[key]!
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal) //emoji(for: card) returns a string
                button.backgroundColor = #colorLiteral(red: 1, green: 0.9655000567, blue: 0.8827727437, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.6206576228, blue: 0.2871945202, alpha: 0) : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
                // this means of a card is matched then the color turns clear -> disappear
                }
            }
        }
    
    func flipCardsOnNewGame() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        }
    }
        
    lazy var emojiChoices = chooseTheme
        
    var emoji = [Int:String]()
        
    func emoji(for card: Card) -> String {
        if emoji[card.idetifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.idetifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.idetifier] ?? "?" // this means if there is no emoji at card.identifier then return "?"
    }


}
