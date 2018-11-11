//
//  NetworkServiceTests.swift
//  VervBasketDemoTests
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import XCTest
@testable import VervBasketDemo

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService?
    
    override func setUp() {
        let currency = Currency(uid: "EUR", rate: 1)
        let basket = Basket(currency: currency)
        networkService = CheckoutVCModel(basket: basket)
    }
    
    func testJSONDecoderSuccess() {
        
        let currencyResult = CurrencyResult(success: true, name: "Test", date: "Test", currencies: ["Test" : 1])
    
        let encodedJSON = try! JSONEncoder().encode(currencyResult)
        
        networkService?.decodeCurrencyData(data: encodedJSON, completion: { result in
            
            switch result {
            case .value(let val):
                XCTAssert(val.date == "Test")
                XCTAssert(val.name == "Test")
                XCTAssert(val.success == true)
                XCTAssert(val.currencies == ["Test" : 1])
            case .error(let error):
                XCTAssert(error.localizedDescription == "bro")
            }
        })
    }
    
    func testJSONDecoderFail() {
        
        networkService?.decodeCurrencyData(data: Data(), completion: { result in
            
            switch result {
            case .error(let error):
                print(error.localizedDescription)
                XCTAssert(error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format.")
            default: XCTAssertTrue(false)
            }
        })
    }
    
}
