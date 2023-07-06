// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract Upload{


    // Creting a data-type for the user who has given the access:
    struct Access{
        address user;
        bool access;   
    }

    // address => photos(values)
    // one person can upload multiple image url from ipfs
    mapping(address => string[]) values;

    mapping(address => Access[]) accessList;

    // owner ship data:
    mapping(address => mapping (address => bool)) ownership;


    // for previos values: 
    mapping(address => mapping(address => bool)) previousData;



    // function to upload images url:

    function add(address _user, string memory url) external {
        values[_user].push(url);
    }


    function allow(address user) public{
        ownership[msg.sender][user] = true;
        if(previousData[msg.sender][user]){
            // if old user:
            for(uint i = 0 ; i < accessList[msg.sender].length ; i++){
                if(accessList[msg.sender][i].user == user){
                    accessList[msg.sender][i].access = true;
                }
            }
        }else{
            // new user:
            accessList[msg.sender].push(Access(user, true));
            previousData[msg.sender][user] = true;
        }
    }

    function disallow(address user) public {
        ownership[msg.sender][user] = false;
        for(uint i = 0 ; i < accessList[msg.sender].length ; i++){
            if(accessList[msg.sender][i].user == user){
                accessList[msg.sender][i].access = false;
            }
        }
    }


    // display all images of user:

    function display(address _user) external view returns (string [] memory){
        // check for access:
        require(_user == msg.sender || ownership[_user][msg.sender],"You are not allowed to see Images");
        return values[_user];
    }


    // function to fetch the list of shared user:
    function sharedAccess() public view returns (Access[] memory){
        return accessList[msg.sender];
    }
    

}