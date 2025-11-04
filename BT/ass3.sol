// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Banking {
    mapping(address => uint256) public user_account;
    mapping(address => bool) public user_exists;

    // --- Events ---
    event AccountCreated(address indexed user);
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // --- Create account ---
    function create_account() public payable returns (string memory) {
        require(!user_exists[msg.sender], "Account already created");

        user_account[msg.sender] = msg.value;
        user_exists[msg.sender] = true;

        emit AccountCreated(msg.sender);
        return "Account created successfully";
    }

    // --- Deposit ---
    function deposit() public payable returns (string memory) {
        require(user_exists[msg.sender], "Account not created");
        require(msg.value > 0, "Deposit amount must be greater than zero");

        user_account[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
        return "Deposit successful";
    }

    // --- Withdraw ---
    function withdraw(uint256 amount) public returns (string memory) {
        require(user_exists[msg.sender], "Account not created");
        require(amount > 0, "Amount should be more than zero");
        require(user_account[msg.sender] >= amount, "Insufficient balance");

        user_account[msg.sender] -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdraw(msg.sender, amount);
        return "Withdrawal successful";
    }

    // --- Transfer to another account ---
    function transfer(address payable userAddress, uint256 amount) public returns (string memory) {
        require(user_exists[msg.sender], "Your account not created");
        require(user_exists[userAddress], "Receiver account not created");
        require(amount > 0, "Amount should be more than zero");
        require(user_account[msg.sender] >= amount, "Insufficient balance");

        user_account[msg.sender] -= amount;
        user_account[userAddress] += amount;

        emit Transfer(msg.sender, userAddress, amount);
        return "Transfer successful";
    }

    // --- Send Ether directly to another address (outside bank) ---
    function send_amt(address payable toAddress, uint256 amount) public returns (string memory) {
        require(user_exists[msg.sender], "Account not created");
        require(amount > 0, "Amount should be more than zero");
        require(user_account[msg.sender] >= amount, "Insufficient balance");

        user_account[msg.sender] -= amount;
        (bool success, ) = toAddress.call{value: amount}("");
        require(success, "Transfer failed");

        emit Transfer(msg.sender, toAddress, amount);
        return "Direct send successful";
    }

    // --- Check balance ---
    function user_balance() public view returns (uint256) {
        return user_account[msg.sender];
    }

    // --- Check if account exists ---
    function account_exist() public view returns (bool) {
        return user_exists[msg.sender];
    }
}
