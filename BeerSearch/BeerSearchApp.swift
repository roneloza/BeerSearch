//
//  BeerSearchApp.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import SwiftUI

@main
struct BeerSearchApp: App {
    var body: some Scene {
        WindowGroup {
            BeerSearchListView(store: .init(state: BeerSearchState(),
                                            reducer: BeerSearchReducer(),
                                            middlewares: [BeerSearchMiddleware()]))
        }
    }
}
