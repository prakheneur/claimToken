
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyTokenStorage.sol";
//import "./MyTokenLogic.sol";

contract MyTokenProxy is MyTokenStorage {
    address public implementation;
    address public owner;

    constructor(address logicAddress) {
        implementation = logicAddress;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function upgradeImplementation(address newImplementation) external onlyOwner {
        require(newImplementation != address(0), "Invalid implementation address");
        implementation = newImplementation;
    }

    fallback() external payable {
        address _impl = implementation;
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    // Function to transfer ERC20 tokens using the proxy
    function transferTokens(address to, uint256 amount) external onlyOwner {
        address _impl = implementation;
        // Encode the function call and arguments for the transfer function
        bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", to, amount);

        assembly {
            let result := delegatecall(gas(), _impl, add(data, 0x20), mload(data), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
}
