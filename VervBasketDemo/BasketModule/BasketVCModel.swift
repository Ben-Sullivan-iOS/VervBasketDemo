//
//  BasketModel.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import Foundation

protocol BasketVCModelType {
    var basket: Basket { get }
    mutating func increaseQuantity(product: Product)
    mutating func decreaseQuantity(product: Product)
}

struct BasketVCModel: BasketVCModelType {
    
    private(set) var basket: Basket
    
    init(basket: Basket) {
        self.basket = basket
    }
    
    mutating func increaseQuantity(product: Product) {
        basket.add(product: product)
    }
    
    mutating func decreaseQuantity(product: Product) {
        basket.decreaseQuantity(forProduct: product)
    }
}
