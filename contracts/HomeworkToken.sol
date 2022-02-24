// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./RoyaltySplitter.sol";

/// @custom:security-contact contact@notnian.dev
contract HomeworkToken is ERC721, ERC2981, Ownable {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    uint256 constant private maxSupply = 10;
    uint256 constant private mintPrice = 0.001 ether;
    uint96 constant private royaltyFeesInBps = 1000;

    string private uriPrefix = "ipfs://QmP6Qh2cZemgAtbq7j4eR5gjAGA8mLGKmvRqXcLPr4PTDY/";
    string private uriSuffix = ".json";

    bytes4 private constant _INTERFACE_ID_ERC2981 = 0x2a55205a;

    RoyaltySplitter private royaltySplitter;

    constructor(address[] memory _payees, uint256[] memory _shares) ERC721("Homework", "HOW") {
        royaltySplitter = new RoyaltySplitter(_payees, _shares);
        setDefaultRoyalty(getRoyaltySplitterAddress(), royaltyFeesInBps);
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

    function getMintCost() external pure returns (uint256) {
        return mintPrice;
    }

    function getRoyaltySplitterAddress() public view returns (address) {
        return address(royaltySplitter);
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

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC2981) returns (bool) {
        return
            interfaceId ==  _INTERFACE_ID_ERC2981 ||
            super.supportsInterface(interfaceId);
    }

    function setDefaultRoyalty(address _receiver, uint96 _feeNumerator) public {
        _setDefaultRoyalty(_receiver, _feeNumerator);
    }
}