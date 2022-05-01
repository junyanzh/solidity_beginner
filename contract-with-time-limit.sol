// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.4;
//只有特定時間可以改

contract SME_num{
    uint256 public SMEConunt = 0;
    mapping(uint => SME) public SMEs;
    //timestamp by epoch coversion
    uint256 openingTime = 1651419632;


    modifier onlyWhileOpen(){
        require(block.timestamp >= openingTime);
        _;
    }
    struct SME{
        uint _id;
        string _BAN;
        string _companyName;
        string _companyAddress;
    }
    //改onlyWhileOpen
    function addSME( string memory _companyName, string memory _companyAddress, string memory _BAN) 
    public onlyWhileOpen{
        SMEConunt += 1;
        SMEs[SMEConunt] = SME(SMEConunt,_BAN, _companyName, _companyAddress);
    }

    function incrementCount() internal{
        SMEConunt +=1;
    }

}
