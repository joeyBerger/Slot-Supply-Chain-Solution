pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'SlotManufacturerRole' to manage this role - add, remove, check
contract SlotManufacturerRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event SlotManufacturerAdded(address indexed account);
  event SlotManufacturerRemoved(address indexed account);

  // Define a struct 'slotManufacturers' by inheriting from 'Roles' library, struct Role
  Roles.Role private slotManufacturers;

  // In the constructor make the address that deploys this contract the 1st slot manufacturer
  constructor() public {
    _addSlotManufacturer(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlySlotManufacturer() {
    require(isSlotManufacturer(msg.sender));
    _;
  }

  // Define a function 'isSlotManufacturer' to check this role
  function isSlotManufacturer(address account) public view returns (bool) {
    return slotManufacturers.has(account);
  }

  // Define a function 'addSlotManufacturer' that adds this role
  function addSlotManufacturer(address account) public onlySlotManufacturer {
    _addSlotManufacturer(account);
  }

  // Define a function 'renounceSlotManufacturer' to renounce this role
  function renounceSlotManufacturer() public {
    _removeSlotManufacturer(msg.sender);
  }

  // Define an internal function '_addSlotManufacturer' to add this role, called by 'addSlotManufacturer'
  function _addSlotManufacturer(address account) internal {
    slotManufacturers.add(account);
    emit SlotManufacturerAdded(account);
  }

  // Define an internal function '_removeSlotManufacturer' to remove this role, called by 'removeSlotManufacturer'
  function _removeSlotManufacturer(address account) internal {
    slotManufacturers.remove(account);
    emit SlotManufacturerRemoved(account);
  }
}