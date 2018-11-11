//
//  NetworkService.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import Foundation

protocol NetworkService { }

extension NetworkService {
    
    func getCurrencies(completion: @escaping ResultBlock<CurrencyResult>) {
        
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=8f800d1b7e3ee1e3b84225659d8e614b&format=1") else {
            completion(Result.error(NetworkServiceError.failedToCreateURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(Result.error(error ?? NetworkServiceError.unknownError))
                return
            }
            
            do {
                let currencyResult = try JSONDecoder().decode(CurrencyResult.self, from: data)
                completion(Result.value(currencyResult))
            } catch {
                completion(Result.error(error))
            }
        }
        
        task.resume()
    }
}
