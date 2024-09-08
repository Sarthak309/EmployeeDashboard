//
//  EmployeeListVC.swift
//  SpringBootDemo
//
//  Created by Sarthak Agrawal on 06/09/24.
//

import Foundation
import UIKit

class EmployeeListVC: UIViewController {
    
    var employeeTable = UITableView()
    var employeeService = EmployeeService()
    var employees: [Employee] = []
    
    var searchBar = UISearchBar()
    var isSearching: Bool = false
    var searchResults: [Employee] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Employee"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(create))
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reloadNotification"), object: nil)
        self.setupSearchBar()
        self.setupEmployeeTable()
        self.getAllEmployees()
    }
    
    @objc func refresh(sender: UIRefreshControl){
        self.getAllEmployees()
        sender.endRefreshing()
    }
    
    @objc func reload(notification: NSNotification){
        self.getAllEmployees()
    }
    
    @objc func create() {
        let addEmployeeVC = AddEmployeeVC()
        addEmployeeVC.title = "Add Employee"
        self.navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
    
    func getAllEmployees() {
        employeeService.getAllEmployees() { (res) in
            switch res {
            case .success(let employees):
                self.employees = employees
                self.employeeTable.reloadData()
            case .failure(let error):
                self.showAlert(withTitle: "Network Error",
                    withMessage: "Failed to get Employee with error: \(error)",
                    parentController: self,
                    okBlock: {},
                    cancelBlock: nil)
            }
        }
    }
    
    func deleteEmployee(id: Int) {
        employeeService.deleteEmployee(id: id) { (res) in
            switch res {
            case .success(_):
                self.getAllEmployees()
            case .failure(_):
                self.showAlert(withTitle: "Network Error",
                    withMessage: "Failed to delete Employee:",
                    parentController: self,
                    okBlock: {},
                    cancelBlock: nil)
            }
        }
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor)
        searchBar.placeholder = " Search..."
        searchBar.delegate = self
    }
    
    func setupEmployeeTable() {
        view.addSubview(employeeTable)
        setEmployeeTableDelegates()
        employeeTable.frame = self.view.frame
        employeeTable.rowHeight = UITableView.automaticDimension
        employeeTable.register(EmployeeCell.self, forCellReuseIdentifier: "EmployeeCell")
        employeeTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        employeeTable.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
    
    func setEmployeeTableDelegates() {
        employeeTable.delegate = self
        employeeTable.dataSource = self
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension EmployeeListVC: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching){
            return searchResults.count
        }
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTable.dequeueReusableCell(withIdentifier: "EmployeeCell") as! EmployeeCell
        let employee = employees[indexPath.row]
        if(isSearching){
            cell.setEmployee(employee: searchResults[indexPath.row])
        } else {
            cell.setEmployee(employee: employee)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
            let employeeId = self.employees[indexPath.row].id
            self.deleteEmployee(id: employeeId ?? 0)
        })
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addEmployeeVC = AddEmployeeVC()
        addEmployeeVC.employee = self.employees[indexPath.row]
        addEmployeeVC.title = "Edit Employee"
        self.navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if(textSearched == "") {
            dismissKeyboard()
            isSearching = false
            employeeTable.reloadData()
        } else {
            isSearching = true
            searchResults = employees.filter {
                $0.name!.range(of: textSearched, options: .caseInsensitive) != nil
            }
            employeeTable.reloadData()
        }
    }
}
