pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * Split rent via smart contract
 */
contract DelReyClubRent {
    address public renterA;
    address public renterB;

    uint256 public totalRent;
    uint256 public balanceA = 0;
    uint256 public balanceB = 0;

    IERC20 usdc;

    event RentFulfilled(address renterA, address renterB, uint256 totalRent);
    event RentDeposited(address from, uint256 amount);
    event RentWithdraw(address to, uint256 amount);

    modifier onlyRenters() {
        require(msg.sender == renterA || msg.sender == renterB);
        _;
    }

    constructor(
        address _renterA,
        address _renterB,
        uint256 _totalRent,
        address _usdcAddress
    ) {
        renterA = _renterA;
        renterB = _renterB;
        totalRent = _totalRent;
        usdc = IERC20(_usdcAddress);
    }

    function depositRent() external {
        uint256 rentSplit = totalRent / 2;
        require(
            usdc.balanceOf(msg.sender) >= rentSplit,
            "Not enough usdc balance"
        );

        if (msg.sender == renterA) {
            require(balanceA == 0, "Already has a balance");
        } else if (msg.sender == renterB) {
            require(balanceB == 0, "Already has a balance");
        }

        bool success = usdc.transferFrom(msg.sender, address(this), rentSplit);
        require(success, "Failed to transfer usdc to contract");

        if (msg.sender == renterA) {
            balanceA = rentSplit;
        } else if (msg.sender == renterB) {
            balanceB = rentSplit;
        }

        emit RentDeposited(msg.sender, rentSplit);

        if (usdc.balanceOf(address(this)) >= totalRent) {
            emit RentFulfilled(renterA, renterB, totalRent);
        }
    }

    function withdraw() external onlyRenters {
        uint256 balance = usdc.balanceOf(address(this));
        require(balance >= totalRent, "Rent hasn't been payed yet");

        bool success = usdc.transfer(msg.sender, balance);
        require(success, "Failed to transfer usdc");

        balanceA = 0;
        balanceB = 0;

        emit RentWithdraw(msg.sender, balance);
    }
}
