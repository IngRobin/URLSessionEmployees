//
//  CreateEmployeeView.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 27/09/22.
//

import SwiftUI

struct CreateEmployeeView: View {
    
    @ObservedObject var employeesViewModel : EmployeesViewModel
    
    @State var name = ""
    @State var correo = ""
    @State var genero = ""
    
    var body: some View {
        VStack{
            
            VStack{
                Text("Nombre")
                TextField("Nombre", text: $name)
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            VStack{
                Text("Correo")
                TextField("Correo", text: $correo)
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            VStack{
                Text("Genero")
                TextField("Genero", text: $genero)
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            
            
            Button {
                
                employeesViewModel.createEmployee(employee: NewUser(name: self.name, email: self.correo, gender: self.genero, status: "active"))
            } label: { 
                Text("Crear")
            }
            

        }
    }
}

struct CreateEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEmployeeView(employeesViewModel: EmployeesViewModel())
    }
}
