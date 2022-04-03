pragma solidity ^0.4.11;

contract Election{
    //Model a Candidate
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    //Store accounts that have voted
    mapping(address => bool) public voters;
    //Fetch Candidate
    mapping(uint => Candidate) public candidates;
    //Store Candidates Count
    uint public candidatesCount;

     event votedEvent(
         uint indexed _candidateId
     );

    //Constructor
    constructor()public{
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    function addCandidate(string _name) private{
        candidatesCount ++; //id of candidate
        candidates[candidatesCount] = Candidate(candidatesCount, _name,0);
    }
    function vote(uint _candidateId) public {
        require(!voters[msg.sender]); //account is not in voters mapping

        require(_candidateId >0 && _candidateId <= candidatesCount);
        //record that voter has voted
        voters[msg.sender] = true;
        //update candidate vote Count
        candidates[_candidateId].voteCount ++;

        votedEvent(_candidateId);
    }
}