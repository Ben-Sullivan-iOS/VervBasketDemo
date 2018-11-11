//
//  Result.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import Foundation

typealias ResultBlock<T> = (Result<T>) -> ()

enum Result<T> {
    case value(T)
    case error(Error)
}

enum NetworkServiceError: Error {
    case failedToCreateURL
    case unknownError
}
