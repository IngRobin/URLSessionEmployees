//
//  AsyncEmployessDatasource.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 20/04/23.
//

import Foundation

protocol AsyncEmployeesData {
    
    func getEmployeesAsync () async throws -> Employees
    func createEmployeeAsync(employee: NewUser) async throws -> Employee
    func updateEmployeeAsync(employee: User) async throws -> Employee
    func deleteEmployeeAsync(employee: User) async throws -> Bool
}

final class AsyncEmployeesDatasource: AsyncEmployeesData {
    
    private let urlBase = "https://gorest.co.in/public/v1/users"
    private let token = "4dfa830ba988219d7ae75b3b267538bbeaba79d2da09afdfa9fba0eed7a59040"
    
    func getEmployeesAsync () async throws -> Employees {
        guard let url = URL(string: "\(urlBase)") else {
            throw NetworkError.urlError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let responseData = response as! HTTPURLResponse
        
        if(responseData.statusCode == 200) {
            let parsedResponseBody = try JSONDecoder().decode(Employees.self, from: data)
            
            return parsedResponseBody
        }
        else {
            throw NetworkError.serverError(statusCode: responseData.statusCode)
        }
    }
    
    func createEmployeeAsync(employee: NewUser) async throws -> Employee{
        guard let url = URL(string: "\(urlBase)") else {
            throw NetworkError.urlError
        }
        
        guard (try? JSONEncoder().encode(employee)) != nil else {
            throw NetworkError.encodingError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let responseData = response as! HTTPURLResponse
        
        if (responseData.statusCode == 200){
            let parsedResponsebody = try JSONDecoder().decode(Employee.self, from: data)
            return parsedResponsebody
        } else {
            throw NetworkError.serverError(statusCode: responseData.statusCode)
        }
        
    }
    
    func updateEmployeeAsync(employee: User) async throws -> Employee {
        guard let url = URL(string: "\(urlBase)/\(employee.id)") else{
            throw NetworkError.urlError
        }
        guard let jsonData = try? JSONEncoder().encode(employee) else {
            throw NetworkError.encodingError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let responseData = response as! HTTPURLResponse
        
        if (responseData.statusCode == 200){
            let parsedResponsedBody = try JSONDecoder().decode(Employee.self, from: data)
            return parsedResponsedBody
        }else{
            throw NetworkError.serverError(statusCode: responseData.statusCode)
        }
        
    }
    
    func deleteEmployeeAsync(employee: User) async throws -> Bool {
        guard let url = URL(string: "\(urlBase)/\(employee.id)") else {
            throw NetworkError.urlError
        }
        guard let jsonData = try? JSONEncoder().encode(employee) else {
            throw NetworkError.encodingError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        let (_, response) = try await URLSession.shared.data(for: request)
        let responseData = response as! HTTPURLResponse
        if (responseData.statusCode == 200){
            return true
        } else {
            throw NetworkError.serverError(statusCode: responseData.statusCode)
        }
        
    }
}

