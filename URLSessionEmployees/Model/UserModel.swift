//
//  EmployeeModel.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 23/09/22.
//

import Foundation


struct User: Decodable, Encodable, Identifiable, Hashable{
    var id: Int 
    var name: String?
    var email: String?
    var sex: String?

    enum Codingkeys: String, CodingKey {
        case id
        case name
        case email
        case sex = "gender"
    }
}

