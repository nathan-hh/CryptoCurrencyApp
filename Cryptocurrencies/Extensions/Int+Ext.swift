//
//  Int+Ext.swift
//  Cryptocurrencies
//
//  Created by Nati on 11/06/2024.
//

import Foundation
import SwiftUI

extension Double{
    var toString: String{
        return String(self)
    }
}

extension String{
    
    var dateFormated: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let date = dateFormatter.date(from: self) else {
            return "Error"
        }
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "HH:mm:ss-yyyy.MM.dd"

        return dateFormatter.string(from: date)
    }
    
}
