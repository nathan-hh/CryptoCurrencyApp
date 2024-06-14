//
//  CryptoListView.swift
//  Cryptocurrencies
//
//  Created by Nati on 10/06/2024.
//

import SwiftUI
import SwiftData

struct CryptoListView: View {
    @ObservedObject var viewModel: CryptoListViewModel

    var body: some View {
        NavigationSplitView {
            ScrollView{
                CurrencyListView()
                    .overlay {
                        if viewModel.loading{
                            ProgressView()
                        }
                    }
            }.refreshable {
                viewModel.chooseFiat(str: viewModel.selectedFiat)
            }
            .padding(12)
            .navigationTitle("Cryptocurrencies")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $viewModel.presntError){
                Alert(title: Text(viewModel.error!))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    FiatMenuView()
                }
            }
        } detail: {
            Text("Select an item")
        }
        .environmentObject(viewModel)
    }
    
    struct CurrencyListView: View {
        @EnvironmentObject var viewModel: CryptoListViewModel
        
        var body: some View{
            LazyVStack {
                ForEach($viewModel.cryptoItems, id: \.id){ item in
                    NavigationLink(destination: CryptoDetailsView(currency: item)
                    ){
                        CurrencyView(item: item.wrappedValue, fiat: viewModel.selectedFiat)
                            .frame(height: 54)
                            .onAppear {
                                if item.wrappedValue == viewModel.cryptoItems.last {
                                    Task { viewModel.fetchCrypto() }
                                }
                            }
                    }
                    Divider().padding(.leading, 48)
                }
            }
        }
    }

    struct CurrencyView: View {
        let item: CryptoCurrency
        let fiat: String

        var body: some View {
            HStack(spacing: 14){
                AsyncImageResizable(url: URL(string: item.image), contentMode: .fit)
                    .frame(maxWidth: 32, maxHeight: 32)
                    .clipShape(Circle())
                Text(item.symbol.uppercased())
                Spacer()
                Text("\(item.currentPrice.toString) \(fiat.uppercased())")
                Image(systemName: "chevron.right")
                    .font(.body)
            }
        }
    }

    struct FiatMenuView: View {
        @EnvironmentObject var viewModel: CryptoListViewModel
        
        var body: some View{
            Menu {
                ForEach(viewModel.fiatItems, id: \.id){ item in
                    Button(action: {
                        viewModel.chooseFiat(str: item.id.lowercased())
                    }, label: {
                        if item.id.lowercased() == viewModel.selectedFiat.lowercased() {
                            Label(item.id, systemImage: "checkmark")
                        }else{
                            Text(item.id)
                        }
                    })
                }
            } label: {
                Text(viewModel.selectedFiat.uppercased())
            }
        }
    }

}

#Preview {
    CryptoListView(viewModel: CryptoListViewModel(apiService: CurrencyServiceAPI()))
//        .modelContainer(for: CryptoCurrency.self, inMemory: true)
}
