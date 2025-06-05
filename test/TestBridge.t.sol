// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {OpenseaNFT} from "../src/OpenSeaNFT.sol";
import {NFTBridge} from "../src/NFTBridge.sol";

contract BridgeTest is Test {
    OpenseaNFT public NFT;
    NFTBridge public Bridge;

    address deployer;
    address user1 = address(1);

    function setUp() public {
        vm.createSelectFork(vm.envString("RPC_URL"));
        deployer = msg.sender;

        vm.startPrank(deployer);
        NFT = OpenseaNFT(0x0000000000000000000000000000000000000000);
        Bridge = new NFTBridge();
        vm.stopPrank();

        vm.deal(deployer, 100 ether);
        vm.deal(user1, 100 ether);
    }

    function test_Bridge() public {
        vm.startPrank(0x0000000000000000000000000000000000000000);

        NFT.setApprovalForAll(address(Bridge), true);
        bool hasApproval = NFT.isApprovedForAll(0x0000000000000000000000000000000000000000, address(Bridge));
        assertTrue(hasApproval);

        Bridge.lock(msg.sender, 1, 0, 0, 0);
        vm.stopPrank();
    }
}
