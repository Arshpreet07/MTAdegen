// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address private owner;
    constructor() ERC20("Degen", "DGN") {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function!");
        _;
    }
 
    function mint(address to, uint256 amount) public onlyOwner{
        _mint(to,amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        require(amount<=balanceOf(msg.sender),"Insufficient balance.");
        _transfer(msg.sender, to, amount);
        return true;
    }
    
    function burn(uint256 amount) public{
        _burn(msg.sender,amount);
    }

    function redeem(uint256 choice) external{
        uint amount;
        if(choice==1){
            amount=300;
        }
        else if(choice==2){
            amount=290;
        }
        else{
            amount=270;
        }
        require(amount>0,"Invalid redemption!");
        _burn(msg.sender,amount);
    }
    function store() external pure returns(string memory){
        return "1. item 1(300 DGN) / 2. item 2(290 DGN) / 3. item 3(270 DGN)";
    }
}
