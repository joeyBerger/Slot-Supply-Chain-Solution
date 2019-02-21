// migrating the appropriate contracts
// var FarmerRole = artifacts.require("./FarmerRole.sol");
// var DistributorRole = artifacts.require("./DistributorRole.sol");
// var RetailerRole = artifacts.require("./RetailerRole.sol");
// var ConsumerRole = artifacts.require("./ConsumerRole.sol");
var GameStudioRole = artifacts.require("./GameStudioRole.sol");  //TODO: clean this up
var SlotManufacturerRole = artifacts.require("./SlotManufacturerRole.sol");
var RegulatoryRole = artifacts.require("./RegulatoryRole.sol");
var CasinoRole = artifacts.require("./CasinoRole.sol");
var SupplyChain = artifacts.require("./SupplyChain.sol");

module.exports = function(deployer) {
  deployer.deploy(GameStudioRole);
  deployer.deploy(SlotManufacturerRole);
  deployer.deploy(RegulatoryRole);
  deployer.deploy(CasinoRole);
  deployer.deploy(SupplyChain);
};
