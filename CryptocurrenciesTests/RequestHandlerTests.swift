//
//  RequestHandlerTests.swift
//  CryptocurrenciesTests
//
//  Created by Nati on 13/06/2024.
//

import XCTest
import Combine
@testable import Cryptocurrencies

final class RequestHandlerTests: XCTestCase {
    var session: URLSession!
    var requestHandler: RequestHandlerProtocol!
    private var subscriptions = [AnyCancellable]()

    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        requestHandler = RequestHandler(session: session)
    }

    override func tearDown() {
        session = nil
        requestHandler = nil
        subscriptions = []
        super.tearDown()
    }

    func testRequest() throws {
        let expectation = self.expectation(description: "RequstData")
        let url = URL(string: "https://api.coinbase.com/v2/currencies")!

        let path = Bundle(for: type(of: self)).path(forResource: "Data", ofType: "json")!
        let mockData = try! Data(contentsOf: URL(fileURLWithPath: path))
        let response = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let handler : AnyPublisher<RequestHandler.Response<FiatResults>, Error> = requestHandler.fetch(URLRequest(url: url), JSONDecoder(), errorType: CurrencyError.self)
        handler.sink { res in
            if case .failure = res{
                XCTAssertThrowsError(res)
            }
        } receiveValue: { response in
            let data = response.value.data
            XCTAssertEqual(data.first?.id, "AED")
            XCTAssertEqual(data[1].name, "Afghan Afghani")
            XCTAssertEqual(data.count, 2)
            expectation.fulfill()
        }.store(in: &subscriptions)

        wait(for: [expectation], timeout: 2.0)
    }

}
