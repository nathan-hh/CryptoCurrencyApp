//
//  CryptocurrenciesApp.swift
//  Cryptocurrencies
//
//  Created by Nati on 10/06/2024.
//

import SwiftUI
import SwiftData

@main
struct CryptocurrenciesApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            CryptoCurrency.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            CryptoListView(viewModel: CryptoListViewModel(apiService: CurrencyServiceAPI()))
        }
//        .modelContainer(sharedModelContainer)
    }
}
