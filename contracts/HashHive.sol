// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "base64-sol/base64.sol";

contract HashHive is ERC721, ERC721URIStorage, Ownable {

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 public fees;
    uint256 public totalSupply;


    constructor(
        string memory name_,
        string memory symbol_,
        uint256 fees_
    ) ERC721(name_, symbol_){
        fees = fees_;
    }

    function setFee(uint256 _newFee) public {
        fees = _newFee;
    }

    function createUri(string memory _title, string memory _text)
        internal
        pure
        returns (string memory uri)
    {
        uri = string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"title":"',
                            _title,
                            '","text":"',
                            _text,
                           '"}'
                        )
                    )
                )
            )
        );
    }


    function  safeMint(address to, string memory _title, string memory _text) public payable {

        require(msg.value >= fees, "Not enough DCM");
        payable(owner()).transfer(fees);

        //Mint NFT

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        totalSupply ++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, createUri(_title, _text)); 
        //Return extra fees

        uint256 contractBalance = address(this).balance;

        if (contractBalance > 0) {
            payable(msg.sender).transfer(address(this).balance);
        }


    }

    // Override Functions

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }


}