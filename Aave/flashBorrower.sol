pragma solidity ^0.5.0;
import "https://github.com/aave/aave-protocol/blob/master/contracts/configuration/LendingPoolAddressesProvider.sol";
import "https://github.com/aave/aave-protocol/blob/master/contracts/lendingpool/LendingPool.sol";
import "https://github.com/aave/aave-protocol/blob/master/contracts/flashloan/base/FlashLoanReceiverBase.sol";


//This is a template to use Aave's flash loans. 

contract FlashBorrower is FlashLoanReceiverBase {
    LendingPoolAddressesProvider provider;
    address dai;
    
    constructor(address _provider, address _dai) FlashLoanReceiverBase(_provider) public {
        provider = LendingPoolAddressesProvider(_provider);
        dai = _dai;
    }
    
    function startLoan(uint _amount, bytes calldata _params) external {
        LendingPool lendingPool = provider.getLendingPool();
        lendingPool.flashLoan(address(this), dai, amount, _params);
    }
    
    function executeOperation(address _reserve, uint _amount, uint _fee, bytes memory _params) external {
        //TODO: arbitrage, finance, whatever...
        transferFundsBackToPoolInternal(_reserve, amount + fee);
        
    }
}
