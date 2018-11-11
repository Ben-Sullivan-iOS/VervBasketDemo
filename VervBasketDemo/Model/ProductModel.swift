//
//  ProductModel.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import Foundation

struct Product {
    let name: String
    let price: Float
    //TODO: Add currency so price string can provide appropriate symbols
    //Default is EUR as this is the default API result
    var priceString: String {
        return "€" + (String(format: "%.2f", price))
    }
}
