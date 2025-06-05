// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NETWORK1155} from "../src/NETWORK1155.sol";

contract NETWORK1155Test is Test {
    NETWORK1155 public nftContract;

    address deployer;
    address admin = address(1);
    address user1 = address(2);

    function setUp() public {
        vm.createSelectFork(vm.envString("RPC_URL"));
        deployer = msg.sender;

        vm.startPrank(deployer);
        nftContract = new NETWORK1155();
        vm.stopPrank();

        vm.deal(deployer, 100 ether);
        vm.deal(admin, 100 ether);
    }

    function test_add_admin() public {
        vm.prank(deployer);
        nftContract.addAdmin(admin, true);
        vm.stopPrank();

        assert(nftContract.isAdmin(admin) == true);
    }

    function test_all_tokens_minted() public view {
        assert(nftContract.balanceOf(address(nftContract), 0) == 50);
        assert(nftContract.balanceOf(address(nftContract), 1) == 50);
        assert(nftContract.balanceOf(address(nftContract), 2) == 50);
        assert(nftContract.balanceOf(address(nftContract), 3) == 1);
    }

    function test_transfer_to_user() public {
        uint256[] memory tokenIds = new uint256[](4);
        tokenIds[0] = 0;
        tokenIds[1] = 1;
        tokenIds[2] = 2;
        tokenIds[3] = 3;

        uint256[] memory amounts = new uint256[](4);
        amounts[0] = 5;
        amounts[1] = 2;
        amounts[2] = 1;
        amounts[3] = 1;

        vm.prank(deployer);
        nftContract.addAdmin(admin, true);
        vm.stopPrank();

        vm.prank(admin);
        nftContract.mint(user1, tokenIds, amounts);
        vm.stopPrank();
    }
}
