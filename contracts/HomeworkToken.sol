// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Royalties.sol";

/// @custom:security-contact contact@notnian.dev
contract HomeworkToken is ERC721, Ownable {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    uint8 constant private maxSupply = 10;
    uint56 constant private mintPrice = 0.001 ether;

    string private uriPrefix = "ipfs://QmP6Qh2cZemgAtbq7j4eR5gjAGA8mLGKmvRqXcLPr4PTDY/";
    string private uriSuffix = ".json";

    Royalties private royalties;

    constructor(address[] memory _royalitesPayees, uint256[] memory _royalitesShares) ERC721("Homework", "HOW") {
        // Deploy paymentSplitter
        royalties = new Royalties(_royalitesPayees, _royalitesShares);
    }

    modifier mintRequirements() {
        require(msg.value == mintPrice, "Mint price is set to 0.001 eth");
        require(_tokenIdCounter.current() < maxSupply, "Supply is limited to 10!");
        _;
    }

    function safeMint() external payable mintRequirements {
        _tokenIdCounter.increment();
        _safeMint(msg.sender, _tokenIdCounter.current());
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return string(abi.encodePacked(uriPrefix, tokenId.toString(), uriSuffix));
    }

    // Getters

    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter.current();
    }

    function getMintCost() external pure returns (uint56) {
        return mintPrice;
    }

    // Setters for tokenURI

    function setUriPrefix(string memory _uriPrefix) public onlyOwner {
        uriPrefix = _uriPrefix;
    }

    function setUriSuffix(string memory _uriSuffix) public onlyOwner {
        uriSuffix = _uriSuffix;
    }

    // Contract balance and withdraw function

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function withdraw() external onlyOwner  {
        (bool success, ) = payable(royalties).call{value: address(this).balance}("");
        require(success, "Royalties payment failed");
    }
}