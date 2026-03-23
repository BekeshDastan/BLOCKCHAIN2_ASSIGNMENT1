// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OptimizedContract {
    //1. STORAGE PACKING, there are 2 slots, in previous version were used 3 slots
    uint128 public var1 = 10;
    uint128 public var3 = 20;
    uint256 public var2 = 100;
    
    // 2. CONSTANT / IMMUTABLE:
    address public immutable owner;
    uint256 public constant limit = 1000;
    // 7. EVENT-BASED LOGGING:
    event Processed(address indexed user);
    uint256 public totalProcessed;

    constructor() {
        owner = msg.sender;
    }
    // 3. CALLDATA VS MEMORY, CALLDATA is cheaper
    function processNumbers(uint256[] calldata numbers) external {
        // 4. SHORT-CIRCUITING:
        if (msg.sender == owner && expensiveCheck()) {

            // 6. CACHING STORAGE READS:
            uint256 _totalProcessed = totalProcessed;
            uint256 len = numbers.length;
            
            for (uint256 i = 0; i < len;) {
                totalProcessed += numbers[i];
                // 5. UNCHECKED ARITHMETIC:
                unchecked {
                    i++;
                }
            }
            totalProcessed = _totalProcessed;
            emit Processed(msg.sender);
        }
    }

    function expensiveCheck() internal pure returns (bool) {
        uint256 a = 0;
        for(uint i=0; i<50; i++) { a += i; }
        return a > 0;
    }
}