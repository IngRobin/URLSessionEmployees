//
//  UpdateEmployee.swift
//  URLSessionEmployees
//
//  Created by Robinson Gonzalez on 10/10/22.
//

import SwiftUI

struct UpdateEmployee: View {
    // Cerrar la view para iOS 14
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Cerrar la view para iOS 15
    @Environment(\.dismiss) var dismiss
    
    //    1. Manejo de viewModel con EnvironmentObject (Diferente a StateObject)
    //    @EnvironmentObject var employeesViewModel : EmployeesViewModel
    @ObservedObject var employeesViewModel : EmployeesViewModel
    @Binding var employee: User
    @State var name = ""
    @State var email = ""
    @State var genre = ""

    
    var body: some View {
        VStack{
            VStack{
                Text("Nombre")
                    .foregroundColor(Color.black)
                
                TextField("Nombre", text: $name)
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            VStack{
                Text("Correo")
                    .foregroundColor(Color.black)
                TextField("Correo", text: $email)
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            VStack{
                Text("Genero")
                    .foregroundColor(Color.black)
                
                TextField("Genero", text: $genre)
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            
            Button {
//                employee.name = name
                employee.email = email
                employee.sex = genre
                employeesViewModel.updateEmployee(employee: employee)
                // Cerrar la view para iOS 14
                //self.presentationMode.wrappedValue.dismiss()
                // Cerrar la view para iOS 15
                dismiss()
            } label: {
                Text("Actualizar")
            }
            Spacer()
        }
        .onAppear{
            self.name = employee.name ?? ""
            self.email = employee.email ?? ""
            self.genre = employee.sex ?? ""

            
            
        }
        .alert(isPresented: $employeesViewModel.alertError) {
            Alert(
                title: Text("Error"),
                message: Text(employeesViewModel.messageError?.description ?? "Error"),
                primaryButton: .default(
                    Text("Try Again"))
                {
                    employeesViewModel.updateEmployee(employee: employee)
                },
                secondaryButton: .destructive(
                    Text("Cancel")
                )
            )
        }
        
    }
}


//struct UpdateEmployee_Previews: PreviewProvider {
//    static var previews: some View {
//        //        1. Manejo de viewModel con EnvironmentObject (Diferente a StateObject)
//        //        UpdateEmployee(employee: Employee(id: 1, name: "Robinson", salary: 1, age: 1))
////        UpdateEmployee(employeesViewModel: EmployeesViewModel(), employee: Employee(id: 1, name: "Robinson", email: "rgonza@gmail.com",sex: "M"))
//        UpdateEmployee(employeesViewModel: EmployeesViewModel(), employee: Employee(id: 1, name: "Robinson", email: "rgonza@gmail.com",gender: "M"))
//    
//    }
//}

