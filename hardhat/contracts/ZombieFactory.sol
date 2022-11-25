// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ZombieFactory {
    // events
    // zombie was created event
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    // state variable
    // zombie's dna length
    uint256 dnaDigits = 16;
    // shorten an interger to 16 digits
    uint256 dnaModulus = 10**dnaDigits;

    // keeps strack of adress that owner has zombie
    mapping(uint256 => address) public zombieToOwner;
    // keeps strack of how many zombies an owner has
    mapping(address => uint256) ownerZombieCount;

    // zombile struct
    struct Zombie {
        string name;
        uint256 dna;
    }

    // zombile collection
    Zombie[] public zombies;

    // createRandomZombie: randon create a zombie
    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

    // _createZombie: create a zombie
    function _createZombie(string memory _name, uint256 _dna) private {
        zombies.push(Zombie(_name, _dna));
        uint256 zombieId = zombies.length - 1;
        zombieToOwner[zombieId] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(zombieId, _name, _dna);
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

contract ZombieFeeding is ZombieFactory {}
