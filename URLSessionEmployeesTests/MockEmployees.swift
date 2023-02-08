//
//  MockEmployees.swift
//  URLSessionEmployeesTests
//
//  Created by Robinson Gonzalez on 2/02/23.
//

import Foundation
@testable import URLSessionEmployees

class MockEmployees: EmployeeData{
    func getEmployees(completionBlock: @escaping (Result<URLSessionEmployees.Employees, URLSessionEmployees.NetworkError>) -> Void) {
        completionBlock(.success(decodeData()))
    }
    
    func createEmployee(employee: URLSessionEmployees.NewUser, completionBlock: @escaping (Result<URLSessionEmployees.Employee, URLSessionEmployees.NetworkError>) -> Void) {
//        completionBlock(.success(decodeData()))
    }
    
    func updateEmployee(employee: URLSessionEmployees.User, completionBlock: @escaping (Result<URLSessionEmployees.Employee, URLSessionEmployees.NetworkError>) -> Void) {
//        completionBlock(.success(decodeData()))
    }
    
    func deleteEmployee(employee: URLSessionEmployees.User, completionBlock: @escaping (Result<Bool, URLSessionEmployees.NetworkError>) -> Void) {
//        completionBlock(.success(decodeData()))
    }
    
    
    func decodeData() -> Employees{
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        return bundle!.decode(Employees.self, from: "Users.json")
    }
    
}
