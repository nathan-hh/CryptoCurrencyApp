//
//  RangeReplaceableCollection+Ext.swift
//  Cryptocurrencies
//
//  Created by Nati on 12/06/2024.
//

import Foundation

extension RangeReplaceableCollection where Element: Equatable {
    
    mutating func addOrReplace(_ elements: [Element]) {
        for e in elements{
            if let index = self.firstIndex(of: e) {
                replaceSubrange(index...index, with: [e])
            }
            else {
                append(e)
            }
        }
    }
    
}

extension Array{
    
    public var fiveBeforeTheLast: Element?{
        guard count > 5 else { return nil }
        return suffix(5).first
    }

}
