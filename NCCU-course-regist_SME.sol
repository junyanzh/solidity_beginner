// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.4;

contract SME_num{
    uint256 public SMEConunt = 0;
    mapping(uint => SME) public SMEs;

    struct SME{
        uint _id;
        string _BAN;
        string _companyName;
        string _companyAddress;
    }

    function addSME( string memory _companyName, string memory _companyAddress, string memory _BAN) public{
        SMEConunt += 1;
        SMEs[SMEConunt] = SME(SMEConunt,_BAN, _companyName, _companyAddress);
    }

}
