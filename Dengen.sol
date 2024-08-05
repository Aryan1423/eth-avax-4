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
