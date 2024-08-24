// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@eigenlayer/contracts/libraries/BytesLib.sol";
import "@eigenlayer/contracts/core/DelegationManager.sol";
import "@eigenlayer-middleware/src/ServiceManagerBase.sol";
import "@eigenlayer-middleware/src/StakeRegistry.sol";
import "@eigenlayer/contracts/permissions/Pausable.sol";
import {IRegistryCoordinator} from "@eigenlayer-middleware/src/interfaces/IRegistryCoordinator.sol";

contract Main is  Initializable,
    OwnableUpgradeable,
    Pausable {

    IDelegationManager public delegationManager;

    function initialize(
        address initialOwner
    ) public initializer {
        _transferOwnership(initialOwner);
    }

    // Override all conflicting functions and specify which base contract's implementation to use
    function owner() public view override(OwnableUpgradeable) returns (address) {
        return OwnableUpgradeable.owner();
    }

    function transferOwnership(address newOwner) public override(OwnableUpgradeable) onlyOwner {
        OwnableUpgradeable.transferOwnership(newOwner);
    }

    function renounceOwnership() public override(OwnableUpgradeable) onlyOwner {
        OwnableUpgradeable.renounceOwnership();
    }

    function _checkOwner() internal view override(OwnableUpgradeable) {
        OwnableUpgradeable._checkOwner();
    }

    function _transferOwnership(address newOwner) internal override(OwnableUpgradeable) {
        OwnableUpgradeable._transferOwnership(newOwner);
    }

    function getOperatorDetails(address operator) public view returns (IDelegationManager.OperatorDetails memory) {
        return delegationManager.operatorDetails(operator);
    }

    function checkIsDelegated(address staker) public view returns (bool) {
        return delegationManager.isDelegated(staker);
    }

    function checkIsOperator(address operator) public view returns (bool) {
        return delegationManager.isOperator(operator);
    }

}
