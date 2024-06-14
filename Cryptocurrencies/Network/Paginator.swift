//
//  Paginator.swift
//  Cryptocurrencies
//
//  Created by Nati on 11/06/2024.
//

import Foundation
import Combine

protocol Paginator {
    var currentPage: Int { get set }
    func fetchNext<Item: Equatable & Decodable>(queryParams: [(String, String)]?) -> AnyPublisher<[Item], Error>
    func hasMoreItems() -> Bool
    func clear()
}

class ApiPaginator<Service: APIService>: Paginator {
    private let apiService: Service
    internal var currentPage = 0
    internal var totalNumberOfPages = 0

    init(apiService: Service) {
        self.apiService = apiService
    }
    
    func fetchNext<Item: Equatable & Decodable>(queryParams: [(String, String)]? = nil) -> AnyPublisher<[Item], Error> {
        currentPage += 1
        let getPage: AnyPublisher<[Item], Error> = apiService
            .get(page: currentPage, perPage: 50, queryParams: queryParams)
        return getPage.eraseToAnyPublisher()
    }
    
    func clear() {
        currentPage = 0
    }

    func hasMoreItems() -> Bool {
        return currentPage < totalNumberOfPages
    }
}

extension APIService {
    var usingPagination: any Paginator{
        ApiPaginator<Self>(apiService: self)
    }
}
