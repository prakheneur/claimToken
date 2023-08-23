// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyTokenStorage.sol";

contract MyTokenLogic is MyTokenStorage {
    string public name;
    string public symbol;
    uint8 public decimals;
    address public owner;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 initialSupply
         //
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = initialSupply * 10**uint256(_decimals);
        balances[msg.sender] = totalSupply;
        owner = msg.sender; //
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(to != address(0), "Invalid address");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        //balances[msg.sender] -= amount;
       // balances[to] += amount;
       balances[owner] -= amount;
       balances[msg.sender] += amount;

        //emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external  returns (bool) {
        allowances[msg.sender][spender] = amount;
       // emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external  returns (bool) {
        require(from != address(0) && to != address(0), "Invalid addresses");
        require(balances[from] >= amount, "Insufficient balance");
        require(allowances[from][msg.sender] >= amount, "Allowance exceeded");

        balances[from] -= amount;
        balances[to] += amount;
        allowances[from][msg.sender] -= amount;

       // emit Transfer(from, to, amount);
        return true;
    }

    // function mint(address account, uint256 amount) external onlyOwner {
    //     require(account != address(0), "Invalid address");
    //     totalSupply += amount;
    //     balances[account] += amount;
    //   //  emit Transfer(address(0), account, amount);
    // }

    // function burn(address account, uint256 amount) external onlyOwner {
    //     require(account != address(0), "Invalid address");
    //     require(balances[account] >= amount, "Insufficient balance");
    //     totalSupply -= amount;
    //     balances[account] -= amount;
    //    // emit Transfer(account, address(0), amount);
    // }

}
