// Allows us to use ES6 in our migrations and tests.
require('babel-register')

var HDWalletProvider = require('truffle-hdwallet-provider');

var mnemonic = 'spirit supply whale amount human item harsh scare congress discover talent hamster';

module.exports = {
  networks: { 
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*"
    }, 
    rinkeby: {
      provider: function() { 
        return new HDWalletProvider(mnemonic, 'https://rinkeby.infura.io/v3/bfda5968427443ab86ee3ca5fd20270b') 
      },
      network_id: 4,
      gas: 4500000,
      gasPrice: 10000000000,
    }
  }
};
// module.exports = {
//   networks: {
//       development: {
//           host: "localhost",
//           port: 8545,
//           network_id: "*" // Match any network id
//       }
//   }
// };
