// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/finance/PaymentSplitter.sol";

// 0xe6946958D4cC98E8dEcc0A7fACAe8225870CC1B1
/// @custom:security-contact contact@notnian.dev
contract Royalties is PaymentSplitter {
    /*
    ["0x5F39276f205533e30a78f4B02535C64171f620D7","0x8372f9c028a8A1fFCeffc6bEdDd4ED344B0D89d9"],
    [50,50]
    */
    constructor(address[] memory _payees, uint256[] memory _shares) PaymentSplitter(_payees, _shares) payable {

    }
}