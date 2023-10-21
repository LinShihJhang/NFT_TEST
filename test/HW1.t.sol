// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {Test, console2} from "forge-std/Test.sol";
import {HW_Token, NoUseful, NFTReceiver} from "../src/HW1.sol";

//問題
//1. Warning (5667): Unused.. 這告警訊息會建議要想辦法讓它消失嗎？
//2. onERC721Received 裡面的 revert (HW1.sol line62)，要測試嗎？但我不知如何測試的到

contract HW1Test is Test {
    HW_Token public hwToken;
    NoUseful public noUseful;
    NFTReceiver public nftReceiver;

    function setUp() public {
        hwToken = new HW_Token();
        nftReceiver = new NFTReceiver(address(hwToken));
        noUseful = new NoUseful();
    }

    function testReceiver() public {
        address BobAddress = makeAddr('Bob');
        deal(BobAddress, 10 ether);
        uint tokenId = 0;
        //uint beforeBobAddressNnoUsefulBalance = noUseful.balanceOf(address(BobAddress));
        //uint beforeBobAddressHWTokenBalance = hwToken.balanceOf(address(BobAddress));

        vm.startPrank(BobAddress);
        noUseful.mint(address(BobAddress), tokenId);
        noUseful.safeTransferFrom(address(BobAddress), address(nftReceiver), tokenId);
        vm.stopPrank();

        assertEq(noUseful.ownerOf(tokenId), address(BobAddress));
        assertEq(hwToken.ownerOf(tokenId), address(BobAddress));

        //------------------------------

        // vm.startPrank(address(nftReceiver));
        // tokenId += 1;
        // vm.expectRevert(bytes("mint Failed!"));
        // nftReceiver.onERC721Received(address(BobAddress),address(BobAddress),tokenId,"");
        // vm.stopPrank();
    }


}
