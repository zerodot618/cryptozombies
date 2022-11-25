// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ZombieFeeding.sol";

contract ZombieHelper is ZombieFeeding {
    // aboveLevel check zombie's level
    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }
}
