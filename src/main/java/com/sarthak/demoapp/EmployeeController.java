package com.sarthak.demoapp;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/employee")
public class EmployeeController {

    @GetMapping("/api/test/{name}")
    public String getString(@PathVariable String name){
        return "HI I am " + name;
    }

    @Autowired
    EmployeeService employeeService;

    @GetMapping
    public ResponseEntity<List<Employee>> getAll() {
        return ResponseEntity.ok(employeeService.findAll());
    }

    @PostMapping
    public ResponseEntity<Employee> insert(@RequestBody Employee employee) {
        Employee save = this.employeeService.save(employee);
        return ResponseEntity.ok(save);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Employee> find(@PathVariable("id") int id) {
        Optional<Employee> object = this.employeeService.findById(id);
        if (object.isPresent()) {
            return ResponseEntity.ok(object.get());
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable int id) {
        Optional<Employee> object = this.employeeService.findById(id);
        if (object.isPresent()) {
            this.employeeService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Void> update(@PathVariable int id, @RequestBody Employee employee) {
        Optional<Employee> object = this.employeeService.findById(id);
        if (object.isPresent()) {
            employee.setId(id);
            this.employeeService.save(employee);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }
}

