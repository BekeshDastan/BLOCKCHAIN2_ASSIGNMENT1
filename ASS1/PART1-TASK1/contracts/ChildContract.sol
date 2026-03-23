// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ChildContract {
    address public owner;
    string public name;
    uint256 public  balance;

    event Deposit(address indexed sender, uint256 amount);

    constructor(address _owner, string memory _name) payable {
        owner = _owner;
        name = _name;
        balance = msg.value;

    }

    receive() external payable {
        balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function Withdraw() external {
        require(msg.sender == owner, "Not owner");
        uint256 amount = address(this).balance;
        balance = 0;
        payable(owner).transfer(amount);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

  
}