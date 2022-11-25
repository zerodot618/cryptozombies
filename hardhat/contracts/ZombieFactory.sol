// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ZombieFactory {
    // zombie's dna length
    uint256 dnaDigits = 16;
    // shorten an interger to 16 digits
    uint256 dnaModulus = 10**dnaDigits;

    // zombile struct
    struct Zombie {
        string name;
        uint256 dna;
    }

    // zombile collection
    Zombie[] public zombies;

    // createRandomZombie: randon create a zombie
    function createRandomZombie(string memory _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

    // _createZombie: create a zombie
    function _createZombie(string memory _name, uint256 _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    // _genetateRandomDna: take one string parameter, return a uint dna
    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }
}
