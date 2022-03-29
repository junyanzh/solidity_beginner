pragma solidity ^0.4.25;

contract Donation_streamer{
    event LogDonate(
        address streamer, address donor, string nickname,
        uint value, string message
    );
    function donate(address _streamer, string _nickname, string _message)
        public payable{
            _streamer.transfer(msg.value);
            emit LogDonate(
                _streamer,
                msg.sender,
                _nickname,
                msg.value,
                _message
            );
        }
}
