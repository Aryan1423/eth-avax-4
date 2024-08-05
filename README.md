# Degen Token 

This repository contains the implementation of the Degen (DGN) token, an ERC20-compliant smart contract with additional functionalities for minting, burning, and redeeming tokens for items. The contract utilizes OpenZeppelin's libraries to ensure security and reliability.

## Description

The Degen smart contract extends the standard ERC20 token functionalities and includes additional features:

- **Minting**: Allows the owner to mint new tokens.
- **Burning**: Allows any token holder to burn their tokens.
- **Redeeming**: Allows token holders to redeem tokens for specific items.
- **Ownership**: Ownership management to control minting and other restricted functionalities.

## Getting Started

### Prerequisites

To interact with this contract, you need:

- A Solidity-compatible IDE, such as Remix.
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Aryan is ERC20, Ownable {
    string private constant TOKEN_NAME = "Degen";
    string private constant TOKEN_SYMBOL = "DGN";

    struct Item {
        uint256 id;
        string name;
        uint256 price;}

    uint256 private itemCount;
    mapping(uint256 => Item) private items;
    mapping(address => Item[]) private redeemedItems;

    constructor() ERC20(TOKEN_NAME, TOKEN_SYMBOL) Ownable(msg.sender) {
        itemCount = 0;}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);}

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);}

    function listItem(string memory itemName, uint256 price) public onlyOwner {
        itemCount++;
        items[itemCount] = Item(itemCount, itemName, price);}

    function displayItems() public view returns (Item[] memory) {
        Item[] memory allItems = new Item[](itemCount);
        for (uint256 i = 1; i <= itemCount; i++) {
            allItems[i - 1] = items[i];}
        return allItems;}

    function redeem(uint256 id) public {
        require(id > 0 && id <= itemCount, "Item doesn't exist");
        Item memory selectedItem = items[id];
        require(selectedItem.price <= balanceOf(msg.sender), "Insufficient token balance");

        _transfer(msg.sender, owner(), selectedItem.price);
        redeemedItems[msg.sender].push(selectedItem);}


    function showRedeemedItems(address account) public view returns (Item[] memory) {
        return redeemedItems[account];}
}

```

### Steps

1. **Open Remix IDE**:
   - Navigate to [Remix IDE](https://remix.ethereum.org).

2. **Create a New File**:
   - Click on the "File Explorers" tab in the sidebar.
   - Click on the "New File" button and name your file `Degen.sol`.
   - Paste the Solidity code provided above into the newly created `Degen.sol` file.

3. **Compile the Contract**:
   - Click on the "Solidity Compiler" tab in the sidebar.
   - Ensure the "Compiler" version is set to `0.8.18`.
   - Click on the "Compile Degen.sol" button.

4. **Deploy the Contract**:
   - Click on the "Deploy & Run Transactions" tab in the sidebar.
   - Ensure the "Environment" is set to "JavaScript VM".
   - Click on the "Deploy" button.

5. **Interact with the Contract**:
   - Once deployed, the contract's functions will appear in the "Deployed Contracts" section.
   - You can mint tokens by calling the `mint` function (only callable by the contract owner).
   - You can burn tokens by calling the `burn` function.
   - You can redeem tokens for items by calling the `redeem` function.
   - You can check balances by calling the `balanceOf` function.
   - You can get item details by calling the `getItem` function.
   - You can transfer tokens by calling the `transfer` function.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
