//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by mis11244131 on 2026/3/30.
//

import SwiftUI

@Observable
class EmojiMemoryGame {
    // 建立最少三組主題
    private static let themes = [
        Theme(name: "海洋生物", emojis: ["🐳","🐙","🐚","🦀","🦞","🐬","🐠","🦈"], pairs: 8, color: "blue"),
        Theme(name: "美味甜點", emojis: ["🍰","🍩","🍪","🍧","🍦","🧁","🥧","🍫"], pairs: 6, color: "orange"),
        Theme(name: "森林動物", emojis: ["🦊","🐻","🦌","🐗","🦉","🐿","🐰","🐼"], pairs: 7, color: "green")
    ]
    
    private var theme: Theme
    private var model: MemoryGame<String>
    
    init() {
        let randomTheme = EmojiMemoryGame.themes.randomElement()!
        self.theme = randomTheme
        self.model = MemoryGame<String>(numberOfPairsOfCards: randomTheme.pairs) { index in
            randomTheme.emojis.shuffled()[index]
        }
    }
    
    // MARK: - 提供給 View 的門戶
    var cards: [MemoryGame<String>.Card] { model.cards }
    var score: Int { model.score }
    var themeName: String { theme.name }
    var themeColor: Color {
        switch theme.color {
            case "blue": return .blue
            case "green": return .green
            case "orange": return .orange
            default: return .gray
        }
    }
    
    // MARK: - Intent (意圖)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    // 按鈕呼叫的這個方法會重新選主題、重設分數
    func newGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = MemoryGame<String>(numberOfPairsOfCards: theme.pairs) { index in
            theme.emojis.shuffled()[index]
        }
    }
}

// 簡單的主題結構
struct Theme {
    let name: String
    let emojis: [String]
    let pairs: Int
    let color: String
}
