//
//  MockApiService.swift
//  CryptocurrenciesTests
//
//  Created by Nati on 11/06/2024.
//
//
//import Foundation
//import Combine
//@testable import Cryptocurrencies
//
//class MockRequestHandler: RequestHandlerProtocol{
//    func fetch<T, Failure>(_ request: URLRequest, _ decoder: JSONDecoder, errorType: Failure.Type?) -> AnyPublisher<Cryptocurrencies.RequestHandler.Response<T>, any Error> where T : Decodable, Failure : Decodable, Failure : Error {
//        <#code#>
//    }
//}
//
//class MockApiService: APIService {
//    var requestHandler: RequestHandlerProtocol { MockRequestHandler()}
//    
//    func getAllItems<Item>(queryParams: [(String, String)]?) -> AnyPublisher<Item, any Error> where Item : Decodable {
//        return Just(FiatResults(data: [], err: "") as! Item)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
//    }
//    
//    func get<Item>(page: Int, perPage: Int?, queryParams: [(String, String)]?) -> AnyPublisher<[Item], any Error> where Item : Decodable {
//        return Just([CryptoCurrency(id: "btc", name: "", symbol: "", image: "", currentPrice: 1.0, high24h: 1.0, low24h: 1.0, lastUpdated: "")])
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
//    }
//
//}
