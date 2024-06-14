//
//  AsyncImage.swift
//  Cryptocurrencies
//
//  Created by Nati on 12/06/2024.
//

import Foundation
import SwiftUI

struct AsyncImageResizable: View{
    let url: URL?
    let contentMode: ContentMode
    
    var body: some View{
        AsyncImage(url: url) { phase in
           switch phase {
           case .empty:
               ProgressView()
           case .success(let image):
               image.resizable()
                    .aspectRatio(contentMode: contentMode)
           case .failure:
               Image(systemName: "photo")
           @unknown default:
               EmptyView()
           }
        }
    }
}
