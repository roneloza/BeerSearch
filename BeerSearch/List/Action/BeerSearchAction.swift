//
//  BeerSearchAction.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import Foundation

enum BeerSearchAction: ReduxAction {
 
    case getBeers(food: String, page: Int, perPage: Int)
    case setBeers(beers: [BeerModel])
    
}
