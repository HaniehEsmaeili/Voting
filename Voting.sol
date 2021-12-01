pragma solidity ^0.4.2;

contract Voting{
    
    address owner;
    uint128 NumofCandidates;
    uint128 WinnerID;
    uint128 VoteofWinner=0;
    
    struct Candidate{
        string name;
        uint128 id;
        uint128 NumofVote;
    }
    
    mapping(uint=> Candidate) Candidates;
    mapping(address=> bool) Participants;
    
    constructor () public{
        owner=msg.sender;
    }
    
    
    function AddCandidate( string memory _name) public returns(string memory){
        require(msg.sender== owner, "function is not accessable");
        NumofCandidates++;
        Candidates[NumofCandidates]= Candidate(_name, NumofCandidates, 0);
        return "The Candidate Was Added";
        }
        
    function Vote (uint128 id) public returns(string memory){
        require(NumofCandidates>=id && id>0 , "Candidate is not exist");
        require(Participants[msg.sender]== false, "You've Voted Before");
        Candidates[id].NumofVote++;
        Participants[msg.sender]= true;
        return "The Vote Was Registered";
    }
    
    function ShowWinner() public returns(string memory){
    
        for(uint128 i=1; i<=NumofCandidates; i++){
            if(Candidates[i].NumofVote> VoteofWinner){
                WinnerID=i;
                VoteofWinner= Candidates[i].NumofVote;
            }
        }
        return Candidates[WinnerID].name;
    }
}