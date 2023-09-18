// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract JusticeToken is ERC20 {
  constructor() ERC20("JUSTICE", "JTT") {
    // Mint 100 tokens to msg.sender
    // Similar to how
    // 1 dollar = 100 cents
    // 1 token = 1 * (10 ** decimals)
    _mint(msg.sender, 1000 * 10 ** uint(decimals()));
  }
}
