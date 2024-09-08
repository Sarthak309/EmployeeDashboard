//
//  AddEmployeeView.swift
//  SpringBootDemo
//
//  Created by Sarthak Agrawal on 06/09/24.
//

import UIKit

class AddEmployeeView: UIView, UITextFieldDelegate {
    
    var nameLabel = UILabel()
    var name = UITextField()
    var emailLabel = UILabel()
    var email = UITextField()
    var salaryLabel = UILabel()
    var salary = UITextField()
    
    var scrollView = UIScrollView()
    
    var textFields: [UITextField] {
        return [name,email,salary]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
        setupScrollView()
        setupFields()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupFields() {
        textFields.forEach { $0.delegate = self }
        nameLabel.text = "Name: *"
        name.placeholder = "Name"
        emailLabel.text = "Email: *"
        email.keyboardType = .emailAddress
        email.placeholder = "Email"
        salaryLabel.text = "Salary: *"
        salary.keyboardType = .decimalPad
        salary.placeholder = "Salary"
        
        setFieldConstraints()
    }
    
    func setFieldConstraints() {
        nameLabel.anchor(top: scrollView.topAnchor, bottom: nil, left: scrollView.leftAnchor, right: nil)
        name.anchor(top: scrollView.topAnchor, bottom: nil, left: nameLabel.rightAnchor, right: nil)
        emailLabel.anchor(top: nameLabel.bottomAnchor, bottom: nil, left: scrollView.leftAnchor, right: nil)
        email.anchor(top: name.bottomAnchor, bottom: nil, left: emailLabel.rightAnchor, right: nil)
        salaryLabel.anchor(top: emailLabel.bottomAnchor, bottom: scrollView.bottomAnchor, left: scrollView.leftAnchor, right: nil)
        salary.anchor(top: email.bottomAnchor, bottom: scrollView.bottomAnchor, left: salaryLabel.rightAnchor, right: nil)
    }
    
    func setupScrollView() {
        self.addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(name)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(email)
        scrollView.addSubview(salaryLabel)
        scrollView.addSubview(salary)
        scrollView.contentSize.height = 2000
        scrollView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
            textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: 15).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: 15).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -15).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -15).isActive = true
        }
    }
}
