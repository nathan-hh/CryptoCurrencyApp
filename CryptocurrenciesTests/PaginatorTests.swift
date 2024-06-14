//
//  PaginatorTests.swift
//  CryptocurrenciesTests
//
//  Created by Nati on 10/06/2024.
//

import XCTest
@testable import Cryptocurrencies

final class PaginatorTests: XCTestCase {
    var paginator: ApiPaginator<CurrencyServiceAPI>!

    override func setUp() {
        super.setUp()
        let mockApiService = CurrencyServiceAPI()
        paginator = ApiPaginator(apiService: mockApiService)
    }

    override func tearDown() {
        paginator = nil
        super.tearDown()
    }

//    func testFetchNextPage() throws {
//        let expectation = self.expectation(description: "Fetch next page")
//        paginator.fetchNext(queryParams: []).sink { result in
//            switch result {
//            case .failure(let error):
//                XCTFail("Failed with error: \(error.localizedDescription)")
//            case .finished:
//                break
//            }
//            expectation.fulfill()
//        } receiveValue: { items in
//            XCTAssertEqual(items.count, 2, "Expected 2 items per page")
//        }
//
//        wait(for: [expectation], timeout: 2.0)
//    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
