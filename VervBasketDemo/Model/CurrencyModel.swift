//
//  CurrencyModel.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import Foundation

struct CurrencyResult: Codable {
    let success: Bool
    let name: String
    let date: String
    let currencies: [Currency]
    
    enum CodingKeys: String, CodingKey {
        case success
        case date
        case currencies = "rates"
        case name = "base"
    }
}

struct Currency: Codable {
    let uid: String
    let rate: Float
}
