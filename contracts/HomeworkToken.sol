// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// 0xf4f2fcD073912D08EEDeA09Ac49eEd4F40803364
/// @custom:security-contact contact@notnian.dev
contract HomeworkToken is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint8 constant private tokens = 10;
    uint56 constant public mintPrice = 0.001 ether;
    address payable royalties;

    constructor(address payable _royalties) ERC721("Homework", "HOW") {
        require(address(0) != _royalties, "Require valid royalties address");
        // Start counter to 1
        _tokenIdCounter.increment();
        royalties = _royalties;
    }

    // 1000000000000000 wei
    function safeMint() external payable {
        require(msg.value == mintPrice, "Mint price is 0.001eth");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, string(abi.encodePacked("ipfs://QmP6Qh2cZemgAtbq7j4eR5gjAGA8mLGKmvRqXcLPr4PTDY/",Strings.toString(tokenId) ,".json")));
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    
    function withdraw() external onlyOwner  {
        (bool success, ) = payable(royalties).call{value: address(this).balance}("");
        require(success, "Royalties payment failed");
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
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

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}