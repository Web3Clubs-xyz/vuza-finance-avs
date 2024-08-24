// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@eigenlayer/contracts/libraries/BytesLib.sol";
import "@eigenlayer/contracts/core/DelegationManager.sol";
import "@eigenlayer-middleware/src/ServiceManagerBase.sol";
import "@eigenlayer-middleware/src/StakeRegistry.sol";
import "@eigenlayer/contracts/permissions/Pausable.sol";
import {IRegistryCoordinator} from "@eigenlayer-middleware/src/interfaces/IRegistryCoordinator.sol";
import {VuzaServiceManager} from "../src/VuzaServiceManager.sol";
import {Main} from "../src/Main.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract Deploy is Script {
    function run() external {
        // Load private key from environment variable
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Start broadcasting the transaction
        vm.startBroadcast(deployerPrivateKey);

        // Deploy contracts
        IAVSDirectory avsDirectory = IAVSDirectory(0x055733000064333CaDDbC92763c58BF0192fFeBf); 
        IRegistryCoordinator registryCoordinator = IRegistryCoordinator(0x53012C69A189cfA2D9d29eb6F19B32e0A2EA3490); 
        IStakeRegistry stakeRegistry = IStakeRegistry(0xBDACD5998989Eec814ac7A0f0f6596088AA2a270); 
        IDelegationManager delegationManager = IDelegationManager(0xA44151489861Fe9e3055d95adC98FbD462B948e7);

        address deployer = msg.sender;
        VuzaServiceManager vuzaServiceManager = new VuzaServiceManager(
            avsDirectory,
            registryCoordinator,
            stakeRegistry,
            delegationManager
        );

        Main main = new Main();
        main.initialize(deployer);
        vuzaServiceManager.initialize(deployer);
        vuzaServiceManager.updateAVSMetadataURI("https://raw.githubusercontent.com/CollinsMunene/eza_finance_ot_avs/master/metadata.json");


        // Stop broadcasting the transaction
        vm.stopBroadcast();

        // Log the addresses of the deployed contracts
        console.log("vuzaServiceManager deployed at:", address(vuzaServiceManager));
        console.log("Main contract deployed at:", address(main));
    }
}
