# Slot Supplychain Solution 

This web application attempts to assist in the buying of a slot game and to audit its many incarnations in its long lifecycle towards installment in a casino. They are many obstacles towards transparency in the traditional implementation of a newly conceived slot title to its "go live" date, and this application hopes to shine light on each necessary part of this long journey.

A game studio can mark the necessary steps in building a new title and can mark as "for sale" when these steps are completed. 

A slot manufacturer can buy this slot title and go through the process of regulatory due diligence. After the necessary quality assurance and stress testing has been completed, the slot title can be marked as "ready for regulatory."

Once the regulatory body has accepted the game, they can inform all parties that the regulatory process has been started. Once complete, the regulatory body can mark the game as "regulatory complete." The game then heads back to the slot manufacturer for marketing in preparation for release.

Once the slot manufacturer has completed marketing, the slot manufacturer can sell the game to any number of casinos. The last step in this delivery process is for the casino to mark the conceived slot title as "installed."

Each of the 4 parties involved (game studio, slot manufacturer, regulatory body, casino) can track each step of the process. The game studio can budget better as it will have a clearer picture as to when to expect backend. The slot manufacturer can know when to plan for new games and can track the regulatory process more easily. The regulatory body can better know how to slate its testing schedule as a clear schedule can be forecast from each process. Finally, the casino(s) can know when to begin its marketing as it awaits the installment of a new game because of the transparent nature of each step in the process. It also knows the game it is receiving has been fully vetted and can protect itself against lawsuits related to malfunction if there is a clear timeline and documentation of each step.


## Project Specifics
* The Rinkeby Contract Address is [0x762ae90b028909c2bcb6ecc1d524e506116cb9e5.](https://rinkeby.etherscan.io/address/0x762ae90b028909c2bcb6ecc1d524e506116cb9e5)
* Sample Transaction ID [0xe0730cd7c9dbc9dc8e29b6b4afeefd9f76ae65dc6d35ee20e1e47317201152fc](https://rinkeby.etherscan.io/tx/0xe0730cd7c9dbc9dc8e29b6b4afeefd9f76ae65dc6d35ee20e1e47317201152fc)  
* To run tests via Ganache, enter the command `ganache-cli -m "spirit supply whale amount human item harsh scare congress discover talent hamster"`
* Though there are buttons to add roles, only the contract owner can add those roles

## Library 
* The Role.sol library was used to add, remove and maitain integrity of assigned roles. Currently, the front-end is ignoring the role calls authentication for ease of use for users of smart contract for testing purposes.

## Prerequisites
Access to an operating system capable of internet and browser access.

## Installing
* Unzip project or clone from [Github](https://github.com/joeyBerger/SlotSupplyChainSolution).
* Install npm dependencies `npm install`
* Navigate to folder and in a terminal enter `npm run dev` to start local server.

#### Running the web application
##### Login To Metamask
* In order to interact with this DAPP, login to [Metamask](https://metamask.io/).

## Built With

* [Ethereum](https://www.ethereum.org/) - Ethereum is a decentralized platform that runs smart contracts
* [Truffle Framework](http://truffleframework.com/) - Truffle is the most popular development framework for Ethereum with a mission to make your life a whole lot easier.
* [Visual Studio Code](https://code.visualstudio.com) - Visual Studio Code is a source code editor developed by Microsoft for Windows, Linux and macOS.

## Software Versioning
Node  - v10.15.1
Truffle - v4.1.14 (core: 4.1.14)
Solidity - v0.4.24 (solc-js)npm

#### Project Version 1.0

## Author

Joey Berger
