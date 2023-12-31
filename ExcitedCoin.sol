/**
 *Submitted for verification at Etherscan.io on 2023-07-06
*/

// SPDX-License-Identifier: MIT
//Excited Coin is a brand new social experiment based on emotions, aiming to foster the growth of projects through continuous positive news. It is designed to be open, transparent, and autonomous.
//Telegram：https://t.me/Excited_Coin
//twitter：https://twitter.com/Excite_Coin
//web：https://00t.cc
pragma solidity ^0.8.0;

interface IBEP20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract ExcitedCoin is IBEP20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping (address => uint256)) private _allowances;

    constructor() {
        name = "Excited Coin";
        symbol = "EXTD";
        decimals = 18;
        _totalSupply = 42000000000 * 10 ** uint256(decimals);
        _balances[msg.sender] = _totalSupply;

        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(amount <= _balances[msg.sender], "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        require(spender != address(0), "Approval to the zero address");

        _allowances[msg.sender][spender] = amount;
        
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(amount <= _balances[sender], "Insufficient balance");
        require(amount <= _allowances[sender][msg.sender], "Insufficient allowance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;
        
        emit Transfer(sender, recipient, amount);
        return true;
    }
}