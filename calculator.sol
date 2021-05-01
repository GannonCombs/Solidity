pragma solidity ^0.6.2;

contract Calculator {
    
    function add(uint a, uint b) public pure returns(uint){
        return a+b;
    }
    
    function subtract(uint a, uint b) public pure returns(uint){
        return a-b;
    }
    
    function multiply(uint a, uint b) public pure returns(uint){
        return a*b;
    }
    
    function modulo(uint a, uint b) public pure returns(uint){
        return a%b;
    }
    
    function divide(uint a, uint b) public pure returns(uint){
        require(b!= 0, "Can't divide by zero.");
        //Solidity doesn't support floats yet, so unless I want to get tricky,
        //I'll have to leave the quotient as rounded to the nearest integer.
        return a/b;
    }
}
