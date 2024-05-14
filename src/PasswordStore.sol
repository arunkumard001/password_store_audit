// SPDX-License-Identifier: MIT
pragma solidity 0.8.18; 

/*
 * @author not-so-secure-dev
 * @title PasswordStore
 * @notice This contract allows you to store a private password that others won't be able to see. 
 * You can update your password at any time.
 */
 
contract PasswordStore {
    error PasswordStore__NotOwner();
  
    address private s_owner;
    string private s_password;
    //@audit : private data type in storage is not private

    event SetNetPassword();

    constructor() {
        s_owner = msg.sender;
    }

    /*
     * @notice This function allows only the owner to set a new password.
     * @param newPassword The new password to set.
     */
     
    // @audit : Missing access controll
    // @audit-issue :  able to set password for non owner 
    function setPassword(string memory newPassword) external {
        s_password = newPassword;
        emit SetNetPassword();
    }

    /*
     * @notice This allows only the owner to retrieve the password.
     * @param newPassword The new password to set.
     */
     //@audit : parameter is missing
    //@audit-issue : newPassword parameter is missing in getPassword function

    function getPassword() external view returns (string memory) {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
}
