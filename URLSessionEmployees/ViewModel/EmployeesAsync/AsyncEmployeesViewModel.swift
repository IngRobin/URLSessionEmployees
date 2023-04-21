//
//  AsyncEmployeesViewModel.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 20/04/23.
//

import Foundation

final class AsyncEmployeesViewModel: ObservableObject{
    
    @Published var employees: [User] = []
    @Published var messageError: String?
    @Published var alertError: Bool = false
    
    private var asyncEmployeesRepository: AsyncEmployeesRepo
    
    init(asyncEmployeesRepository: AsyncEmployeesRepo = AsyncEmployeesRepository()){
        self.asyncEmployeesRepository = asyncEmployeesRepository
    }
       
    func getEmployeesAsync(){
        DispatchQueue.main.async {
            Task{
                do{
                    let users = try await self.asyncEmployeesRepository.getEmployeesAsync()
                    self.employees = users.users
                }catch let error as NetworkError {
                    self.messageError = error.descriptionError
                    self.alertError = true
                }
            }
        }
    }
    
    func createEmployeeAsync(employee: NewUser){
        DispatchQueue.main.async {
            Task{
                do{
                    _ = try await self.asyncEmployeesRepository.createEmployeeAsync(employee: employee)
                }catch let error as NetworkError {
                    self.messageError = error.descriptionError
                }
            }
        }
    }
    
    func deleteEmployeeAsync(employee: User){
        DispatchQueue.main.async {
            Task{
                do{
                    _ = try await self.asyncEmployeesRepository.deleteEmployeeAsync(employee: employee)
                }catch let error as  NetworkError{
                    self.messageError = error.descriptionError
                    self.alertError = true
                }
            }
        }
    }
    
    func updateEmployeeAsync(employee: User){
        DispatchQueue.main.async {
            Task{
                do{
                    _ = try await self.asyncEmployeesRepository.updateEmployeeAsync(employee: employee)
                }catch let error as NetworkError{
                    self.messageError = error.descriptionError
                    self.alertError = true
                }
            }
        }
    }
}


