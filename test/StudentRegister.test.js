const { ethers } = require("hardhat");

describe("StudentRegistrationDetail", function () {
  let student_c, owner, a1, a2, a3, a4, a5, a6;

  before(async function () {
    [owner, a1, a2, a3, a4, a5, a6] = await ethers.getSigners();

    const Student_C = await ethers.getContractFactory(
      "StudentRegistrationDetail"
    );
    student_c = await Student_C.deploy();
    await student_c.waitForDeployment();

    const student_cAddr = await student_c.getAddress();
    console.log(
      "🚀 ~ file: StudentRegister.test.js:15 ~ student_cAddr:",
      student_cAddr
    );
  });

  it("Regsiter_Student", async function () {
    await student_c
      .connect(owner)
      .registerStudent(a1.getAddress(), "Zeeshan Nawaz", "BS-IT");
  });
  it("View_Student", async function () {
    await student_c.connect(a1).viewStudentInfo(a1.getAddress());
  });
  it("Edit_Student", async function () {
    await student_c
      .connect(owner)
      .editStudentInfo(a1.getAddress(), "Arsalan Nawaz", "BS-CS");
  });
  it("Delete_Student", async function () {
    await student_c.connect(owner).deleteStudentRecord(a1.getAddress());
  });
});
