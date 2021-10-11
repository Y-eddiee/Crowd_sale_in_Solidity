pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale{ 

    constructor(
        // @TODO: Fill in the constructor parameters!
        uint rate, // rate in TKNbits
        address payable wallet, // sale beneficiary
        PupperCoin token,
        uint fakenow,
        uint close,
        uint goal
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
       
        CappedCrowdsale(goal)
        // TimedCrowdsale(now, now + 24 weeks)
        TimedCrowdsale(now, now + 5 minutes)
        Crowdsale(rate, wallet, token)
        RefundableCrowdsale(goal)
        
        
        public {
        // constructor can stay empty
    }
}

contract PupperCoinSaleDeployer {

    address public token_sale_address; // the address of my contract that mints tokens depending on the ETH sent to it
    address public token_address; // the address of my token

    constructor(
        // @TODO: Fill in the constructor parameters!
        string memory name,
        string memory symbol,
        address payable wallet,
        uint goal
    )
    
    
    
        public
    {
        // @TODO: create the PupperCoin and keep its address handy
        PupperCoin token = new PupperCoin(name, symbol, 0);
        token_address = address(token);
        
        
        // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        // PupperCoinSale pupper_sale = new PupperCoinSale(1, wallet, token, goal,fakenow, now, now + 24 weeks);
        
        
        //  Test the time functionality by replacing now with fakenow, and creating a setter function to modify fakenow and now + 5 mins instead.
        PupperCoinSale pupper_sale = new PupperCoinSale(1, wallet, token, goal, now, now + 5 minutes);
        
        token_sale_address = address(pupper_sale);
        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}
