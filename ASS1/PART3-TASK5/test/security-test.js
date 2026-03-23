const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Security Audits", function () {
  let vault, attackerContract, deployer, user, attacker;

  beforeEach(async function () {
    [deployer, user, attacker] = await ethers.getSigners();
  });

  describe("Reentrancy Attack ", function () {
    it("Should drain the vulnerable vault", async function () {
      const Vault = await ethers.getContractFactory("VulnerableVault");
      vault = await Vault.deploy();

      await vault.connect(user).deposit({ value: ethers.parseEther("10") });

      const AttackerFactory = await ethers.getContractFactory("Attacker");
      attackerContract = await AttackerFactory.connect(attacker).deploy(await vault.getAddress());

      await attackerContract.connect(attacker).attack({ value: ethers.parseEther("1") });

      expect(await ethers.provider.getBalance(await vault.getAddress())).to.equal(0);
    });

    it("Should FAIL to drain the fixed vault ", async function () {
      const FixedVault = await ethers.getContractFactory("FixedVault");
      let fixedVault = await FixedVault.deploy();
      
      await fixedVault.connect(user).deposit({ value: ethers.parseEther("10") });
      const AttackerFactory = await ethers.getContractFactory("Attacker");
      attackerContract = await AttackerFactory.connect(attacker).deploy(await fixedVault.getAddress());

      await expect(attackerContract.connect(attacker).attack({ value: ethers.parseEther("1") }))
        .to.be.reverted;
    });
  });

  describe("Access Control ", function () {
    it("Any user can drain VulnerableAccess ", async function () {
      const VulnAccess = await ethers.getContractFactory("VulnerableAccess");
      const access = await VulnAccess.deploy();
      
      await deployer.sendTransaction({ to: await access.getAddress(), value: ethers.parseEther("10") });

      await access.connect(attacker).withdrawAll();
      expect(await ethers.provider.getBalance(await access.getAddress())).to.equal(0);
    });

    it("Only owner can drain FixedAccess", async function () {
      const FixedAccess = await ethers.getContractFactory("FixedAccess");
      const access = await FixedAccess.deploy();
      
      await deployer.sendTransaction({ to: await access.getAddress(), value: ethers.parseEther("10") });

      await expect(access.connect(attacker).withdrawAll()).to.be.revertedWithCustomError(access, "OwnableUnauthorizedAccount");
    });
  });
});