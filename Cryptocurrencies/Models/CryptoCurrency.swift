//
//  CryptoCurrency.swift
//  Cryptocurrencies
//
//  Created by Nati on 10/06/2024.
//

import Foundation
import SwiftData

//@Model
//final class
struct CryptoCurrency: Decodable{
    
    enum CodingKeys: String, CodingKey {
        case low24h = "low_24h"
        case high24h = "high_24h"
        case id
        case name
        case symbol
        case image
        case currentPrice = "current_price"
        case lastUpdated = "last_updated"
    }
    
    let id : String
    let name : String
    let symbol : String
    let image : String
    let currentPrice : Double
    let high24h : Double?
    let low24h : Double?
    let lastUpdated : String
}

extension CryptoCurrency: Hashable {
    static func == (lhs: CryptoCurrency, rhs: CryptoCurrency) -> Bool {
        lhs.id == rhs.id &&
        lhs.lastUpdated == rhs.lastUpdated &&
        lhs.currentPrice == rhs.currentPrice
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(lastUpdated)
        hasher.combine(currentPrice)
    }
}
