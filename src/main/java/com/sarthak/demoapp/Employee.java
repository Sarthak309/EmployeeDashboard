package com.sarthak.demoapp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="Employee")
public class Employee {

    @Id
    @Column(name="id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(name="name", nullable = false)
    String name;

    @Column(name="email", nullable = false)
    String email;

    @Column(name="salary", nullable = false)
    Double salary;

    public void setId(Integer id){
        this.id=id;
    }

    public Integer getId(){
        return this.id;
    }

    public void setName(String name){
        this.name=name;
    }

    public String getName(){
        return this.name;
    }

    public void setEmail(String email){
        this.email=email;
    }

    public String getEmail(){
        return this.email;
    }

    public void setSalary(Double salary){
        this.salary=salary;
    }

    public Double getSalary(){
        return this.salary;
    }

    @Override
    public String toString(){
        StringBuffer buf=new StringBuffer();
        buf.append(this.name).append(" ");
        return buf.toString();
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        return this.getId() == ((Employee) obj).getId();
    }

}
