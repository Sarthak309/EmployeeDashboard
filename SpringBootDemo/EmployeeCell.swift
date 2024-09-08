//
//  EmployeeCell.swift
//  SpringBootDemo
//
//  Created by Sarthak Agrawal on 06/09/24.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    var idLabel = UILabel()
    var id = UILabel()
    var nameLabel = UILabel()
    var name = UILabel()
    var emailLabel = UILabel()
    var email = UILabel()
    var salaryLabel = UILabel()
    var salary = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addSubViews() {
        idLabel.text = "Id:"
        self.addSubview(idLabel)
        self.addSubview(id)
        nameLabel.text = "Name:"
        self.addSubview(nameLabel)
        self.addSubview(name)
        emailLabel.text = "Email:"
        self.addSubview(emailLabel)
        self.addSubview(email)
        salaryLabel.text = "Salary:"
        self.addSubview(salaryLabel)
        self.addSubview(salary)
        
        setupFields()
    }
    
    func setupFields() {
        id.anchor(top: self.topAnchor, bottom: nil, left: idLabel.rightAnchor, right: nil)
        idLabel.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: nil)
        name.anchor(top: id.bottomAnchor, bottom: nil, left: nameLabel.rightAnchor, right: nil)
        nameLabel.anchor(top: idLabel.bottomAnchor, bottom: nil, left: self.leftAnchor, right: nil)
        email.anchor(top: name.bottomAnchor, bottom: nil, left: emailLabel.rightAnchor, right: nil)
        emailLabel.anchor(top: nameLabel.bottomAnchor, bottom: nil, left: self.leftAnchor, right: nil)
        salary.anchor(top: email.bottomAnchor, bottom: self.bottomAnchor, left: salaryLabel.rightAnchor, right: nil)
        salaryLabel.anchor(top: emailLabel.bottomAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, right: nil)
    }
    
    func setEmployee(employee: Employee) {
        id.text = String(employee.id ?? 0)
        name.text = (employee.name?.elementsEqual(""))! ? "-" : employee.name
        email.text = (employee.email?.elementsEqual(""))! ? "-" : employee.email
        salary.text = String(employee.salary ?? 0.0)
    }
    
    
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat = 0, paddingBottom: CGFloat = 0, paddingLeft: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
