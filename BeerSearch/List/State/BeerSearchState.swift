//
//  BeerSearchState.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import Foundation

struct BeerSearchState: ReduxState {
    
    let beers: [BeerModel]
    var searchText: String
    var page: Int
    let perPage: Int
    var isLoading: Bool
    
    init(beers: [BeerModel] = [],
         searchText: String = "",
         page: Int = 1,
         perPage: Int = 5,
         isLoading: Bool = false) {
        self.beers = beers
        self.searchText = searchText
        self.page = page
        self.perPage = perPage
        self.isLoading = isLoading
    }
    
    func build(beers: [BeerModel]? = nil,
               searchText: String? = nil,
               page: Int? = nil,
               perPage: Int? = nil,
               isLoading: Bool? = nil) -> BeerSearchState {
        .init(beers: beers ?? self.beers,
              searchText: searchText ?? self.searchText,
              page: page ?? self.page,
              perPage: perPage ?? self.perPage,
              isLoading: isLoading ?? self.isLoading)
    }
    
}

struct BeerModel: Codable, Identifiable {
    
    let id: Int
    let name: String
    let description: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageUrl = "image_url"
    }
    
    init(id: Int = 0,
         name: String = "",
         description: String = "",
         imageUrl: String = "") {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
    }
    
}
