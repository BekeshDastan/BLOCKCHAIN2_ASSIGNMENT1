const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Gas Comparison: CREATE vs CREATE2", function () {
  it("Should compare deployment costs", async function () {
    const Factory = await ethers.getContractFactory("ChildFactory");
    const factory = await Factory.deploy();

    const name = "TestChild";
    const salt = ethers.id("my_unique_salt");

    const tx1 = await factory.createChild2(name, salt);
    const receipt1 = await tx1.wait();
    console.log("Gas used (CREATE2):", receipt1.gasUsed.toString());

    const tx2 = await factory.createChild(name);
    const receipt2 = await tx2.wait();
    console.log("Gas used (CREATE):", receipt2.gasUsed.toString());
  });
});