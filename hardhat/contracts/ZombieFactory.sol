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

    // createZombie: create a zombie
    function createZombie(string memory _name, uint256 dna) public {}
}
