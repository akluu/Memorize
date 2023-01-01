//
//  ContentView.swift
//  Memorize
//
//  Created by Khai on 12/27/22.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🚗","🚙","🚕","🛻","🚛","🚚","🚑","🚓"]
    
    @State var emojiCount = 8
    
    var body: some View{
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
                    ForEach(emojis[0..<emojiCount], id: \.self){
                        emoji in CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack(){
                remove
                Spacer()
                Default
                Spacer()
                Randomize
                Spacer()
                add
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View{
        Button{
            if emojiCount > 1{
                emojiCount -= 1
            }
        }label:{
            Image(systemName: "minus.circle")
        }
        .font(.largeTitle)
    }
    
    var add: some View{
        Button{
            if emojiCount < emojis.count{
                emojiCount += 1
            }
        }label:{
            Image(systemName: "plus.circle")
        }
        .font(.largeTitle)
    }
    
    var Default: some View{
        Button{
            emojis = ["🚗","🚙","🚕","🛻","🚛","🚚","🚑","🚓"].shuffled()
            emojiCount = Int.random(in: 1...8)
        }label:{
            Text("Set Default")
        }
    }
    
    var Randomize: some View{
        Button{
            let randNum = Int.random(in: 8...30)
            var randEmojis = [String]()
            for _ in 1...randNum{
                randEmojis.append(String(UnicodeScalar(Array(0x1F601...0x1F64F).randomElement()!)!))
            }
            emojis = randEmojis
            emojiCount = Int.random(in: 1...randNum)
        }label:{
            Text("Randomize")
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            }else{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
            }
        }
        .onTapGesture{
            self.isFaceUp = !isFaceUp
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
