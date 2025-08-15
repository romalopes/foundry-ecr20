// SPDX-license-Identifier: MIT
    // and 18 decimal places. The total supply is set to 100 ether. 


// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions
pragma solidity ^0.8.18;

import "forge-std/console.sol"; // Importing console for debugging purposes
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol"; // Importing the ERC20 standard from OpenZeppelin
contract RomaToken is ERC20 {
    /** Errors */
    error InitialSupplyMustBeGreaterThanZero(uint initialSuply);

    /** Type declarations */  
    /** Interfaces */
    /** Libraries */
    /** Functions */
    // Layout of Functions:
  // constructor
  // receive function (if exists)
  // fallback function (if exists)
  // external
  // public
  // internal
  // private
  // view & pure functions

    // Constructor to initialize the token with a name, symbol, and total supply
    constructor(uint256 initialSuply) ERC20("RomaToken", "ROMA") {
      // 100 ether
        require(initialSuply > 0, InitialSupplyMustBeGreaterThanZero(initialSuply));
        // _setupDecimals(18); // Setting the decimals to 18
        // _mint(msg.sender, initialSuply * 10 ** decimals()); // Minting the initial supply to the deployer's address
        // The initial supply is multiplied by 10^dec
      _mint(msg.sender, initialSuply); // Minting 100 ether to the deployer's address
        console.log("RomaToken deployed with total supply of 100 ROMA to:", msg.sender);
    }


}