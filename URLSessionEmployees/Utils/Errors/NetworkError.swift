//
//  NetworkError.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 23/09/22.
//

import Foundation

enum NetworkError: Error{
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError
    case urlError
    case unknownedError(Error)
}
