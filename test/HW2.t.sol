// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyToken is ERC721, ERC721Burnable, Ownable {

    string public baseURI;
    uint public constant totalSupply = 500;
    uint public currenSupply;

    constructor(address initialOwner, string memory baseURI_)
        ERC721("HW2 Do not send NFT to me ", "NONFT")
        Ownable(initialOwner)
    {
        baseURI = baseURI_;
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function randimSafeMint(address to) public onlyOwner {
        uint256 tokenId = uint256(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, msg.sender))) % 500;
        require(_ownerOf(tokenId) == address(0x0), "TokenId is already mint.");
        require(currenSupply < totalSupply, "Mint End! TotalSupply is 500!");
        currenSupply += 1 ;
        _safeMint(to, tokenId);
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default, can be overridden in child contracts.
     */
    function _baseURI() internal view override virtual  returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory baseURI_) onlyOwner external {
        baseURI=baseURI_;
    }
}
