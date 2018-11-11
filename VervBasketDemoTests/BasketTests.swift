//
//  VervBasketDemoTests.swift
//  VervBasketDemoTests
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import XCTest
@testable import VervBasketDemo

class BasketTests: XCTestCase {
    
    var basket: Basket?

    override func setUp() {
        let currency = Currency(uid: "EUR", rate: 1)
        basket = Basket(currency: currency)
    }

    override func tearDown() {
        basket = nil
    }

    func testAddProduct() {
        let product = Product(name: "Test", price: 1)
        basket?.add(product: product)
        
        XCTAssert(basket?.items.count == 1)
        XCTAssert(basket?.items.first?.quantity == 1)

        basket?.add(product: product)
        basket?.add(product: product)
        basket?.add(product: product)

        XCTAssert(basket?.items.first?.quantity == 4)
    }
    
    func testDecreaseQuantity() {
        let product = Product(name: "Test", price: 1)
        basket?.add(product: product)
        basket?.add(product: product)
        basket?.add(product: product)

        XCTAssert(basket?.items.first?.quantity == 3)

        basket?.decreaseQuantity(forProduct: product)
        
        XCTAssert(basket?.items.first?.quantity == 2)
        
        basket?.decreaseQuantity(forProduct: product)
        basket?.decreaseQuantity(forProduct: product)
        basket?.decreaseQuantity(forProduct: product)
        basket?.decreaseQuantity(forProduct: product)

        XCTAssert(basket?.items.count == 0)
    }
    
    func testRemoveProduct() {
        let product = Product(name: "Test", price: 1)
        basket?.add(product: product)
        basket?.add(product: product)
        basket?.add(product: product)

        XCTAssert(basket?.items.first?.quantity == 3)

        basket?.remove(product: product)
        
        XCTAssert(basket!.items.isEmpty)
    }
    
}
