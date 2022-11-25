// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ZombieFactory.sol";

interface KittyInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

contract ZombieFeeding is ZombieFactory {
    // really CryptoKitties contract address
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // initialze kittyContract from cdAdderss
    KittyInterface kittyContract = KittyInterface(ckAddress);

    // feedAndMultiply _zombieId's zombie feed lifeform's dna
    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;

        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        // If _species is `kitty`,then newDna ends with 99
        // Assume newDna is 334455, then newDna % 100 is 55,
        // so newDna - newDna % 100 is 334400, finally add 99 to get 334499
        if (
            keccak256(abi.encodePacked(_species)) ==
            keccak256(abi.encodePacked("kitty"))
        ) {
            newDna = newDna - (newDna % 100) + 99;
        }
        _createZombie("NoName", newDna);
    }

    // feedOnKitty interact with CryptoKitties Contract
    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
