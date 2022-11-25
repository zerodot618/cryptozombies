// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ZombieFeeding.sol";

contract ZombieHelper is ZombieFeeding {
    // aboveLevel check zombie's level
    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    // changeName change Zombie's name when it's level greater or equal 2
    function changeName(uint256 _zombieId, string calldata _newName)
        external
        aboveLevel(2, _zombieId)
    {
        require(zombieToOwner[_zombieId] == msg.sender);
        zombies[_zombieId].name = _newName;
    }

    // changeDna change Zombie's dna when it's level greater or equal 20
    function changeDna(uint256 _zombieId, uint256 calldata _newDna)
        external
        aboveLevel(20, _zombieId)
    {
        require(zombieToOwner[_zombieId] == msg.sender);
        zombies[_zombieId].dna = _newDna;
    }
}
