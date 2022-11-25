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
    // initialze kittyContract from cdAdderss
    KittyInterface kittyContract;

    // setKittyContractAddress set CryptoKitties Contract address
    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    // feedAndMultiply _zombieId's zombie feed lifeform's dna
    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) internal {
        require(msg.sender == zombieToOwner[_zombieId]);

        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie));

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
        _triggerCooldown(myZombie);
    }

    // feedOnKitty interact with CryptoKitties Contract
    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

    // _triggerCooldown set zombie's readTime's cooldownTIme
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(block.timestamp + cooldownTime);
    }

    // _isReady check if zombie's readTime is over now
    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= block.timestamp);
    }
}
