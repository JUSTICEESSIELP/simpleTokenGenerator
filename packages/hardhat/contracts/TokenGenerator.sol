pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./JusticeToken.sol";

error Vendor__TransferFailed();

contract TokenGenerator is Ownable {
  //State Variables
  JusticeToken public justiceToken;
  uint256 public constant tokensPerEth = 100;

  //Events
  event BuyTokens(address buyers, uint256 amountOfEth, uint256 amountsOfToken);
  event SellTokens(address seller, uint256 amountOfToken, uint256 amountsOfEth);

  constructor(address tokenAddress) {
    justiceToken = JusticeToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 tokens = tokensPerEth * msg.value;
    justiceToken.transfer(msg.sender, tokens);
    emit BuyTokens(msg.sender, msg.value, tokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
    uint256 amount = address(this).balance;
    (bool success, ) = payable(msg.sender).call{value: amount}("");
    if (!success) {
      revert Vendor__TransferFailed();
    }
  }

  // ToDo: create a sellTokens() function:
  function sellTokens(uint256 amount) public {
    // require(amount  0, 'Can Not');
    // require(amount < address(this).balance, 'Can Not Buy');
    uint256 tokensToEth = amount / tokensPerEth;
    justiceToken.transferFrom(msg.sender, address(this), amount);
    (bool success, ) = payable(msg.sender).call{value: tokensToEth}("");
    if (!success) {
      revert Vendor__TransferFailed();
    }
    emit SellTokens(msg.sender, amount, tokensToEth);
  }
}
