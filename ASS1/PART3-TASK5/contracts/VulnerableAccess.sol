// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableAccess {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function withdrawAll() public {
        payable(msg.sender).transfer(address(this).balance);
    }
    
    receive() external payable {}
}