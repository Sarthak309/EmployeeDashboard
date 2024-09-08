//
//  AddEmployeeVC.swift
//  SpringBootDemo
//
//  Created by Sarthak Agrawal on 06/09/24.
//

import Foundation
import UIKit

class AddEmployeeVC: UIViewController {
    
    var addEmployeeView = AddEmployeeView()
    var employeeService = EmployeeService()
    var employee = Employee()
    
    override func loadView() {
        view = addEmployeeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        isEditMode()
    }
    
    func isEditMode() {
        if(employee.id != nil) {
            addEmployeeView.name.text = employee.name
            addEmployeeView.email.text = employee.email
            addEmployeeView.salary.text = String(employee.salary ?? 0.0)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(updateEmployee))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(createEmployee))
        }
    }
    
    @objc func createEmployee() {
        if(validate()) {
            employeeService.createEmployee(employee: employee){ (res) in
                switch res {
                case .success(_):
                    NotificationCenter.default.post(name: Notification.Name("reloadNotification"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                case .failure(_):
                    self.showAlert(withTitle: "Network Error",
                        withMessage: "Failed to create Employee",
                        parentController: self,
                        okBlock: {},
                        cancelBlock: nil)
                }
            }
        }
    }
    
    @objc func updateEmployee() {
        if(validate()) {
            employeeService.updateEmployee(id: employee.id!, employee: employee){ (res) in
                switch res {
                case .success(_):
                    NotificationCenter.default.post(name: Notification.Name("reloadNotification"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                case .failure(_):
                    self.showAlert(withTitle: "Network Error",
                        withMessage: "Failed to update Employee",
                        parentController: self,
                        okBlock: {},
                        cancelBlock: nil)
                }
            }
        }
    }
    
    func validate() -> Bool {
        if(addEmployeeView.name.text!.isEmpty) {
            showAlert(withTitle: "Failed to add Employee",
                withMessage: "Name is required.",
                parentController: self,
                okBlock: {},
                cancelBlock: nil)
            return false
        }
        employee.name = addEmployeeView.name.text
        if(addEmployeeView.email.text!.isEmpty) {
            showAlert(withTitle: "Failed to add Employee",
                withMessage: "Email is required.",
                parentController: self,
                okBlock: {},
                cancelBlock: nil)
            return false
        }
        employee.email = addEmployeeView.email.text
        if(addEmployeeView.salary.text!.isEmpty) {
            showAlert(withTitle: "Failed to add Employee",
                withMessage: "Salary is required.",
                parentController: self,
                okBlock: {},
                cancelBlock: nil)
            return false
        }
        employee.salary = Double(addEmployeeView.salary.text ?? "0.0")
        return true
    }
    
}
extension UIViewController {
    func showAlert(withTitle title : String, withMessage message: String?, parentController parent : UIViewController, okBlock : @escaping () -> (), cancelBlock : (() -> ())?) {
        let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (alert : UIAlertAction) in
            okBlock()
        }
        if (cancelBlock != nil) {
            let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (alert : UIAlertAction) in
                cancelBlock!()
            }
            alert.addAction(cancelAction)
        }
        alert.addAction(okAction)
        parent.present(alert, animated: true) {
        }
    }
}
