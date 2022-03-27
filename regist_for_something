pragma solidity ^0.4.25;

contract Class{
    struct Student{
        string name;
        uint score;
        bool active;
    }
    mapping(uint => Student) students;
    modifier ActiveStudent(uint id){
        require(students[id].active, "Student is inactive");
        _;
    }

    function register(uint id, string name) public{
        students[id] = Student({name: name, score:0, active: true});
    }
    
    function modifyScore(uint id, uint score) public ActiveStudent(id){
        students[id].score = score;
    }

    function getStudent(uint id) public ActiveStudent(id) view returns(string, uint){
        return(students[id].name, students[id].score);
    }
}
