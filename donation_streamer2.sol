pragma solidity ^0.4.25;

contract Donation_streamer{
    struct DonorInfo{
        address[] donors;
        mapping (address => uint) ledger ;
    }
    mapping(address => DonorInfo) DonationHistroy;
    event LogDonate(
        address streamer, address donor, string nickname,
        uint value, string message
    );
    function donate(address _streamer, string _nickname, string _message)
        public payable{
            require(msg.value >0);
            _streamer.transfer(msg.value);

            if (DonationHistroy[_streamer].ledger[msg.sender]==0){
                DonationHistroy[_streamer].ledger[msg.sender] += msg.value;
                DonationHistroy[_streamer].donors.push(msg.sender);
            }
            DonationHistroy[_streamer].ledger[msg.sender] += msg.value;
            
            emit LogDonate(
                _streamer,
                msg.sender,
                _nickname,
                msg.value,
                _message
            );
        }
    function getDonorList() public view returns (address[]){
        return DonationHistroy[msg.sender].donors;

    }

    event LogListDonorInfo(address streamer, address user, uint value);

    function listDonorInfo() public{
        for(uint i=0; i<DonationHistroy[msg.sender].donors.length; i++){
            address user = DonationHistroy[msg.sender].donors[i];
            emit LogListDonorInfo(msg.sender, user, DonationHistroy[msg.sender].ledger[user]);
        }

    }    
}
