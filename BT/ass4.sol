// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentManagement {
    // Structure to hold student details
    struct Student {
        int256 stud_id;
        string name;
        string department;
    }

    // Dynamic array to store all students
    Student[] public students;

    // Function to add a student
    function add_stud(int256 stud_id, string memory name, string memory department) public {
        Student memory stud = Student(stud_id, name, department);
        students.push(stud);
    }

    // Function to get a student by ID
    function getStudent(int256 stud_id) public view returns (string memory, string memory) {
        for (uint256 i = 0; i < students.length; i++) {
            if (students[i].stud_id == stud_id) {
                return (students[i].name, students[i].department);
            }
        }
        return ("Not Found", "Not Found");
    }
}
