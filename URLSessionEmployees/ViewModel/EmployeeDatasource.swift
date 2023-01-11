//
//  EmployeeDatasource.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 23/09/22.
//

import Foundation


final class EmployeeDatasource {
    
    private let urlBase = "https://gorest.co.in/public/v1/users"
    private let token = "4dfa830ba988219d7ae75b3b267538bbeaba79d2da09afdfa9fba0eed7a59040"
    
    
    
    func getEmployees(completionBlock: @escaping (Result<Employees, NetworkError>) -> Void){
        guard let url = URL(string: "\(urlBase)") else {
            completionBlock(.failure(.urlError))
            return
        }
//Esta es otra manera de generar la peticion
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        URLSession.shared.dataTask(with: request) { data, response, error in
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionBlock(.failure(.transportError(error)))
                return
            }
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completionBlock(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completionBlock(.failure(.noData))
                return
            }
            do {
                let employeesDataModel = try JSONDecoder().decode(Employees.self, from: data)
                completionBlock(.success(employeesDataModel))
            } catch {
                completionBlock(.failure(.decodingError(error)))
                print(String(describing: error))
                return
            }
        }.resume()
    }
    
    func createEmployee(employee: NewUser, completionBlock: @escaping (Result<Employee, NetworkError>) -> Void){
        guard let url = URL(string: "\(urlBase)") else {
            completionBlock(.failure(.urlError))
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(employee) else {
            completionBlock(.failure(.encodingError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error creando " + error.localizedDescription)
                completionBlock(.failure(.transportError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                completionBlock(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completionBlock(.failure(.noData))
                return
            }
            
            do{
                let employeeDataModel = try JSONDecoder().decode(Employee.self, from: data)
                completionBlock(.success(employeeDataModel))
                return
            }catch{
                completionBlock(.failure(.decodingError(error)))
                return
            }
        }.resume()
    }
    
    
    
    func updateEmployee(employee: User, completionBlock: @escaping (Result<Employee, NetworkError>) -> Void){
        
        guard let url = URL(string: "\(urlBase)/\(employee.id)") else{
            completionBlock(.failure(.urlError))
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(employee) else {
            completionBlock(.failure(.encodingError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error actualizando " + error.localizedDescription)
                completionBlock(.failure(.transportError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                completionBlock(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completionBlock(.failure(.noData))
                return
            }
            
            do {
                let employeeDataModel = try JSONDecoder().decode(Employee.self, from: data)
                completionBlock(.success(employeeDataModel))
            } catch {
                completionBlock(.failure(.decodingError(error)))
                return
            }
        }.resume()
    }
    
    func deleteEmployee(employee: User, completionBlock: @escaping (Result<Bool, NetworkError>) -> Void){
        guard let url = URL(string: "\(urlBase)/\(employee.id)") else {
            completionBlock(.failure(.urlError))
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(employee) else {
            completionBlock(.failure(.encodingError))
            return
        }
        
        
        print("URL delete \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionBlock(.failure(.transportError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completionBlock(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            completionBlock(.success(false))
            
        }.resume()
    }
}
