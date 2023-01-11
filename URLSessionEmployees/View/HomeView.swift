//
//  ContentView.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 20/09/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresented = false
    @StateObject var employeesViewModel = EmployeesViewModel()
//    1. Manejo de viewModel con EnvironmentObject (Diferente a StateObject)
//    @EnvironmentObject var employeesViewModel : EmployeesViewModel
    var body: some View {
        
        NavigationView{
            VStack{
                List($employeesViewModel.employees, id: \.id) { $employee in
                    
                    NavigationLink {
//                        1. Manejo de viewModel con EnvironmentObject (Diferente a StateObject)
//                        UpdateEmployee(employee: employee)
                        UpdateEmployee(employeesViewModel: employeesViewModel, employee: $employee)
                    } label: {
                        Text("\(employee.name ?? "No name")")
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            employeesViewModel.deleteEmployee(employee: employee)
                        } label: {
                            Label("Borrar", systemImage: "trash.fill")
                        }
                        .tint(.red)

                    }
                    
                
                }
            }
            .navigationTitle("Empleados")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: CreateEmployeeView(employeesViewModel: employeesViewModel)) {
                            Image(systemName: "plus")

                        }
                    }

                }

            }
            
        }
                    
        .onAppear{
            employeesViewModel.getEmployees()
        }
        .alert(isPresented: $employeesViewModel.alertError) {
            Alert(
                title: Text("Error"),
                message: Text(employeesViewModel.messageError?.description ?? "Error"),
                primaryButton: .default(
                    Text("Try Again"),
                    action: employeesViewModel.getEmployees
                ),
                secondaryButton: .destructive(
                    Text("Cancel")
                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


