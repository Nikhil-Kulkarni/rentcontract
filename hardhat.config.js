/**
 * @type import('hardhat/config').HardhatUserConfig
 */
require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
module.exports = {
  solidity: "0.8.0",
  defaultNetwork: "mumbai",
  networks: {
    mumbai: {
      url: process.env.INFURA_URL,
      accounts: [`${process.env.PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: `${process.env.POLYGONSCAN_KEY}`,
  },
};
