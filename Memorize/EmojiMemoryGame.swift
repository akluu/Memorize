//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Khai on 1/3/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    
    init(){
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    typealias Card = MemoryGame<String>.Card
    
    static var themes: Array<Theme> = [
        Theme(name: "Vehicles",
              emojis: ["๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐ฒ", "๐ต", "๐จ", "๐", "๐", "๐", "๐", "๐ก", "๐ ", "๐", "๐"],
              numberOfPairOfCards: 12,
              color: "Red"),
        Theme(name: "Animals",
              emojis: ["๐ถ", "๐ฑ", "๐ญ", "๐น", "๐ฐ", "๐ฆ", "๐ป", "๐ผ", "๐จ", "๐ฏ", "๐ฆ", "๐ฎ", "๐ท", "๐ฝ", "๐ธ", "๐ต", "๐", "๐", "๐", "๐"],
              numberOfPairOfCards: 8,
              color: "Orange"),
        Theme(name: "Faces",
              emojis: ["๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐คฃ", "โบ๏ธ", "๐", "๐", "๐ฅฐ", "๐", "๐คฉ", "๐", "๐", "๐", "๐", "๐", "๐"],
              numberOfPairOfCards: 10,
              color: "Yellow"),
        Theme(name: "Costume",
              emojis: ["๐ป", "๐", "๐", "๐น", "๐บ", "๐", "๐ป", "๐ฝ", "๐ค", "๐คก"],
              numberOfPairOfCards: 100,
              color: "Purple"),
        Theme(name: "Hearts",
              emojis: ["โค๏ธ", "๐งก", "๐", "๐", "๐", "๐", "๐ค", "๐ค", "๐ค", "๐"],
              numberOfPairOfCards: 6,
              color: "Pink"),
        
    ]
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfParisOfCards: theme.numberOfPairOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
        
    @Published private var model: MemoryGame<String>
    
    private var theme: Theme
    
    var themeName: String {
        theme.name
    }
    
    var themeColor: Color {
        switch theme.color{
        case "Red":
            return .red
        case "Orange":
            return .orange
        case "Yellow":
            return .yellow
        case "Purple":
            return .purple
        case "Pink":
            return .pink
        default:
            return .black
        }
    }
    
    var score: Int{
        return model.score
    }
    
    var cards: Array<Card>{
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card){
            model.choose(card)
    }
    
    func newGame(){
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
