//: Playground - noun: a place where people can play

import UIKit

struct Card {
    let value: String
    let suit: String
    let numerical_value: Int
    
    func showCard() {
        print("value: "+self.value+" suit: "+self.suit)
    }
}

class Deck {
    var cards: [Card] = [Card]()
    
    init() {
        self.reset()
    }
    
    func deal() -> Card? {
        if self.cards.count > 0 {
            let top_card = self.cards[0]
            self.cards.remove(at: 0)
            return top_card
        } else {
            return nil
        }
    }
    func reset() {
        let values: [String] = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        let suits: [String] = ["Clubs", "Spades", "Hearts", "Diamonds"]
        let numerical_values: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13]
        
        for suit in suits {
            for num_val in numerical_values {
                let new_card = Card(value: values[num_val-1], suit: suit, numerical_value: num_val)
                self.cards.append(new_card)
            }
        }
    }
    func shuffle() {
        var swap_i: Int = 0
        for i in 0..<52 {
            swap_i = Int(arc4random_uniform(51))
            while (swap_i == i) {
                swap_i = Int(arc4random_uniform(51))
            }
            swap(&self.cards[i], &self.cards[swap_i])
        }
    }
    func showDeck() {
        for card in self.cards {
            print(card)
        }
    }
}
let a_card = Card(value: "A", suit: "Hearts", numerical_value: 1)

class Player {
    let name: String
    var hand: [Card] = [a_card]
    
    init(name: String){
        self.name = name
    }
    
    func drawFrom(the_deck: Deck) -> Card? {
        let drawn_card: Card? = the_deck.deal()
        
        if let card_drawn = drawn_card {
            self.hand.append(card_drawn)
            return card_drawn
        } else {
            return nil
        }
    }
    func discard(card: Card) -> Bool {
        if self.hand.count > 0 {
            if let index = self.idxOf(card: card){
                self.hand.remove(at: index)
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    func idxOf(card: Card) -> Int?{
        if self.hand.count > 0 {
            for i in 0..<self.hand.count {
                if self.hand[i].value == card.value && self.hand[i].suit == card.suit {
                    return Int(i)
                }
            }
            return nil
        } else {
            return nil
        }
    }
    func showHand(){
        for card in self.hand{
            print(card)
        }
    }
}


var my_deck = Deck()
my_deck.shuffle()

var my_player = Player(name: "Joe")
print(my_player.name)
my_player.drawFrom(the_deck: my_deck)
my_player.showHand()
print(my_player.idxOf(card: a_card)!)


