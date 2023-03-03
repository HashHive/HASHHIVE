require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
const dotenv = require("dotenv");


dotenv.config();

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

/** @type require('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.11",
  networks: {
    "dcomm-goldcoast": {
      url: process.env.DCOMM_GOLD_COAST,
      accounts: [process.env.PRIVATE_KEY]
    },
  },
  etherscan: {
    apiKey: process.env.API_KEY,
  }
};