//
//  SelectProductModel.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import Foundation

protocol SelectProductModelType {
    mutating func addToBasket(productIndex index: Int)
    mutating func setNewBasket(_ basket: Basket)
    var products: [Product] { get set }
    var basket: Basket { get }
}

struct SelectProductModel: SelectProductModelType {
    
    private(set) var basket: Basket
    var products: [Product]
    
    init() {
        self.products = DummyDataCreator().createDummyProducts()
        
        //  TODO: Get initial currency from API and inject into model
        let currency = Currency(uid: "GBP", rate: 0.873592)
        basket = Basket(currency: currency)
        
    }
    
    mutating func addToBasket(productIndex index: Int) {
        //  TODO: Add error handling
        guard products.indices.contains(index) else { return }
        basket.add(product: products[index])
        print(basket)
    }
    
    mutating func setNewBasket(_ basket: Basket) {
        self.basket = basket
    }
    
}

//TODO: Replace with API call
struct DummyDataCreator {
    func createDummyProducts() -> [Product] {
        
        let coffee = Product(name: "Coffee", price: 2.30)
        let tea = Product(name: "Tea", price: 3.10)
        let sugar = Product(name: "Sugar", price: 2.00)
        let milk = Product(name: "Milk", price: 1.20)
        let cup = Product(name: "Cup", price: 0.50)
        
        return [coffee, tea, sugar, milk, cup]
    }
}
