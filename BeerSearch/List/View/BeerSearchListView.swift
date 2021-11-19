//
//  ContentView.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import SwiftUI
import Combine

struct CacheImage {
    
    public static let shared: CacheImage = .init()
    public let cache = NSCache<NSString, UIImage>()
    
}

struct BeerSearchListView: ReduxStoreView {
    
    @ObservedObject private(set) var store: ReduxStore<BeerSearchState>
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBar(text: self.$store.state.searchText.onChange({ text in
                        self.getBeers()
                    }))
                    List {
                        ForEach(self.store.state.beers) { item in
                            NavigationLink(destination: BeerDeatailView(item: item)) {
                                HStack {
                                    ImageView(withURL: item.imageUrl)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                    Text(item.name)
                                    Spacer()
                                }
                                .onAppear {
                                    self.getBeersPagination(item: item)
                                }
                            }
                        }
                    }
                    .background(Color.white)
                    Spacer()
                }
            }
            .resignKeyboardOnDragGesture()
            .navigationTitle("Beers")
            .onAppear {
                // Set the default to clear
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
    
    private func searchBeers() {
        self.store.state.isLoading = true
        self.store.dispatch(BeerSearchAction.getBeers(food: self.store.state.searchText,
                                                      page: self.store.state.page,
                                                      perPage: self.store.state.perPage))
    }
    
    private func getBeers() {
        if !self.store.state.isLoading {
            self.store.state.page = 1
            self.searchBeers()
        }
    }
    
    private func getBeersPagination(item: BeerModel) {
        if let last = self.store.state.beers.last,
           last.id == item.id,
           !self.store.state.isLoading {
            self.store.state.page += 1
            self.searchBeers()
        }
    }
    
}

struct BeerSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        BeerSearchListView(
            store: .init(
                state: .init(beers:
                                [.init(name: "Skull Candy",
                                       description: "The first beer that we brewed on our newly commissioned 5000 litre brewhouse in Fraserburgh 2009. A beer with the malt and body of an English bitter, but the heart and soul of vibrant citrus US hops.",
                                       imageUrl: "https://images.punkapi.com/v2/keg.png"),
                                 .init(name: "Sorachi Ace",
                                        description: "A hop that tastes of bubble gum? Seriously? No, we did not believe it either. But it does! This is one unique, son of a bitch of a hop. Lemony, deep, musty with a smoothness that belies its power. This hop is lemony like a lemon who was angry earlier but is now tired because of all the rage. This hop of Japanese origin is best enjoyed trying to make sushi from your gold fish, or trying to persuade your girlfriend (or boyfriend maybe) to dress up as a Geisha for Valentine’s Day.",
                                        imageUrl: "https://images.punkapi.com/v2/33.png")]),
                reducer: BeerSearchReducer()))
    }
}
