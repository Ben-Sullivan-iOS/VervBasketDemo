//
//  BasketModel.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import Foundation

struct BasketItem {
    
    let product: Product
    var quantity: Int
    
    mutating func increaseQuantity() {
        self.quantity += 1
    }
    
    mutating func decreaseQuantity() {
        self.quantity -= 1
    }
}

struct Basket {
    
    private(set) var items: [BasketItem] = []
    private(set) var currency: Currency
    
    var totalPrice: Float {
        let euroTotal = items.reduce(0, { $0 + $1.product.price })
        let result = euroTotal * Float(currency.rate)
        return (result * 100).rounded() / 100
    }
    
    var totalPriceAndCurrencyString: String {
        return String(format: "%.2f", totalPrice) + " \(currency.uid)"
    }
    
    mutating func changeCurrency(to newCurrency: Currency) {
        currency = newCurrency
    }
    
    init(currency: Currency) {
        self.currency = currency
    }
    
    //  Adds product to basket
    //  Increases product quantity by 1 if already added
    mutating func add(product: Product) {
        
        let index = indexFor(product: product)
        
        if let index = index {
            items[index].increaseQuantity()
            return
        }
        
        let basketItem = BasketItem(product: product, quantity: 1)
        items.append(basketItem)
    }
    
    //  Completely removes all instances of a product from basket
    mutating func remove(product: Product) {
        
        let index = indexFor(product: product)
        
        if let index = index {
            items.remove(at: index)
            return
        }
    }
    
    //  Decreases the product quantity by 1
    mutating func decreaseQuantity(forProduct product: Product) {
        
        let index = indexFor(product: product)
        
        if let index = index {
            items[index].decreaseQuantity()
            
            if items[index].quantity < 1 {
                remove(product: product)
            }
            return
        }
    }
    
    private func indexFor(product: Product) -> Int? {
        for i in items.indices where items[i].product.name == product.name {
            return i
        }
        return nil
    }
}
