//
//  ContentView.swift
//  memorize
//
//  Created by mis11244131 on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            // 頂部資訊：主題名稱與得分
            HStack {
                Text(viewModel.themeName)
                    .font(.largeTitle)
                    .bold()
                Spacer()
                VStack(alignment: .trailing) {
                    Text("得分")
                        .font(.caption)
                    Text("\(viewModel.score)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.red) // 明顯顏色
                }
            }
            .padding(.horizontal)

            // 卡片區域
            cardList
                .animation(.default, value: viewModel.cards)
            
            // 這行 Spacer 會把按鈕推到螢幕最下面
            Spacer()
            
            // --- 這是你的新遊戲按鈕 ---
            Button(action: {
                viewModel.newGame()
            }) {
                VStack {
                    Image(systemName: "plus.circle.fill") // SF Symbol
                        .font(.system(size: 40))
                    Text("New Game")
                        .font(.headline)
                }
            }
            .padding(.bottom, 10)
        }
        .padding()
        .foregroundColor(viewModel.themeColor) // 根據主題切換顏色
    }
    
    var cardList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 40))
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
    
}
