// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Token2} from "../src/Token2.sol";
import {Test, console, StdCheats} from "forge-std/Test.sol";
import {Token2Script} from "../script/Token2Script.s.sol";

contract TestToken is Test {
    //call src contract as a state variable
    //call scipt contract as a state variable

    Token2 public token;
    Token2Script public deployer;

    //actors- deployers, sender1, receiver1, sender2, receiver2
    address public deployerAddress = makeAddr("deployer");
    address public sender1 = makeAddr("sender 1");
    address public receiver1 = makeAddr("receiver 1");

    function setUp() public {
        //new is used to deploy a contract in a contract
        vm.startPrank(deployerAddress);
        token = new Token2("NAOMI", "NAI");
        console.log("the new token is", address(token));
        deployer = new Token2Script();
        console.log("the new deployer is", address(deployer));

        vm.deal(sender1, 1 ether);
        vm.deal(receiver1, 1 ether);

        token.transfer(sender1, 30 ether);
        vm.stopPrank();
    }

    //test if you can transfer token from sender to receiver
    function testTransfer() public {
        vm.startPrank(deployerAddress);
        token.transfer(receiver1, 1 ether);
        vm.stopPrank();
    }

    function testBalanceOf() public view {
        //balanceOf function is used to check the balance of a particular address
        uint256 deployerBalance = token.balanceOf(deployerAddress);

        uint256 senderBalance = token.balanceOf(sender1);

        uint256 receiverBalance = token.balanceOf(receiver1);

        console.log("the deployerBalance is", deployerBalance);
        console.log("the senderBalance is", senderBalance);
        console.log("the receiverBalance is", receiverBalance);
    }
    // allowance function is used for setting strict restriction from sender to receiver

    function testAllowance() public {
        // nezuko.... sender sends nezuko to send 2 ether on behalf of herself
        address nezuko = makeAddr("nezuko");
        uint256 amountToSend = 1 ether;
        vm.startPrank(sender1);
        token.approve(nezuko, 1 ether);
        vm.stopPrank();

        // we are sending nezuko to send on behalf of sender1
        vm.startPrank(nezuko);
        token.transferFrom(sender1, receiver1, amountToSend);
        vm.stopPrank();

        uint256 receiverBalance = token.balanceOf(receiver1);
        console.log("he amount in my receiver address is", receiverBalance);
        uint256 senderBalance = token.balanceOf(sender1);
        console.log("the senderBalance is", senderBalance);
    }

    //test if the balance exceed balance
    function testBalanceforExceedBalance() public {
        uint256 senderBalance = token.balanceOf(sender1);
        console.log("the senderBalance is", senderBalance);
        uint256 amountThatExceedsBalance = senderBalance + 1 ether;
        vm.startPrank(sender1);
        vm.expectRevert();
        token.transfer(receiver1, amountThatExceedsBalance);
        vm.stopPrank();
    }

    function testTotalSupply() public view {
        uint256 totalSupply = token.getTotalSupply();
        console.log("the total supply is", totalSupply);
        assertEq(totalSupply, 50 ether);
    }
}
