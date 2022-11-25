// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {
    // feedAndMultiply _zombieId's zombie feed lifeform's dna
    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
    }
}
