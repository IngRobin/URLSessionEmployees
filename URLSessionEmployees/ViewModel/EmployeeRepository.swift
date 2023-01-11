//
//  EmployeeRepository.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 23/09/22.
//

import Foundation

final class EmployeeRepository{
    
    private let employeesDatasource: EmployeeDatasource
    
    init(employeeDatasource: EmployeeDatasource = EmployeeDatasource()){
        self.employeesDatasource = employeeDatasource
    }
    
    func getEmployees(completionBlock: @escaping (Result<Employees, NetworkError>) -> Void){
        employeesDatasource.getEmployees(completionBlock: completionBlock)
    }
    
    func createEmployee(employee: NewUser, completionBlock: @escaping (Result<Employee,NetworkError>) -> Void){
        employeesDatasource.createEmployee(employee: employee, completionBlock: completionBlock)
    }
    
    func updateEmployee(employee: User, completionBlock: @escaping (Result<Employee, NetworkError>) -> Void){
        employeesDatasource.updateEmployee(employee: employee, completionBlock: completionBlock)
    }
    
    func deleteEmployee(employee: User, completionBlock: @escaping(Result<Bool, NetworkError>) -> Void){
        employeesDatasource.deleteEmployee(employee: employee, completionBlock: completionBlock)
    }
    
}
