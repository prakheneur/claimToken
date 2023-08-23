// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyTokenStorage {
    uint256 public totalSupply;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    // address public owner;

    // constructor() {
    //     owner = msg.sender;
    // }

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "Not the owner");
    //     _;
    // }
}
