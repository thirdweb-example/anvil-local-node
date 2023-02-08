import hre, { ethers } from "hardhat";
import { TWRegistry } from "typechain";
import { AddedEvent } from "typechain/contracts/TWRegistry";

//  ====================================

// REPLACE according to desired date range.
const startBlock: number = 0;
const endBlock: number = 0;

// REPLACE
const deployer: string = "0x38abaC1B42ebC9429CB3c9E242dee5eA1104be5d";

async function main() {

    const chainId: number = hre.network.config.chainId as number;
    console.log(`\nGetting the number of pre-built contracts deployed:\nChain: ${chainId}\nStart block: ${startBlock}  End block: ${endBlock}\nDeployer: ${deployer}`)
    
    const twRegistry: TWRegistry = await ethers.getContractAt("TWRegistry", "0x7c487845f98938Bb955B1D5AD069d9a30e4131fd");

    const filter = twRegistry.filters.Added(deployer);
    let events: AddedEvent[];

    if(!startBlock && !endBlock) {
      events = await twRegistry.queryFilter(filter);
    } else if (!endBlock) {
      events = await twRegistry.queryFilter(filter, startBlock);
    } else {
      events = await twRegistry.queryFilter(filter, startBlock, endBlock);
    }

    console.log("Total deploys by deployer: ", events.length);
    console.log("Deployment addresses: ", events.map(x => x.args.deployment));
}

main()
  .then(() => process.exit(0))
  .catch(e => {
    console.error(e);
    process.exit(1);
  });