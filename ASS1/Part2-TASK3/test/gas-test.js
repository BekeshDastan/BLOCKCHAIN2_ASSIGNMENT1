const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Gas Optimization Comparison", function () {
  const testArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  it("Runs the Unoptimized Contract", async function () {
    const Unoptimized = await ethers.getContractFactory("UnoptimizedContract");
    const unoptimized = await Unoptimized.deploy();
    
    const tx = await unoptimized.processNumbers(testArray);
    await tx.wait();
  });

  it("Runs the Optimized Contract", async function () {
    const Optimized = await ethers.getContractFactory("OptimizedContract");
    const optimized = await Optimized.deploy();
    
    const tx = await optimized.processNumbers(testArray);
    await tx.wait();
  });
});