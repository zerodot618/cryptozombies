// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {
    // feedAndMultiply _zombieId's zombie feed lifeform's dna
    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna)
        public
        view
    {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;

        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}
