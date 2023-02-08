//
//  URLSessionEmployeesTests.swift
//  URLSessionEmployeesTests
//
//  Created by Robinson Gonzalez on 2/02/23.
//

import XCTest
@testable import URLSessionEmployees

class URLSessionEmployeesTests: XCTestCase {

    var mockEmployeeViewModel: EmployeesViewModel!
    
    override func setUp() {
        mockEmployeeViewModel = EmployeesViewModel(employeeDatasource: MockEmployees())
    }

    func testGetEmployees() {
        mockEmployeeViewModel.getEmployees()
        XCTAssertEqual(mockEmployeeViewModel.employees, Bundle.getEmployeesJson().users)
    }
    
    override func tearDownWithError() throws {
        mockEmployeeViewModel = nil
    }

    

}
