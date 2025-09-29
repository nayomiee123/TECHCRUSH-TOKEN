// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Token2} from "../src/Token2.sol";
import {Script} from "forge-std/Script.sol";

contract Token2Script is Script {
    // Add your script logic here
    Token2 public token;

    function run() external returns (Token2) {
        vm.startBroadcast();

        token = new Token2("NAOMI", "NAI");

        vm.stopBroadcast();
        return token;
    }
}
