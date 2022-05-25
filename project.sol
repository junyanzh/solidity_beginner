pragma solidity ^0.6.8;
pragma experimental ABIEncoderV2;

// SPDX-License-Identifier: MIT

interface interProject {
    function owner() external view returns (address);
    function ProjectInvestors(uint _index) external view returns (address);
    function show() external;
}

contract fund{

    address projectAddr;

    address[] public FundInvestors; // investors of the fund.
    string[] public FundSectors; // the target sectors of the fund

    address public owner;

    address[] public proposals; // the proposals that the fund received.
    address[] public ProposalInvestors; // investors of a proposal.
    string[] public ProposalSectors;

    bool public NoDuplicateApplication;
    bool public NoDuplicateInvestors;
    bool public InTargetSectors;

    function setProject(address _projectAddr) public payable{
        projectAddr = _projectAddr;
    }

    function getOwner() external view returns (address) {
        return interProject(projectAddr).owner();
    }

    function setInvestors(address _investor) public{
        FundInvestors.push(_investor);
    }

    // Check if a Sector is already in the FundSectors List.
    function setFundSectors(string memory _sector) public {
        for (uint i = 0; i < FundSectors.length; i++) {
            /*
            String comparison cannot be done with == or != in Solidity. 
            It is because Solidity do not support operator natively. 
            We need to hash string to byte array to compare value in Solidity.
            */
            if (keccak256(abi.encodePacked(FundSectors[i])) == keccak256(abi.encodePacked(_sector))) {
                revert("The sector is already in the list!");
            }
        }
        FundSectors.push(_sector);
    }

    // set investment criteria.
    function setCriteria(bool _NoDuplicateApplication, bool _NoDuplicateInvestors, bool _InTargetSectors) public {
            NoDuplicateApplication = _NoDuplicateApplication;
            NoDuplicateInvestors = _NoDuplicateInvestors;
            InTargetSectors = _InTargetSectors;
    }

    // Check if a proposal ADDRESS is already in the project List.
    function validateDuplicateApplication(address _proposalAddr) public view returns (bool) {
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i] == _proposalAddr) {
                return true;
            }
        }
        return false;
    }

    // Check if a proposal is already invested by any of the investors of the fund.
    function validateInvestors(address[] memory _ProposalInvestors) public view returns (bool) {
        for (uint i = 0; i < FundInvestors.length; i++){
            for (uint j = 0; j < _ProposalInvestors.length; j++) {
                if (FundInvestors[i] == _ProposalInvestors[j]) {
                    return true;
                }
            }
        }
        return false;
    }

    // Check if a proposal is in the target sectors of the fund.
    function validateSectors(string[] memory _ProjectSectors) public view returns (bool) {
        for (uint i = 0; i < FundSectors.length; i++){
            for (uint j = 0; j < _ProjectSectors.length; j++){
                /*
                String comparison cannot be done with == or != in Solidity. 
                It is because Solidity do not support operator natively. 
                We need to hash string to byte array to compare value in Solidity.
                */                
                if (keccak256(abi.encodePacked(FundSectors[i])) == keccak256(abi.encodePacked(_ProjectSectors[j]))) {
                    return true;
                }
            }
        }
        return false;
    }

    function application(address[] memory _ProposalInvestors, string[] memory _ProposalSectors) external{

        if (NoDuplicateApplication) {
            require(validateDuplicateApplication(msg.sender) == false, "Duplicate Application!");
        }

        if (NoDuplicateInvestors) {
            require(validateInvestors(_ProposalInvestors) == false, "The proposal has already received funding from our investors!");
        }

        if (InTargetSectors) {
            require(validateSectors(_ProposalSectors) == true, "The proposal is not in our target sectors!");
        }

        proposals.push(msg.sender);
        ProposalInvestors = _ProposalInvestors;
        ProposalSectors = _ProposalSectors;
    }
}
