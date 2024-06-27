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
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.2/access/Ownable.sol";

contract Degen is ERC20, Ownable {
    struct Item {
        string name;
        uint price;
    }


    mapping(uint => Item) private Items;
    uint private numItems;

    event ItemRedeemed(address indexed player, uint itemId, uint quantity);

    constructor() ERC20("Degen", "DGN") {
        Items[1] = Item("Axe", 100); 
        Items[2] = Item("Shoe", 200);
        Items[3] = Item("Health", 500); 

        numItems = 3; 
    }

    function mint(address account, uint amount) public onlyOwner {
        _mint(account, amount);}

    function redeem(uint itemId, uint quantity) public {
        require(Items[itemId].price > 0, "Invalid item ID");
        require(quantity > 0, "Must be greater than zero");
        require(balanceOf(msg.sender) >= Items[itemId].price * quantity, "Insufficient balance");

        uint cost = Items[itemId].price * quantity;
        transfer(owner(), cost);

        emit ItemRedeemed(msg.sender, itemId, quantity);}

    function Balance(address account) public view returns (uint) {
        return balanceOf(account);}

    function burn(uint amount) public {
        require(amount > 0, "amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _burn(msg.sender, amount);}

    function getItem(uint index) public view returns (string memory, uint) {
        require(index > 0 && index <= numItems, "Item doesn't exist");
        Item storage item = Items[index];
        return (item.name, item.price);}

    function transferToken(address _address, uint _amount) public {
        _transfer(msg.sender, _address, _amount);}
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
