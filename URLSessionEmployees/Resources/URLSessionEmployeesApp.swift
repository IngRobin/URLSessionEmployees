//
//  URLSessionEmployeesApp.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 20/09/22.
//

import SwiftUI

@main
struct URLSessionEmployeesApp: App {
    var body: some Scene {
        WindowGroup {
//            1. Manejo de viewModel con EnvironmentObject (Diferente a StateObject)
//            HomeView().environmentObject(EmployeesViewModel())
            HomeView()
        }
    }
}
