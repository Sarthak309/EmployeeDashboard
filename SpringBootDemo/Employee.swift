//
//  Employee.swift
//  SpringBootDemo
//
//  Created by Sarthak Agrawal on 06/09/24.
//

import Foundation

class Employee: NSObject, Codable {
    
    var id: Int?
    var name: String?
    var email: String?
    var salary: Double?
    
    override init() {
        super.init()
    }
    
}
