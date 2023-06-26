// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract lottery{
    address public owner;
    address[] public participants;
    mapping(address=>uint256) public values;

    constructor(){
        owner=msg.sender;
    }

    function participate() public payable{
        require(msg.value>0,"You cannot enter with 0 value");
        participants.push(msg.sender);
        values[msg.sender]=msg.value;
    }

    function random() internal view returns(uint256){
        return uint((keccak256(abi.encodePacked(block.prevrandao, block.timestamp, participants.length))));
    }

    function getWinner() public payable{
        require(msg.sender==owner, "Only owner can perform this operation");
        uint r=random();
        uint index=r%participants.length;

        payable(participants[index]).transfer(address(this).balance);
    }
}
