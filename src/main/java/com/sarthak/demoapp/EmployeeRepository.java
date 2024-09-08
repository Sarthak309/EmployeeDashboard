package com.sarthak.demoapp;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    List<Employee> findByName(String name);
    List<Employee> findByEmail(String email);
    List<Employee> findBySalary(Double salary); // Ensure this matches the type in Employee model
}
