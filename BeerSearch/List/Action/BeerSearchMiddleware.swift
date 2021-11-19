//
//  BeerSearchMiddleware.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import Foundation
import Combine

protocol BeerSearchDatasource: AnyObject {
    
    func getBeers(food: String, page: Int, perPage: Int)
    
}

final class BeerSearchMiddleware: ReduxMiddleware<BeerSearchState>, BeerSearchDatasource {
    
    private weak var datasource: BeerSearchDatasource? {
        self
    }
    
    override func handleDispatch(action: ReduxAction, store: DispatcherObject, parent: DispatcherObject?) {
        switch action {
        case let BeerSearchAction.getBeers(food, page, perPage):
            self.datasource?.getBeers(food: food, page: page, perPage: perPage)
        default:
            break
        }
    }

    //MARK: BeerSearchDatasource
    
    func getBeers(food: String, page: Int = 1, perPage: Int = 20) {
        let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)&per_page=\(perPage)&food=\(food.trimmingCharacters(in: .whitespaces))")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let beers = try? JSONDecoder().decode([BeerModel].self, from: data) {
                self.store?.dispatch(BeerSearchAction.setBeers(beers: beers))
            } else {
                self.store?.dispatch(BeerSearchAction.setBeers(beers: []))
            }
        }
        task.resume()
    }
    
}
