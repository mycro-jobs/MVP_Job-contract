pragma solidity ^0.4.24;

contract MycroJobsContract {
    address public owner;
    address public jobber;
    uint agreedAmount;
    bool contractIsPaid;
    bool workerGotPaid;
    bool contractIsDone;
    
    //basic init of job contract
    //_jobber: jobber address
    //agreedAmount: the amount both parties agreed
    //contractIsPaid: init of contract is paid
    //contractIsDone: init of contract is done
    constructor(address _jobber) public payable {
        require(_jobber != 0 && msg.sender != 0 && msg.value != 0);
        owner = msg.sender;
        jobber = _jobber;
        agreedAmount = msg.value;
        contractIsPaid = true;
        contractIsDone = false;
    }
    
    //pay the jobber when work is done. 
    //contract must be paid: false
    //workerGotPaid (jobber) must be: false
    //sender must be the owner of the contract
    //jobber address must be != 0
    function payWorker() external returns (bool)
    {
        require(contractIsPaid == true && workerGotPaid == false && msg.sender == owner && jobber != 0);
        contractIsPaid = true;
        contractIsDone = true;
        jobber.transfer(agreedAmount);
        return true;
    }
    
    //return if contract is paid
    function isContractPaid() view external returns(bool)
    {
        return contractIsPaid;
    }
    
    //check if contract is done
    function isContractDone() view external returns(bool)
    {
        return contractIsDone;
    }
    
    //return owner address
    function getOwnerAddress() view external returns(address)
    {
        require(msg.sender == owner || msg.sender == jobber);
        return owner;
    }
    
    //return jobber address
    function getJobberAddress() view external returns(address)
    {
        require(msg.sender == owner || msg.sender == jobber);
        return jobber;
    }
    
    //return contract address
    function getContractAddress() view external returns(address)
    {
        require(msg.sender == owner || msg.sender == jobber);
        return address(this);
    }
    
    //return agreed amount
    function getAgreedAmount() view external returns(uint)
    {
        require(msg.sender == owner || msg.sender == jobber);
        return agreedAmount;
    }
}
