// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {Test, console2} from "forge-std/Test.sol";
import {MyToken} from "../src/HW2.sol";

//問題
//1. myToken.randimSafeMint 有辦法測試revert嗎？出現revert的狀況也是隨機的
//2. 還有什麼測試需要寫？

contract HW2Test is Test {
    MyToken public myToken;
    address BobAddress;

    function setUp() public {
        BobAddress = makeAddr('Bob');
        myToken = new MyToken(BobAddress, "ipfs://QmW9wxFDp82guExQGxo4riSMv9VGj8Nnj6SZDt4ECdKHJH/");
    }

    function testSetURI() public {
        vm.startPrank(BobAddress);
        myToken.safeMint(address(BobAddress), 0);
        assertEq(myToken.tokenURI(0), "ipfs://QmW9wxFDp82guExQGxo4riSMv9VGj8Nnj6SZDt4ECdKHJH/0");
        myToken.setBaseURI("ipfs://QmSRxpLr6qF2rkRQ9GLCrxP4yBjHvq4vysfTzGGhgrayXH/");
        assertEq(myToken.tokenURI(0), "ipfs://QmSRxpLr6qF2rkRQ9GLCrxP4yBjHvq4vysfTzGGhgrayXH/0");
        vm.stopPrank();
    }

    // function testRandimSafeMint(){
    //     vm.startPrank(BobAddress);
    //     vm.expectRevert(bytes("mint Failed!"));
    //     myToken.randimSafeMint(address(0x0));
    //     vm.stopPrank();      
    // }
}
