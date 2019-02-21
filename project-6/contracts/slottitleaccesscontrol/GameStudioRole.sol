pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'GameStudioRole' to manage this role - add, remove, check
contract GameStudioRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event GameStudioAdded(address indexed account);
  event GameStudioRemoved(address indexed account);

  // Define a struct 'gameStudio' by inheriting from 'Roles' library, struct Role
  Roles.Role private gameStudio;

  // In the constructor make the address that deploys this contract the 1st game studio
  constructor() public {
    _addGameStudio(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyGameStudio() {
    require(isGameStudio(msg.sender));
    _;
  }

  // Define a function 'isGameStudio' to check this role
  function isGameStudio(address account) public view returns (bool) {
    return gameStudio.has(account);
  }

  // Define a function 'addGameStudio' that adds this role
  function addGameStudio(address account) public onlyGameStudio {
    _addGameStudio(account);
  }

  // Define a function 'renounceGameStudio' to renounce this role
  function renounceGameStudio() public {
    _removeGameStudio(msg.sender);
  }

  // Define an internal function '_addGameStudio' to add this role, called by 'addGameStudio'
  function _addGameStudio(address account) internal {
    gameStudio.add(account);
    emit GameStudioAdded(account);
  }

  // Define an internal function '_removeGameStudio' to remove this role, called by 'removeGameStudio'
  function _removeGameStudio(address account) internal {
    gameStudio.remove(account);
    emit GameStudioRemoved(account);
  }
}