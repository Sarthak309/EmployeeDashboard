package com.sarthak.demoapp;

import java.util.List;
import java.util.Optional;

public interface EmployeeService {
    List<Employee> findAll();
    Optional<Employee> findById(int id);
    Employee save(Employee employee);
    void deleteById(int id);
    List<Employee> findByName(String name);
    List<Employee> findByEmail(String email);
    List<Employee> findBySalary(Double salary); // Ensure this matches the type in Employee model
}
