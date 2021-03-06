pragma solidity ^0.4.24;
// Define a contract 'Supplychain'
contract SupplyChain {

  // Define 'owner'
  address owner;

  // Define a variable called 'upc' for Universal Product Code (UPC)
  uint  upc;

  // Define a variable called 'sku' for Stock Keeping Unit (SKU)
  uint  sku;

  // Define a public mapping 'items' that maps the UPC to an Item.
  mapping (uint => Item) items;
  
  // Define enum 'State' with the following values:
  enum State
  { 
    MathReady,        
    ArtReady,  
    AnimReady,   
    AudioReady,    
    PrelimTestingComplete,
    ForSale,
    Sold,      
    QAComplete,
    ReleasedForReg,
    EnteredRegulatory,
    RegComplete,
    ReleasedForMarketing,
    MarketingComplete,
    ReadyForRelease,
    Purchased,
    Installed
    }

  State constant defaultState = State.MathReady;

  // Define a struct 'Item' with the following fields:
  struct Item {
    uint    sku;  // Stock Keeping Unit (SKU)
    uint    upc; // Universal Product Code (UPC), generated by the Game Studio, goes on the package, can be verified by the Consumer
    address ownerID;  // Metamask-Ethereum address of the current owner as the product moves through 8 stages
    address originSlotTitleID; // Metamask-Ethereum address of the Game Studio
    string  originGameStudioID; // Game Studio Name
    string  originGameStudioInformation;  // Game Studio Information
    string  originGameStudioAddress; // Game Studio Address
    string  originGameStudioEmailContact;  // Game Email Address
    uint    productID;  // Product ID potentially a combination of upc + sku
    string  productNotes; // Product Notes
    uint    productPrice; // Product Price
    uint    finalCasinoPrice;
    State   itemState;  // Product State as represented in the enum above
    address slotManufacturerID;  // Metamask-Ethereum address of the Distributor
    address regulatoryID; // Metamask-Ethereum address of the Retailer
    address casinoID; // Metamask-Ethereum address of the Consumer
  }

  // Define 16 events with the same 816 state values and accept 'upc' as input argument
  event MathReady(uint upc);
  event ArtReady(uint upc);
  event AnimReady(uint upc);
  event AudioReady(uint upc);
  event PrelimTestingComplete(uint upc);
  event ForSale(uint upc);
  event Sold(uint upc);
  event QATested(uint upc);
  event ReleasedForReg(uint upc);
  event EnteredReg(uint upc);
  event RegulatoryComplete(uint upc);
  event ReleasedForMarketing(uint upc);
  event MarketingComplete(uint upc); 
  event ReadyForRelease(uint upc);
  event Purchased(uint upc);
  event Installed(uint upc);

    // Define a modifer that checks to see if item has not previously been created
  modifier doesNotExist(uint _upc) {
    require(items[_upc].ownerID == address(0));
    _;
  }

  // Define a modifer that checks to see if msg.sender == owner of the contract
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  // Define a modifer that verifies the Caller
  modifier verifyCaller(address _address) {
    require(msg.sender == _address); 
    _;
  }

  // Define a modifier that checks if the paid amount is sufficient to cover the price
  modifier paidEnough(uint _price) { 
    require(msg.value >= _price);
    _;
  }

  // Define a modifier that checks the price and refunds the remaining balance  
  modifier checkValue(uint _productPrice, address _transferAddress ) {
    _;
    uint _price = _productPrice;
    uint amountToReturn = msg.value - _price;
    _transferAddress.transfer(amountToReturn);
  }

  // Define a modifier that checks if an item.state of a upc is MathReady
  modifier mathDesigned(uint _upc) {
    require(items[_upc].itemState == State.MathReady);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is ArtReady
  modifier artDesigned(uint _upc) {
    require(items[_upc].itemState == State.ArtReady);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is AnimReady 
  modifier animDesigned(uint _upc) {
    require(items[_upc].itemState == State.AnimReady);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is AudioReady 
  modifier audioDesigned(uint _upc) {
    require(items[_upc].itemState == State.AudioReady);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is PrelimTestingComplete 
  modifier prelimTestingComplete(uint _upc) {
    require(items[_upc].itemState == State.PrelimTestingComplete);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is ForSale
  modifier forSale(uint _upc) {
    require(items[_upc].itemState == State.ForSale);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is Sold
  modifier sold(uint _upc) {
    require(items[_upc].itemState == State.Sold);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is SoQACompleteld
  modifier qaTested(uint _upc) {
    require(items[_upc].itemState == State.QAComplete);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is ReleasedForReg
  modifier releasedForReg(uint _upc) {
    require(items[_upc].itemState == State.ReleasedForReg);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is EnteredRegulatory
  modifier enteredRegulatory(uint _upc) {
    require(items[_upc].itemState == State.EnteredRegulatory);
    _;
  }  

  // Define a modifier that checks if an item.state of a upc is RegComplete
  modifier regComplete(uint _upc) {
    require(items[_upc].itemState == State.RegComplete);
    _;
  }

   // Define a modifier that checks if an item.state of a upc is ReleasedForMarketing
  modifier releasedForMarketing(uint _upc) {
    require(items[_upc].itemState == State.ReleasedForMarketing);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is MarketingComplete
  modifier marketingComplete(uint _upc) {
    require(items[_upc].itemState == State.MarketingComplete);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is ReadyForRelease
  modifier readyForRelease(uint _upc) {
    require(items[_upc].itemState == State.ReadyForRelease);
    _;
  }
  
  // Define a modifier that checks if an item.state of a upc is Purchased
  modifier purchased(uint _upc) {
      require(items[_upc].itemState == State.Purchased);
    _;
  }

  // In the constructor set 'owner' to the address that instantiated the contract
  // and set 'sku' to 1
  // and set 'upc' to 1
  constructor() public payable {
    owner = msg.sender;
    sku = 1;
    upc = 1;
  }

  // Define a function 'kill' if required
  function kill() public {
    if (msg.sender == owner) {
      selfdestruct(owner);
    }
  }

  // Define a function 'designMath' that allows a game studio to mark an item 'MathReady'
  function designMath(uint _upc, address _originSlotTitleID, string _originGameStudioID, string _originGameStudioInformation, string  _originGameStudioAddress, string  _originGameStudioEmailContact, string  _productNotes) public 

    {
    // Add the new item as part of MathReady
    items[_upc].sku = sku;
    items[_upc].upc = _upc;
    items[_upc].ownerID = _originSlotTitleID;
    items[_upc].originSlotTitleID = _originSlotTitleID;
    items[_upc].originGameStudioID = _originGameStudioID;
    items[_upc].originGameStudioInformation = _originGameStudioInformation;
    items[_upc].originGameStudioAddress = _originGameStudioAddress;
    items[_upc].originGameStudioEmailContact =  _originGameStudioEmailContact;
    items[_upc].productNotes = _productNotes;
    items[_upc].itemState = State.MathReady;
    items[_upc].productID = _upc+sku;
    // Increment sku
    sku = sku + 1;
    // Emit the appropriate event
    emit MathReady(_upc);
  }

  // Define a function 'designArt' that allows a game studio to mark an item 'ArtReady'
  function designArt(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
  mathDesigned(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].originSlotTitleID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.ArtReady;
    // Emit the appropriate event
    emit ArtReady(_upc);
  }

  // Define a function 'designAnim' that allows a game studio to mark an item 'AnimReady'
  function designAnim(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
  artDesigned(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].originSlotTitleID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.AnimReady;
    // Emit the appropriate event
    emit AnimReady(_upc);
  }

  // Define a function 'designAudio' that allows a game studio to mark an item 'AudioReady'
  function designAudio(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
  animDesigned(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].originSlotTitleID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.AudioReady;
    // Emit the appropriate event
    emit AudioReady(_upc);
  }

  // Define a function 'conductPrelimTesting' that allows a game studio to mark an item 'PrelimTestingComplete'
  function conductPrelimTesting(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
  audioDesigned(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].originSlotTitleID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.PrelimTestingComplete;
    // Emit the appropriate event
    emit PrelimTestingComplete(_upc);
  }

  // Define a function 'sellItem' that allows a game studio to mark an item 'ForSale'
  function sellItem(uint _upc, uint _price) public 
  // Call modifier to check if upc has passed previous supply chain stage
  prelimTestingComplete(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].originSlotTitleID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.ForSale;
    items[_upc].productPrice = _price;
    // Emit the appropriate event
    emit ForSale(_upc);
  }

  // Define a function 'buyItem' that allows a slot manufacturer to mark an item 'Sold'
  function buyItem(uint _upc) public payable 
    // Call modifier to check if upc has passed previous supply chain stage
    forSale(_upc)
    // Call modifer to check if buyer has paid enough
    paidEnough(items[_upc].productPrice)
    // Call modifer to send any excess ether back to buyer
    checkValue(items[_upc].productPrice, items[_upc].originSlotTitleID)
    {    
    // Update the appropriate fields - ownerID, slotManufacturerID, itemState    
    items[_upc].ownerID = msg.sender;
    items[_upc].slotManufacturerID = msg.sender;
    items[_upc].itemState = State.Sold;  
    // Transfer money to game studio
    items[_upc].originSlotTitleID.transfer(items[_upc].productPrice);    
    // emit the appropriate event
    emit Sold(_upc);
  }

  // Define a function 'conductQA' that allows a game studio to mark an item 'QAComplete'
  function conductQA(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
  sold(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].slotManufacturerID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.QAComplete;
    // Emit the appropriate event
    emit QATested(_upc);
  }

  // Define a function 'releaseForReg' that allows a slot manufacturer to mark an item 'ReleasedForReg'
  function releaseForReg(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
  qaTested(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].slotManufacturerID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.ReleasedForReg;
    // Emit the appropriate event
    emit ReleasedForReg(_upc);
  }

  // Define a function 'enterRegulatory' that allows a regulatory agency to mark an item 'EnteredRegulatory'
  function enterRegulatory(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
  releasedForReg(_upc)
  {
    // Update the appropriate fields
    items[_upc].ownerID = msg.sender;
    items[_upc].regulatoryID = msg.sender;
    items[_upc].itemState = State.EnteredRegulatory;
    // Emit the appropriate event
    emit EnteredReg(_upc);
  }

  // Define a function 'exitRegulatory' that allows a regulatory agency to mark an item 'RegComplete'
  function exitRegulatory(uint _upc) public
  // Call modifier to check if upc has passed previous supply chain stage
  enteredRegulatory(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].regulatoryID)
  {
    // Update the appropriate fields
    items[_upc].ownerID = items[_upc].slotManufacturerID;
    items[_upc].itemState = State.RegComplete;
    // Emit the appropriate event
    emit RegulatoryComplete(_upc);
  }

  // Define a function 'releaseForMarketing' that allows a slot manufacturer to mark an item 'ReleasedForMarketing'
  function releaseForMarketing(uint _upc) public
  // Call modifier to check if upc has passed previous supply chain stage
  regComplete(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].slotManufacturerID)
  {    
    // Update the appropriate fields    
    items[_upc].itemState = State.ReleasedForMarketing;
    // Emit the appropriate event
    emit ReleasedForMarketing(_upc);
  }

  // Define a function 'exitMarketing' that allows a slot manufacturer to mark an item 'MarketingComplete'
  function exitMarketing(uint _upc) public
  // Call modifier to check if upc has passed previous supply chain stage
  releasedForMarketing(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].slotManufacturerID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.MarketingComplete;
    // Emit the appropriate event
    emit MarketingComplete(_upc);
  } 

  // Define a function 'moveForRelease' that allows the consumer to mark an item 'ReadyForRelease'
  // Use the above modifiers to check if the item is received
  function moveForRelease(uint _upc, uint _price) public 
    // Call modifier to check if upc has passed previous supply chain stage
    marketingComplete(_upc)
    {
    // Update the appropriate fields - ownerID, casinoID, itemState
    items[_upc].itemState = State.ReadyForRelease;
    items[_upc].finalCasinoPrice = _price;
    // Emit the appropriate event
    emit ReadyForRelease(_upc);
  }

  // Define a function 'purchaseItem' that allows the consumer to mark an item 'Purchased'
  // Use the above modifiers to check if the item is received
  function purchaseItem(uint _upc) public payable 
    // Call modifier to check if upc has passed previous supply chain stage
    readyForRelease(_upc)
    // Call modifer to check if buyer has paid enough
    paidEnough(items[_upc].finalCasinoPrice)
    // Call modifer to send any excess ether back to buyer
    checkValue(items[_upc].finalCasinoPrice, items[_upc].slotManufacturerID)
    // Access Control List enforced by calling Smart Contract / DApp
    {
    // Update the appropriate fields - ownerID, casinoID, itemState
    items[_upc].ownerID = msg.sender;
    items[_upc].casinoID = msg.sender;
    items[_upc].itemState = State.Purchased;
    // Emit the appropriate event
    emit Purchased(_upc);
  }

  // Define a function 'installGame' that allows a slot manufacturer to mark an item 'Installed'
  function installGame(uint _upc) public
  // Call modifier to check if upc has passed previous supply chain stage
  purchased(_upc)
  // Call modifier to verify caller of this function
  verifyCaller(items[_upc].casinoID)
  {
    // Update the appropriate fields
    items[_upc].itemState = State.Installed;
    // Emit the appropriate event
    emit Installed(_upc);
  }
 
  // Define a function 'fetchItemBufferOne' that fetches the data
  function fetchItemBufferOne(uint _upc) public view returns 
  (
  uint    itemSKU,
  uint    itemUPC,
  address ownerID,
  address originSlotTitleID,
  string  originGameStudioID,
  string  originGameStudioInformation,
  string  originGameStudioAddress,
  string  originGameStudioEmailContact
  ) 
  {
  // Assign values to the 8 parameters
  itemSKU = items[_upc].sku;
  itemUPC = items[_upc].upc;
  ownerID = items[_upc].ownerID;
  originSlotTitleID = items[_upc].originSlotTitleID;
  originGameStudioID = items[_upc].originGameStudioID;
  originGameStudioInformation = items[_upc].originGameStudioInformation;
  originGameStudioAddress = items[_upc].originGameStudioAddress;
  originGameStudioEmailContact = items[_upc].originGameStudioEmailContact;

  return 
  (
  itemSKU,
  itemUPC,
  ownerID,
  originSlotTitleID,
  originGameStudioID,
  originGameStudioInformation,
  originGameStudioAddress,
  originGameStudioEmailContact
  );
  }

  // Define a function 'fetchItemBufferTwo' that fetches the data
  function fetchItemBufferTwo(uint _upc) public view returns 
  (
  uint    itemSKU,
  uint    itemUPC,
  uint    productID,
  string  productNotes,
  uint    productPrice,
  State    itemState,
  address slotManufacturerID,
  address regulatoryID,
  address casinoID
  ) 
  {
    // Assign values to the 9 parameters
    itemSKU = items[_upc].sku;
    itemUPC = items[_upc].upc;
    productID = items[_upc].productID;
    productNotes = items[_upc].productNotes;
    productPrice = items[_upc].productPrice;
    itemState = items[_upc].itemState;
    slotManufacturerID = items[_upc].slotManufacturerID;
    regulatoryID = items[_upc].regulatoryID;
    casinoID = items[_upc].casinoID;
    
  return 
  (
  itemSKU,
  itemUPC,
  productID,
  productNotes,
  productPrice,
  itemState,
  slotManufacturerID,
  regulatoryID,
  casinoID
  );
  }
}