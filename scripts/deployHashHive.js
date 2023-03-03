
const hre = require("hardhat");

async function main() {


  const HashHive = await hre.ethers.getContractFactory("HashHive");
  const hashhive = await HashHive.deploy(
    "HashHive",
    "HAH",
    "1000000"
  );

  await hashhive.deployed();

  console.log("HashHive deployed to:", hashhive.address);
}

async function runMain() {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
}

runMain();