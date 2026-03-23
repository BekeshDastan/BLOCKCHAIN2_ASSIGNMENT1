// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract LogicV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 public counter;

    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
    __Ownable_init(msg.sender);
    counter = 0;
}

    function increment() external {
        counter++;
    }

    function getter() external view returns(uint256) {
        return counter;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}