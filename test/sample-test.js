const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("HomeworkToken", function () {
  it("Should return the new greeting once it's changed", async function () {
    const HomeworkToken = await ethers.getContractFactory("HomeworkToken");
    const homework = await HomeworkToken.deploy();
    await homework.deployed();

    expect(await homework.mintPrice()).to.equal(ethers.utils.parseEther('0.001'));
  });
});
