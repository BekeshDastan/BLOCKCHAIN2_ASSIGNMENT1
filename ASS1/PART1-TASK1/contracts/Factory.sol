// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./ChildContract.sol"; 

contract ChildFactory {
    address[] public deployedChildren; 
    mapping(address => bool) public isChild; 

    event ChildCreated(address indexed child, address indexed owner);

    function createChild(string calldata name) external returns (address) {
        ChildContract child = new ChildContract(msg.sender, name);
        _register(address(child));
        return address(child);
    }

    function createChild2(string calldata name, bytes32 salt) external returns (address) {
        ChildContract child = new ChildContract{salt: salt}(msg.sender, name);
        _register(address(child));
        return address(child);
    }

    function _register(address childAddress) internal {
        deployedChildren.push(childAddress);
        isChild[childAddress] = true;
        emit ChildCreated(childAddress, msg.sender);
    }

    function getDeployedContracts() external view returns (address[] memory) {
        return deployedChildren;
    }
}