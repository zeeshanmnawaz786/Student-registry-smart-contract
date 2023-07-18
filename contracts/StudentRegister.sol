// regsiter func ======================== DONE
// edit std detail func ================= DONE
// view student data func =============== DONE
// delete student data func ============= DONE

// only authorized user can register, edit, and delete student

// =======================================================================

// register to keep track of every student's information
// save information in smart contract
// (including name, reg no, and maybe date of birth and class)
// edit info for registered students
// another function to view every student
// delete a student's record.
// only the school administrator can add and edit students
// students can see if they are registered
// ===============ALL DONE=================

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistrationDetail {
  address public owner;

  struct Student {
    address studentId;
    string name;
    string course;
    bool isExist;
  }

  mapping(address => Student) public students;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(
      msg.sender == owner,
      "Only the contract owner can perform this action."
    );
    _;
  }

  function registerStudent(
    address studentId,
    string memory name,
    string memory course
  ) public onlyOwner {
    students[studentId] = Student(studentId, name, course, true);
  }

  function viewStudentInfo(
    address studentId
  ) public view returns (address, string memory, string memory, bool) {
    Student memory student = students[studentId];
    require(student.isExist, "Student does not exist.");
    return (student.studentId, student.name, student.course, student.isExist);
  }

  function editStudentInfo(
    address studentId,
    string memory newName,
    string memory newCourse
  ) public onlyOwner {
    require(students[studentId].isExist, "Student does not exist.");
    students[studentId].name = newName;
    students[studentId].course = newCourse;
  }

  function deleteStudentRecord(address studentId) public onlyOwner {
    require(students[studentId].isExist, "Student does not exist.");
    delete students[studentId];
  }
}
