//
//  CheckoutVCModel.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import Foundation

protocol CheckoutVCModelType: class {
    var basket: Basket { get set }
    var allCurrencies: [Currency]? { get set }
    func changeToCurrency(atIndex index: Int)
}

class CheckoutVCModel: CheckoutVCModelType, NetworkService {
    
    var basket: Basket
    var allCurrencies: [Currency]? {
        didSet {
            delegate?.reloadData()
        }
    }
    
    func changeToCurrency(atIndex index: Int) {
        guard let currency = allCurrencies?[index] else { return }
        basket.changeCurrency(to: currency)
        delegate?.reloadData()
    }
    
    weak var delegate: CheckoutVCDelegate?
    
    init(basket: Basket) {
        self.basket = basket
        
        getCurrencies { result in
            
            switch result {
            case .value(let currencyResult):
                var tempCurrencies = [Currency]()
                currencyResult.currencies.forEach({ key, value in
                    let currency = Currency(uid: key, rate: value)
                    tempCurrencies.append(currency)
                })
                
                self.allCurrencies = tempCurrencies
            case .error(let error):
                dump(error)
            }
        }
    }
}
