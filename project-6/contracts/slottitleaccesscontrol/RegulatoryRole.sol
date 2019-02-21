pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'RegulatoryRole' to manage this role - add, remove, check
contract RegulatoryRole {
  using Roles for Roles.Role;
  // Define 2 events, one for Adding, and other for Removing
  event RegulatoryAdded(address indexed account);
  event RegulatoryRemoved(address indexed account);
  // Define a struct 'regulatoryBodies' by inheriting from 'Roles' library, struct Role
  Roles.Role private regulatoryBodies;

  // In the constructor make the address that deploys this contract the 1st regulatory bodies
  constructor() public {
    _addRegulatory(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyRegulatory() {
    require(isRegulatory(msg.sender));
    _;
  }

  // Define a function 'isRegulatory' to check this role
  function isRegulatory(address account) public view returns (bool) {
    return regulatoryBodies.has(account);
  }

  // Define a function 'addRegulatory' that adds this role
  function addRegulatory(address account) public onlyRegulatory {
    _addRegulatory(account);
  }

  // Define a function 'renounceRegulatory' to renounce this role
  function renounceRegulatory() public {
    _removeRegulatory(msg.sender);
  }

  // Define an internal function '_addRegulatory' to add this role, called by 'addRegulatory'
  function _addRegulatory(address account) internal {
    regulatoryBodies.add(account);
    emit RegulatoryAdded(account);    
  }

  // Define an internal function '_removeRegulatory' to remove this role, called by 'removeRegulatory'
  function _removeRegulatory(address account) internal {
    regulatoryBodies.remove(account);
    emit RegulatoryRemoved(account);
  }
}