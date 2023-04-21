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
    
    var descriptionError: String {
        switch self{
            
        case .transportError(let error):
            return "Error del transporte de la peticion \(error.localizedDescription)"
        case .serverError(statusCode: let statusCode):
            return "Error del servidor \(statusCode)"
        case .noData:
            return "Error, no hay data"
        case .decodingError(let error):
            return "Error generando la decodificacion de la data \(error.localizedDescription)"
        case .encodingError:
            return "Error generando la codificacion de la data"
        case .urlError:
            return "Error en la creacion de la url"
        case .unknownedError(let error):
            return "Error desconocido \(error.localizedDescription)"
        }
    }
}


