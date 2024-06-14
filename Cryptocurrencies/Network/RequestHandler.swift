//
//  RequestHandler.swift
//  Cryptocurrencies
//
//  Created by Nati on 10/06/2024.
//

import Foundation
import Combine

protocol RequestHandlerProtocol {
    func fetch<T: Decodable, Failure: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder, errorType: Failure.Type?) -> AnyPublisher<RequestHandler.Response<T>, Error> where Failure: Error
}

struct RequestHandler: RequestHandlerProtocol {
    private var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func fetch<T: Decodable, Failure: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder, errorType: Failure.Type? = nil) -> AnyPublisher<Response<T>, Error> where Failure: Error{
        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                if let value = try? decoder.decode(T.self, from: result.data){
                    return Response(value: value, response: result.response)
                }else if let errorType{
                    throw try decoder.decode(errorType.self, from: result.data)
                }else{
                    throw NetworkError.failedToDecodeResponse
                }
            }
            .eraseToAnyPublisher()
    }

}

enum RequestMethod : String {
    case get = "GET"
}

enum NetworkError: Error {
    case invalidURL
    case failedToDecodeResponse
}
