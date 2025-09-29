// SPDX-License-Identifier: MIT 
pragma solidity 0.8.30;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
contract Token2 is ERC20 {

    string public token_Name;
    string public token_Symbol;
    uint8 public token_Decimal;
    ERC20 public token;
    uint256 public token_AmountToMint;


	constructor(string memory _name, string memory _symbol ) ERC20(_name, _symbol) {
        token_Name = _name;
        token_Symbol = _symbol;
        token_Decimal = 18;
        token_AmountToMint = 50 ether;

        _mint(msg.sender, token_AmountToMint); 
	}

    function getTotalSupply() public view returns (uint256) {
        return totalSupply();
    }
}