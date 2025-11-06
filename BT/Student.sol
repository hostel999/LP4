// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentManagement {
    struct Student {
        int256 id;
        string name;
        string department;
    }
    Student[] private students;

    function addStudent(int256 id, string memory name, string memory department) public {
        students.push(Student(id, name, department));
    }

    function getStudent(int256 id) public view returns (string memory, string memory) {
        for (uint256 i = 0; i < students.length; i++) {
            if (students[i].id == id) {
                return (students[i].name, students[i].department);
            }
        }
        return ("Not Found", "Not Found");
    }

    function totalStudents() public view returns (uint256) {
        return students.length;
    }
}
