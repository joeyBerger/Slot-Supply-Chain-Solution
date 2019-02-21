pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'CasinoRole' to manage this role - add, remove, check
contract CasinoRole {
  using Roles for Roles.Role;
  
  // Define 2 events, one for Adding, and other for Removing
  event CasinoAdded(address indexed account);
  event CasinoRemoved(address indexed account);

  // Define a struct 'casinos' by inheriting from 'Roles' library, struct Role
   Roles.Role private casinos;

  // In the constructor make the address that deploys this contract the 1st casinos
  constructor() public {
    _addCasino(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyCasino() {
    require(isCasino(msg.sender));
    _;
  }

  // Define a function 'isCasino' to check this role
  function isCasino(address account) public view returns (bool) {
    return casinos.has(account);
  }

  // Define a function 'addCasino' that adds this role
  function addCasino(address account) public onlyCasino {
    _addCasino(account);
  }

  // Define a function 'renounceCasino' to renounce this role
  function renounceCasino() public {
    _removeCasino(msg.sender);
  }

  // Define an internal function '_addCasino' to add this role, called by 'addCasino'
  function _addCasino(address account) internal {
    casinos.add(account);
    emit CasinoAdded(account);
  }

  // Define an internal function '_removeCasino' to remove this role, called by 'removeCasino'
  function _removeCasino(address account) internal {
    casinos.remove(account);
    emit CasinoRemoved(account);
  }
}