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