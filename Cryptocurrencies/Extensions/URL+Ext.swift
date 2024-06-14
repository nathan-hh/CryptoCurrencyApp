//
//  URL+Ext.swift
//  Cryptocurrencies
//
//  Created by Nati on 12/06/2024.
//

import Foundation

extension URL{
    
    init?(string: String, with params: [String:String]?) {
        guard let url = URL(string: string) else {return nil}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = []
        params?.forEach({ (key, value) in
            components?.queryItems?.append(URLQueryItem(name: key, value: value))
        })
        guard let finalUrl = components?.url?.absoluteString else { return nil }
        self.init(string: finalUrl)
    }
    
}
