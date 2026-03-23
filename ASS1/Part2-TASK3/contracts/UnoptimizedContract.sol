// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UnoptimizedContract {
    uint128 public var1 = 10;
    uint256 public var2 = 100;
    uint128 public var3 = 20;

    address public owner;
    uint256 public limit = 1000;

    address[] public history;
    uint256 public totalProcessed;

    constructor() {
        owner = msg.sender;
    }

    function processNumbers(uint256[] memory numbers) external {

        if (expensiveCheck() && msg.sender == owner) {
            
            for (uint256 i = 0; i < numbers.length; i++) {
                totalProcessed += numbers[i];
            }
            
            history.push(msg.sender);
        }
    }

    function expensiveCheck() internal pure returns (bool) {
        uint256 a = 0;
        for(uint i=0; i<50; i++) { a += i; }
        return a > 0;
    }
}