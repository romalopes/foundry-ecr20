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
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 


contract RomaToken {
  /** Errors */
  error InsufficientBalance(address owner, uint256 balance, uint256 required);
  error InvalidAddress(address addr);
  error TransferFailed(address from, address to, uint256 value);
  error AllowanceExceeded(address owner, address spender, uint256 allowed, uint256 required);
  error MintingFailed(address to, uint256 amount);
  error TransferValueMustbeGreaterThanZero(uint256 value);
  error BurnValueMustbeGreaterThanZero(uint256 value);
  error BurnAmountExceedsBalance(address owner, uint256 balance, uint256 burnAmount);
  error InvalidTransfer(address from, address to, uint256 value);
  error InvalidAllowance(address owner, address spender, uint256 value);
  error InvalidMint(address to, uint256 amount);
  error InvalidBurn(address owner, uint256 amount);
  error InvalidTransferFrom(address from, address to, uint256 value);
  error InvalidIncreaseAllowance(address spender, uint256 addedValue);
  error InvalidDecreaseAllowance(address spender, uint256 subtractedValue);
  error InvalidName(string name);
  error InvalidSymbol(string symbol);
  error InvalidDecimals(uint8 decimals);        
  error InvalidTotalSupply(uint256 totalSupply);
  /** Interfaces */
  /** Libraries */
  /** Contracts */  
  /** Type declarations */
  
  /** State variables */
    mapping(address => uint256) public s_balances;
    string public constant NAME = "Roma Token";
    string public constant SYMBOL = "ROMA";
    uint8 public constant DECIMALS = 18;
    uint256 public constant TOTAL_SUPPLY = 100 ether; // 1000000 * (
    address public s_owner; // Owner of the contract

    /** Events */
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed owner, uint256 amount);
    event IncreaseAllowance(address indexed spender, uint256 addedValue);
    event DecreaseAllowance(address indexed spender, uint256 subtractedValue);
    

    /** Modifiers */
    /** Functions */
    constructor() {
        s_balances[msg.sender] = TOTAL_SUPPLY; // Assign total supply to the contract
        s_owner = msg.sender; // Set the contract deployer as the owner
        emit Transfer(address(0), msg.sender, TOTAL_SUPPLY); // Emit transfer event for
    }

    function name() public pure returns (string memory) {
        return NAME;
    }
    function totalSupply() public pure returns (uint256) {
        return TOTAL_SUPPLY; // 1000000 * (10 ** 18); // Example total supply
    } 

    function symbol() public pure returns (string memory) {
        return SYMBOL;
    }

    function decimals() public pure returns (uint8) {
        return DECIMALS; // Standard decimal places for ERC20 tokens
    }

    function balanceOf(address _owner) public view returns (uint256) {
        s_balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
      uint256 senderBalance = s_balances[msg.sender];
      require(_to != address(0), "Invalid address");

      uint256 previousBalance = balanceOf(msg.sender) + balanceOf(_to);
      s_balances[msg.sender] -= _value;
      s_balances[_to] += _value;
      require(balanceOf(msg.sender) + balanceOf(_to) == previousBalance, "Transfer failed: balance mismatch");

      emit Transfer(msg.sender, _to, _value);
      return true;
    }


    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Invalid address");
        // Implement approval logic here
        emit Approval(s_owner, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_from != address(0), InvalidAddress(_from));
        require(_to != address(0), InvalidAddress(_to));
        require(_value > 0, TransferValueMustbeGreaterThanZero(_value));
        require(s_balances[_from] >= _value, "Insufficient balance");
        // Implement allowance logic here
        s_balances[_from] -= _value;
        s_balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    /**
     *  Returns the amount of tokens that an owner allowed to a spender.
     * * This function is used to check the allowance of a spender for a specific owner.
     * * @dev This function is part of the ERC20 standard.
     */
    function allowance(address _owner, address _spender) public view returns (uint256) {
        // Implement allowance logic here
        return 0; // Placeholder return value
    }

    function increaseAllowance(address _spender, uint256 _addedValue) public returns (bool success) {
        require(_spender != address(0), "Invalid address");
        // Implement increase allowance logic here
        return true;
    }

    function decreaseAllowance(address _spender, uint256 _subtractedValue) public returns (bool success) {
        require(_spender != address(0), "Invalid address");
        // Implement decrease allowance logic here
        return true;
    }

    function mint(address _to, uint256 _amount) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        s_balances[_to] += _amount;
        emit Transfer(address(0), _to, _amount);
        return true;
    }

    function burn(uint256 _amount) public returns (bool success) {
        uint256 senderBalance = s_balances[msg.sender];
        require(senderBalance >= _amount, "Insufficient balance to burn");
        s_balances[msg.sender] -= _amount;
        emit Transfer(msg.sender, address(0), _amount);
        return true;
    }

    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
    receive() external payable {
        // Handle receiving Ether if needed
    }
    fallback() external {

        // Handle fallback logic if needed
        revert("Fallback function not implemented");
    }

    function getBalance(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    } 

    function getTotalSupply() public pure returns (uint256) {
        return TOTAL_SUPPLY; // 1000000 * (10 ** 18); // Example total supply
    }

    function getName() public pure returns (string memory) {
        return NAME;
    }
    function getSymbol() public pure returns (string memory) {
        return SYMBOL;
    }
    function getDecimals() public pure returns (uint8) {

        return DECIMALS; // Standard decimal places for ERC20 tokens
    }

    function getBalanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }
}


    




