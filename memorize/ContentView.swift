//
//  ContentView.swift
//  memorize
//
//  Created by mis11244131 on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundStyle(.orange)
    }
}
        
struct CardView: View {
    var isFaceup: Bool = true
    var body: some View {
        ZStack{
            if isFaceup{
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                Text("✈️")
            }
            else{
                RoundedRectangle(cornerRadius: 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
