//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by mis11244131 on 2026/3/30.
//

import Foundation

class EmojiMemoryGame{
    private static var emojis = ["鼠","牛","虎","兔"]
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfcards: 4, createCardContent:
                            {index in EmojiMemoryGame.emojis[index]})
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
