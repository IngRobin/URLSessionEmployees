//
//  EmployeesModel.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 23/09/22.
//

import Foundation

struct Employees: Decodable{
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}


