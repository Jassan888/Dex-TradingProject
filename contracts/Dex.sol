pragma solidity ^0.5.8;

contract Dex{

    address public 

    mapping(string=> uint)private prices;

    function getPrice( string calldata _sticker)external view returns(uint){
        return prices[_sticker];
    }

    function buy(string calldata _sticker, uint _amount, uint _price)external {

    }

    function sell()external{

    }
}