//
//  EmployeeService.swift
//  SpringBootDemo
//
//  Created by Sarthak Agrawal on 06/09/24.
//

import Foundation
import UIKit
import Alamofire

class EmployeeService {
    
    var url = "http://localhost:8080/employee"
    
    func getAllEmployees(completion: @escaping (Result<[Employee], Error>) -> ()) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        AF
            .request(request)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
            if let err = response.error {
                completion(.failure(err))
                return
            }
            do {
                let employees = try JSONDecoder().decode([Employee].self, from: response.data!)
                completion(.success(employees))
                } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    func createEmployee(employee: Employee, completion: @escaping (Result<Int, Error>) -> ()) {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(employee)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
            if let err = response.error {
                completion(.failure(err))
                return
            }
            completion(.success(1))
        }.resume()
    }
    
    func updateEmployee(id: Int, employee: Employee, completion: @escaping (Result<Int, Error>) -> ()) {
        let encoder = JSONEncoder()
        let updateURL = "\(url)/\(id)"
        let data = try! encoder.encode(employee)
        var request = URLRequest(url: URL(string: updateURL)!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
            if let err = response.error {
                completion(.failure(err))
                return
            }
            completion(.success(1))
        }.resume()
    }
    
    func deleteEmployee(id: Int, completion: @escaping (Result<Int, Error>) -> ()) {
        let deleteURL = "\(url)/\(id)"
        var request = URLRequest(url: URL(string: deleteURL)!)
        request.httpMethod = HTTPMethod.delete.rawValue
        AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
            if let err = response.error {
                completion(.failure(err))
                return
            }
            completion(.success(1))
        }.resume()
    }
}
