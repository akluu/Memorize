//
//  MemoryGame.swift
//  Memorize
//
//  Created by Khai on 1/2/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private(set) var score: Int = 0
    
    private var indexOfTheFirstFaceUpCard: Int?
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheFirstFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }else{
                    if cards[chosenIndex].isPreviouslySeen == true || cards[potentialMatchIndex].isPreviouslySeen == true {
                        score -= 1
                    }
                }
                indexOfTheFirstFaceUpCard = nil
            }else{
                for index in cards.indices {
                    if cards[index].isFaceUp{
                        cards[index].isFaceUp = false
                        cards[index].isPreviouslySeen = true
                    }
                }
                indexOfTheFirstFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }

    
    init(numberOfParisOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfParisOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    
    struct Card: Identifiable{
        var id: Int
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isPreviouslySeen: Bool = false
        var content: CardContent
    }
}
