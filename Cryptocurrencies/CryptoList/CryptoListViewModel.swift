//
//  CryptoListViewModel.swift
//  Cryptocurrencies
//
//  Created by Nati on 10/06/2024.
//

import Foundation
import Combine

class CryptoListViewModel: ObservableObject{
    
    enum State{
        case loading
        case loaded(cryptoItems: [CryptoCurrency], fiatItems: [FiatResults.FiatCurrency])
        case error(msg: String)
    }
    
    private let timerFetchMinuts: TimeInterval = 10
    
    @Published var cryptoItems = [CryptoCurrency]()
    @Published var fiatItems = [FiatResults.FiatCurrency]()
    @Published var selectedFiat = "usd"
    @Published var error: String?
    @Published var presntError = false
    @Published var loading = false

    private var paginator: Paginator
    private var apiService: CurrencyServiceAPI
    private var subscriptions = [AnyCancellable]()

    init(apiService: CurrencyServiceAPI) {
        self.apiService = apiService
        paginator = apiService.usingPagination
        setupTimer()
        fetchCrypto()
        fetchFiat()
    }
    
    func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: timerFetchMinuts * 60, repeats: true, block: { b in
            self.fetchCrypto()
        })
    }
    
    func chooseFiat(str: String) {
        selectedFiat = str
        cryptoItems = []
        paginator.clear()
        fetchCrypto()
    }
    
    func fetchFiat(){
        let publisher : AnyPublisher<FiatResults, Error> = apiService
            .getAllItems()
        publisher.receive(on: DispatchQueue.main)
            .sink { err in
            print(err)
        } receiveValue: { [weak self] items in
            self?.fiatItems = items.data
        }.store(in: &subscriptions)
    }
    
    func fetchCrypto(){
        loading = true
        paginator.fetchNext(queryParams: [("vs_currency", selectedFiat)])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] res in
            if case .failure(let failure) = res {
                self?.error = failure.localizedDescription
                self?.presntError = true
            }
            self?.loading = false
        }, receiveValue: { [weak self] items in
            self?.cryptoItems.append(contentsOf: items)
            self?.loading = false
        }).store(in: &subscriptions)
    }
    
}
