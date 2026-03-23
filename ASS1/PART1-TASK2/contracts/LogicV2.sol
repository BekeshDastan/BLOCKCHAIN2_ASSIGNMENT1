// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./LogicV1.sol";


contract LogicV2 is LogicV1 {

    function decrement() external {
        counter--;
    }

    function reset() external {
        counter = 0;
    }
}
