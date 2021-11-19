//
//  BeerSearchReducer.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import Foundation

final class BeerSearchReducer: ReduxReducer<BeerSearchState> {
    
    override func reduce(state: BeerSearchState, action: ReduxAction) -> BeerSearchState {
        switch action {
        case let BeerSearchAction.setBeers(beers):
            var newBeers = state.beers
            if state.page > 1 {
                newBeers.append(contentsOf: beers)
            } else {
                newBeers = beers
            }
            return state.build(beers: newBeers, isLoading: false)
        default:
            return state
        }
    }
    
}
