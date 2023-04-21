//
//  AsyncEmployessRepository.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 20/04/23.
//

import Foundation

protocol AsyncEmployeesRepo {
    
    func getEmployeesAsync () async throws -> Employees
    func createEmployeeAsync(employee: NewUser) async throws -> Employee
    func updateEmployeeAsync(employee: User) async throws -> Employee
    func deleteEmployeeAsync(employee: User) async throws -> Bool
}

final class AsyncEmployeesRepository: AsyncEmployeesRepo{
    
    private let asyncEmployeesDatasource: AsyncEmployeesData
    
    init(asyncEmployeesDatasource: AsyncEmployeesData = AsyncEmployeesDatasource()){
        self.asyncEmployeesDatasource = asyncEmployeesDatasource
    }
        
    func getEmployeesAsync () async throws -> Employees {
        try await asyncEmployeesDatasource.getEmployeesAsync()
    }
    
    func createEmployeeAsync(employee: NewUser) async throws -> Employee{
        try await asyncEmployeesDatasource.createEmployeeAsync(employee: employee)
    }
    
    func updateEmployeeAsync(employee: User) async throws -> Employee{
        try await asyncEmployeesDatasource.updateEmployeeAsync(employee: employee)
    }
    
    func deleteEmployeeAsync(employee: User) async throws -> Bool{
        try await asyncEmployeesDatasource.deleteEmployeeAsync(employee: employee)
    }
    
}
