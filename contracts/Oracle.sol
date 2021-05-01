pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;

contract Oracle{

    mapping(bytes32=>Result)private results;

    struct Result{
        bool exist;
        uint payload;
    }

    function feedData(bytes32 _datakey, uint _payload)external{
        require(results[_datakey].exist == false, "This data was already imported");
        results[_datakey]= Result(true , _payload)
    }

    function getData(bytes32 _dataKey)view external returns(Result memory){
        return results[_dataKey];
    }
}