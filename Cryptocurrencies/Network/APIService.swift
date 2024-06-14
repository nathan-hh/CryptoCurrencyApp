//
//  APIService.swift
//  Cryptocurrencies
//
//  Created by Nati on 11/06/2024.
//

import Foundation
import Combine

protocol APIService {
    var requestHandler: RequestHandlerProtocol { get }

    func getAllItems<Item: Decodable>(queryParams: [(String, String)]?) -> AnyPublisher<Item, Error>
    func get<Item: Decodable>(page: Int, perPage: Int?, queryParams: [(String, String)]?) -> AnyPublisher<[Item], Error>
}

struct CurrencyServiceAPI: APIService{
    var requestHandler: RequestHandlerProtocol { handler }
    let handler = RequestHandler()

    let fiatCurrenciesUrl = "https://api.coinbase.com/v2/currencies"
    let cryptoCurrenciesUrl = "https://api.coingecko.com/api/v3/coins/markets"
    
    func get<Item>(page: Int, perPage: Int? = 30, queryParams: [(String, String)]? = nil) -> AnyPublisher<[Item], any Error> where Item : Decodable {
        var params = ["page": "\(page)"]
        params["per_page"] = "\(perPage!)"
        
        queryParams?.forEach { s in
            params[s.0] = s.1
        }
        let url = URL(string: cryptoCurrenciesUrl, with: params)!
        return request(URLRequest(url: url))
    }
    
    func getAllItems<Item>(queryParams: [(String, String)]? = nil) -> AnyPublisher<Item, any Error> where Item : Decodable {
        let url = URL(string: fiatCurrenciesUrl)!
        return request(URLRequest(url: url))
    }
    
    private func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
        
        return requestHandler.fetch(request, decoder, errorType: CurrencyError.self)
            .map(\.value)
            .eraseToAnyPublisher()
    }

}
