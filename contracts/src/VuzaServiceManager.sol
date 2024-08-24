// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "@eigenlayer/contracts/libraries/BytesLib.sol";
import "@eigenlayer/contracts/core/AVSDirectory.sol";
import "@eigenlayer/contracts/core/DelegationManager.sol";
import "@eigenlayer-middleware/src/ServiceManagerBase.sol";

contract VuzaServiceManager is ServiceManagerBase {
    using BytesLib for bytes;

    IDelegationManager public delegationManager;

    constructor(
        IAVSDirectory _avsDirectory,
        IRegistryCoordinator _registryCoordinator,
        IStakeRegistry _stakeRegistry,
        IDelegationManager _delegationManager
        // address owner
    )
        ServiceManagerBase(
            _avsDirectory,
            _registryCoordinator,
            _stakeRegistry
        )
    {
        // _transferOwnership(owner);
       delegationManager = IDelegationManager(_delegationManager);
    }

    // function initialize(address initialOwner) external initializer {
    //     __ServiceManagerBase_init(initialOwner);  // Initialize with the owner
    // }
         /**
     * @notice Updates the metadata URI for the AVS
     * @param _metadataURI is the metadata URI for the AVS
     * @dev only callable by the owner
     */
    function updateAVSMetadataURI(string memory _metadataURI) public override virtual onlyOwner {
        _avsDirectory.updateAVSMetadataURI(_metadataURI);
    }

    function initialize(
        address initialOwner
    ) external {
        _transferOwnership(initialOwner);
        // updateAVSMetadataURI("https://raw.githubusercontent.com/CollinsMunene/eza_finance_ot_avs/master/metadata.json");
    }

    // function updateAVSMetadataURI(string memory _metadataURI) public override {
    //     super.updateAVSMetadataURI(_metadataURI);
    // }

}
