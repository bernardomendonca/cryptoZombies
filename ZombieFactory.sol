pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // event to listen to, when creating new zombie:
    event NewZombie(uint zombieId, string name, uint dna);

    // The Zombie DNA will have 16 digits, and each 2 digits correspond to one feature.
    // In Solidity, uint is actually an alias for uint256, a 256-bit unsigned integer. 
    uint dnaDigits = 16;

    // To make sure our Zombie's DNA is only 16 characters, 
    // We'll have an uint equal to 10^16. 
    // That way we can later use the modulus operator % to shorten an integer to 16 digits.
    uint dnaModulus = 10 ** dnaDigits;

    // Each zombie will have a struct containing their name, and their dna
    struct Zombie {
        string name;
        uint dna;
    }

    // There will be an array of public zombies
    Zombies[] public zombies;

    // mappings
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    // private function to create zombies:
    function _createZombie (string memory _name, uint _dna) internal {
        //create new zombie
        //push to the zombies array
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        // firing up the "NewZombie" event:
        emit NewZombie(id, _name, _dna);
    }

    // private function to generate the zombie's DNA:
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // public function to create a Zombie:
    function createRandomZombie(string memory _name) public {
        // This function should only be called once per user
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
       _createZombie(_name, randDna);
    }

}