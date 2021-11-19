//
//  BeerDeatailView.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import SwiftUI

struct BeerDeatailView: View {
    
    let item: BeerModel
    @State private var rotate = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    Text(self.item.name)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    ImageView(withURL: self.item.imageUrl)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .rotation3DEffect(.degrees(self.rotate ? 360 : 0),
                                          axis: (x: 0, y: 1, z: 0))
                    Text(self.item.description)
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            withAnimation(Animation.default.speed(0.1).repeatForever(autoreverses: false)) {
                self.rotate.toggle()
            }
        }
    }
    
}

struct BeerDeatailView_Previews: PreviewProvider {
    static var previews: some View {
        BeerDeatailView(item: .init(name: "Sorachi Ace",
                                    description: "A hop that tastes of bubble gum? Seriously? No, we did not believe it either. But it does! This is one unique, son of a bitch of a hop. Lemony, deep, musty with a smoothness that belies its power. This hop is lemony like a lemon who was angry earlier but is now tired because of all the rage. This hop of Japanese origin is best enjoyed trying to make sushi from your gold fish, or trying to persuade your girlfriend (or boyfriend maybe) to dress up as a Geisha for Valentine’s Day.",
                                    imageUrl: "https://images.punkapi.com/v2/33.png"))
    }
}
