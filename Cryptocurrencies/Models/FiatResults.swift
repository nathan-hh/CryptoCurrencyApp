//
//  FiatResults.swift
//  Cryptocurrencies
//
//  Created by Nati on 12/06/2024.
//

import Foundation

struct FiatResults :Decodable {

    struct FiatCurrency :Decodable {
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case minSize = "min_size"
        }
        
        let id : String
        let name : String
        let minSize : String
    }
    
    let data : [FiatCurrency]
    var err : String?
}


