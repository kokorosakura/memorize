//
//  ＭemoryGame.swift
//  memorize
//
//  Created by mis11244131 on 2026/3/30.
//


import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent, id: "\(index)a"))
            cards.append(Card(content: cardContent, id: "\(index)b"))
        }
        cards.shuffle()
    }
    
    var lastFaceUpIndex: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let lastIndex = lastFaceUpIndex {
                if cards[lastIndex].content == cards[chosenIndex].content {
                    cards[lastIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2 // 配對成功 +2
                } else {
                    // 扣分規則：如果翻開看過的牌卻沒中
                    if cards[chosenIndex].hasBeenSeen { score -= 1 }
                    if cards[lastIndex].hasBeenSeen { score -= 1 }
                }
                cards[chosenIndex].isFaceUp = true
                lastFaceUpIndex = nil
            } else {
                for i in cards.indices {
                    if cards[i].isFaceUp {
                        cards[i].isFaceUp = false
                        cards[i].hasBeenSeen = true // 標記為看過
                    }
                }
                lastFaceUpIndex = chosenIndex
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false // 記錄是否曾被翻開過
        var content: CardContent
        var id: String
    }
}
