// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {OpenseaNFT} from "../src/OpenSeaNFT.sol";
import {NFTBridge} from "../src/NFTBridge.sol";
import {NETWORK1155} from "../src/NETWORK1155.sol";

contract DeployScript is Script {
    OpenseaNFT public NFT;
    NFTBridge public Bridge;
    NETWORK1155 public NETWORKNFT;

    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("DEPLOYER_PK");
        vm.startBroadcast(privateKey);

        Bridge = NFTBridge(0x0000000000000000000000000000000000000000);
        Bridge.lock(0x0000000000000000000000000000000000000000, 1, 0, 0, 0);

        vm.stopBroadcast();
    }
}
