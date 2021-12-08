pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

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

    // private function to create zombies:
    function _createZombie (string memory _name, uint _dna) private {
        //create new zombie
        //push to the zombies array
        zombies.push(Zombie(_name, _dna));
    }

    // private function to generate the zombie's DNA:
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

}