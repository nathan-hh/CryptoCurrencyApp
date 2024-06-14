//
//  CurrencyError.swift
//  Cryptocurrencies
//
//  Created by Nati on 13/06/2024.
//

import Foundation

struct CurrencyError: Decodable, Error, LocalizedError{
    let error : String?
    let status : Status?

    struct Status: Decodable{
        let error_code: Int?
        let error_message: String?
    }
    
    var errorDescription: String?{
        switch error{
        case "invalid vs_currency":
            return "The selected fiat currency is not supported."
        default:
            return error ?? status?.error_message
        }
    }
    
}
