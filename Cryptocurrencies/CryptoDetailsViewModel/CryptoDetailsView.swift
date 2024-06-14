//
//  CryptoDetailsView.swift
//  Cryptocurrencies
//
//  Created by Nati on 10/06/2024.
//

import SwiftUI

struct CryptoDetailsView: View {
    
    @Binding var currency: CryptoCurrency

    var body: some View {
        VStack(alignment: .leading){
            AsyncImageResizable(url: URL(string: currency.image), contentMode: .fit)
                .clipShape(Circle())
                .padding(.horizontal, 120)
            VStack(alignment: .leading){
                Text(currency.symbolDisplay)
                Text(currency.high24hDisplay)
                Text(currency.low24hDisplay)
                Text(currency.lastUpdatedDisplay)
            }.padding(24)
            
            Spacer()
        }
        .font(.title2)
    }
}

extension CryptoCurrency{
    var symbolDisplay: String{
        "Symbol: " + symbol.uppercased()
    }
    var high24hDisplay: String{
        if let high24h{
            return "Highest price: \(high24h.toString)"
        }
        return "Highest price: No data"
    }
    var low24hDisplay: String{
        if let low24h{
            return "Lowest price: \(low24h.toString)"
        }
        return "Highest price: No data"
    }
    var lastUpdatedDisplay: String{
        "Last update: " + lastUpdated.dateFormated
    }
}

#Preview {
    CryptoDetailsView(currency: Binding.constant(CryptoCurrency(id: "btc", name: "j", symbol: "nbkj", image: "knj", currentPrice: 1, high24h: 1, low24h: 1, lastUpdated: "nkj")))
}
