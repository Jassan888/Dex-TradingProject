pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;

contract Oracle{

    mapping(bytes32=>Result)private results;
    address public validators;

    struct Result{
        bool exist;
        uint payload;
        address approvedBy;
    }

    constructor(address memory _validators)public{
        validators = _validators;
    }

    function feedData(bytes32 _datakey, uint _payload)external onlyValidator(){
        address[]memory approvedBy= new address[](1);
        approvedBy[]= msg.sender;
        require(results[_datakey].exist == false, "This data was already imported");
        results[_datakey]= Result(true , _payload, approvedBy)
    }

    function approveData(bytes32 _dataKey)external onlyValidator(){
        Result storage result = results[_dataKey];
        require(result.exist == true,"Can't approve non existing data.");
        for(uint i= 0; i < result.approvedBy.length; i++){
            require(result.approvedBy[i] != msg.sender,"Can't approve same data.");
        }
        result.approvedBy.push(msg.sender);
    }

    function getData(bytes32 _dataKey)view external returns(Result memory){
        return results[_dataKey];
    }

    modifier onlyValidator(){
        bool isValdator= false;
        for(uint i= 0; i < validators.length; i++){
            if(validators[i] == msg.sender){
                isValdator = true;
            }
        }
        require(isValdator == true, "Only Validator");
        _;
    }
}