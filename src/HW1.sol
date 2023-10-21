// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

//問題
//1. HW_Token safeMint 本來是 public onlyOwner ，如果要給大家mint就需要拿掉onlyOwner，通常是這樣做嗎？
//

contract HW_Token is ERC721 {

    constructor()
        ERC721("Don't send NFT to me", "NONFT")
    {}

    //function safeMint(address to, uint256 tokenId) public onlyOwner  {
    function mint(address to, uint256 tokenId) public {
        //_safeMint(to, tokenId);
        _safeMint(to, tokenId);
    }

    function tokenURI(uint256 tokenId) public view override virtual returns (string memory) {
        return "ipfs://QmUgDYTTmo85LKHzXVuiewCfYz9T1KmWw45r8sp1W7Xhoy";
    }

}

contract NoUseful is ERC721 {

    constructor()
        ERC721("NoUseful", "NUF")
    {}

    function mint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }

}

contract NFTReceiver is IERC721Receiver, HW_Token {

    address _hwContract;

    constructor(address hwContract_){
        _hwContract = hwContract_;
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        if(msg.sender != _hwContract){
            IERC721(msg.sender).safeTransferFrom(address(this), from, tokenId);
            (bool success, ) = _hwContract.call{value: 0 }(
                abi.encodeWithSignature("mint(address,uint256)", from, tokenId)
            );
            require(success, "mint Failed!");
        }

        return this.onERC721Received.selector;
    }


}
