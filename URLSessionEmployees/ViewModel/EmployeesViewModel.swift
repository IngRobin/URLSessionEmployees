//
//  EmployeesViewModel.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 20/09/22.
//

import Foundation

final class EmployeesViewModel: ObservableObject{
    
    @Published var employees: [User] = []
    @Published var messageError: String?
    @Published var alertError: Bool = false
    
    private let employeesRepository: EmployeeRepository
    
    init(employeeRepository: EmployeeRepository = EmployeeRepository()){
        self.employeesRepository = employeeRepository
        //        1. Manejo de viewModel con EnvironmentObject (Diferente a StateObject)
        //getEmployees()
    }
    
    func getEmployees(){
        employeesRepository.getEmployees { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let employees):
                    self?.employees = employees.users
                case .failure(let error):
                    switch error{
                    case .decodingError(_):
                        self?.messageError = "Error generando la decodificacion de la data \(error.localizedDescription)"
                    case .encodingError:
                        self?.messageError = "Error generando la codificacion de la data \(error.localizedDescription)"
                    case .noData:
                        self?.messageError = "Error con la data \(error.localizedDescription)"
                    case .serverError(let statusCode):
                        self?.messageError = "Error del servidor \(statusCode), \(error.localizedDescription)"
                    case .transportError(_):
                        self?.messageError = "Error del transporte de la peticion \(error.localizedDescription)"
                    case .unknownedError(_):
                        self?.messageError = "Error desconocido \(error.localizedDescription)"
                    case .urlError:
                        self?.messageError = "Error con la creación de la url \(error.localizedDescription)"
                    }
                    self!.alertError = true
                }
            }
        }
    }
    
    func createEmployee(employee: NewUser){
        employeesRepository.createEmployee(employee: employee) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let employee):
                    print(employee.data)
                case .failure(let error):
                    switch error{
                    case .decodingError(_):
                        self?.messageError = "Error generando la decodificacion de la data \(error.localizedDescription)"
                    case .encodingError:
                        self?.messageError = "Error generando la codificacion de la data \(error.localizedDescription)"
                    case .noData:
                        self?.messageError = "Error con la data \(error.localizedDescription)"
                    case .serverError(let statusCode):
                        self?.messageError = "Error del servidor \(statusCode), \(error.localizedDescription)"
                    case .transportError(_):
                        self?.messageError = "Error del transporte de la peticion \(error.localizedDescription)"
                    case .unknownedError(_):
                        self?.messageError = "Error desconocido \(error.localizedDescription)"
                    case .urlError:
                        self?.messageError = "Error con la creación de la url \(error.localizedDescription)"
                    }
                    self!.alertError = true
                }
            }
        }
    }
    
    func deleteEmployee(employee: User){
        employeesRepository.deleteEmployee(employee: employee) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    switch success{
                    case false: break
                        //TODO
                    case true: break
                        //TODO
                    }
                case .failure(let error):
                    print(String(describing: error))
                    switch error{
                    case .decodingError(_):
                        self?.messageError = "Error generando la decodificacion de la data \(error.localizedDescription)"
                    case .encodingError:
                        self?.messageError = "Error generando la codificacion de la data \(error.localizedDescription)"
                    case .noData:
                        self?.messageError = "Error con la data \(error.localizedDescription)"
                    case .serverError(let statusCode):
                        self?.messageError = "Error del servidor \(statusCode), \(error.localizedDescription)"
                    case .transportError(_):
                        self?.messageError = "Error del transporte de la peticion \(error.localizedDescription)"
                    case .unknownedError(_):
                        self?.messageError = "Error desconocido \(error.localizedDescription)"
                    case .urlError:
                        self?.messageError = "Error con la creación de la url \(error.localizedDescription)"
                    }
                    self!.alertError = true
                }
            }
        }
    }
    
    func updateEmployee(employee: User){
        employeesRepository.updateEmployee(employee: employee) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let employee):
                    print("OK actualizacion")
                case .failure(let error):
                    print(String(describing: error))
                    switch error{
                    case .decodingError(_):
                        self?.messageError = "Error generando la decodificacion de la data \(error.localizedDescription)"
                    case .encodingError:
                        self?.messageError = "Error generando la codificacion de la data \(error.localizedDescription)"
                    case .noData:
                        self?.messageError = "Error con la data \(error.localizedDescription)"
                    case .serverError(let statusCode):
                        self?.messageError = "Error del servidor \(statusCode), \(error.localizedDescription)"
                    case .transportError(_):
                        self?.messageError = "Error del transporte de la peticion \(error.localizedDescription)"
                    case .unknownedError(_):
                        self?.messageError = "Error desconocido \(error.localizedDescription)"
                    case .urlError:
                        self?.messageError = "Error con la creación de la url \(error.localizedDescription)"
                    }
                    self!.alertError = true
                }
            }
        }
    }
}


