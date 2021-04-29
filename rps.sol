pragma solidity ^0.6.2;

contract RPS {
    
    uint16 winCount = 0;
    uint private randNonce = 0;
    enum gameResult{ WIN, LOSS, TIE }
    gameResult game;
    
    event gameOutcome(string playerPick, string computerPick, gameResult status);
    string playerChoice = "";
    string computerChoice = "";
    //TODO: Pay to play, and pay winner for winning.
    
    function receiveSelection(string memory _playerChoice) public isValidChoice(_playerChoice) {
        playerChoice = _playerChoice;
        generateComputerChoice();
    }
    
    modifier isValidChoice(string memory _playerChoice) {
        
        require(keccak256(bytes(_playerChoice)) == keccak256(bytes('R')) ||
                keccak256(bytes(_playerChoice)) == keccak256(bytes('P')) ||
                keccak256(bytes(_playerChoice)) == keccak256(bytes('S')) ,
                "Your choice is not valid. Please enter R, P, or S."
        );
        _;
    }
    
    function generateComputerChoice() private {
        //basic RNG
        //TODO: Use Oracle for better RNG later
        uint rand = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % 3;
        int8 computerRPS = int8(rand);  
        randNonce++;
        if(computerRPS == 0)
        {
            computerChoice = "R";
        }
        else if(computerRPS == 1)
        {
            computerChoice = "P";
        }
        else if(computerRPS == 2)
        {
            computerChoice = "S";
        }
        determineWinner();
    }
    
    function determineWinner() private {
        
        if((keccak256(bytes(playerChoice)) == keccak256(bytes("R")) && keccak256(bytes(computerChoice)) == keccak256(bytes("S")))
            || (keccak256(bytes(playerChoice)) == keccak256(bytes("S")) && keccak256(bytes(computerChoice)) == keccak256(bytes("P"))) 
            || (keccak256(bytes(playerChoice)) == keccak256(bytes("P")) && keccak256(bytes(computerChoice)) == keccak256(bytes("R"))))
        {
            game = gameResult.WIN;
            winCount++;
        }
        else if(keccak256(bytes(playerChoice)) == keccak256(bytes(computerChoice)))
        {
            game = gameResult.TIE;
        }
        else
        {
            game = gameResult.LOSS;
        }
        
        emit gameOutcome(playerChoice, computerChoice, game);
    }
}
