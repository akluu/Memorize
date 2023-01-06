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
    
    static var themes: Array<Theme> = [
        Theme(name: "Vehicles",
              emojis: ["🚗", "🚕", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🏍", "🚲", "🛵", "🚨", "🚔", "🚍", "🚘", "🚖", "🚡", "🚠", "🚟", "🚃"],
              numberOfPairOfCards: 12,
              color: "Red"),
        Theme(name: "Animals",
              emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🙊", "🐒"],
              numberOfPairOfCards: 8,
              color: "Orange"),
        Theme(name: "Faces",
              emojis: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😇", "🥰", "😍", "🤩", "😘", "😗", "😚", "😙", "😋", "😛"],
              numberOfPairOfCards: 10,
              color: "Yellow"),
        Theme(name: "Costume",
              emojis: ["👻", "🎃", "😈", "👹", "👺", "💀", "👻", "👽", "🤖", "🤡"],
              numberOfPairOfCards: 100,
              color: "Purple"),
        Theme(name: "Hearts",
              emojis: ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💕"],
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
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card){
            model.choose(card)
    }
    
    func newGame(){
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
