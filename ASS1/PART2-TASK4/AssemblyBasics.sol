// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AssemblyBasics {
    uint256 public storedValue;

    function getCaller() public view returns (address customCaller) {
        assembly {
            // caller() opcode gets the address of the 
            // account that is calling the function
            customCaller := caller()
        }
    }

    function isPowerOfTwo(uint256 n) public pure returns (bool result) {
        assembly {
            // We check two conditions:
            // a) n is not zero: gt(n, 0)
            // b) n AND (n-1) is zero: iszero(and(n, sub(n, 1)))
            if and(gt(n, 0), iszero(and(n, sub(n, 1)))) {
                result := 1
            }
        }
    }

    function updateStorage(uint256 newValue) public {
        assembly {
            // .slot gives us the index of the variable in storage
            let slot := storedValue.slot
            
            // sstore(slot, value) writes to the blockchain
            sstore(slot, newValue)
        }
    }

    function readStorageManually() public view returns (uint256 value) {
        assembly {
            let slot := storedValue.slot
            // sload(slot) reads from the blockchain
            value := sload(slot)
        }
    }
}