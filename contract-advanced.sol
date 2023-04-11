// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint8 public decimals;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    address public owner;
    uint256 public maxSupply;
    uint256 public transactionFee;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Burn(address indexed from, uint256 value);

    modifier onlyOwner {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply, uint8 _decimals, uint256 _maxSupply, uint256 _transactionFee) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        decimals = _decimals;
        maxSupply = _maxSupply;
        transactionFee = _transactionFee;
        owner = msg.sender;
        balanceOf[owner] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid recipient address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        uint256 fee = _value * transactionFee / 10000;
        uint256 netValue = _value - fee;

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += netValue;
        balanceOf[owner] += fee;

        emit Transfer(msg.sender, _to, netValue);
        emit Transfer(msg.sender, owner, fee);

        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid recipient address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Not authorized");

        uint256 fee = _value * transactionFee / 10000;
        uint256 netValue = _value - fee;

        balanceOf[_from] -= _value;
        balanceOf[_to] += netValue;
        balanceOf[owner] += fee;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, netValue);
        emit Transfer(_from, owner, fee);

        return true;
    }

    function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;

        emit Burn(msg.sender, _value);

        return true;
    }

    function mint(uint256 _value) public onlyOwner returns (bool success) {
        require(totalSupply + _value <= maxSupply, "Maximum
