# Foundry Local Node - Anvil 

Deploy your smart contracts using Anvil to a local node & use the thirdweb SDK to interact with them.

In this template, we go through the motions of creating a custom contract using thirdweb's [ContractKit](https://thirdweb.com/contractkit) & then integrating it into a front-end using the thirdweb [React SDK](https://thirdweb.com/sdk). We use Foundry's Anvil to test our smart contract & front-end by deploying to a local node, using the power of thirdweb Any Chain.

## Using this repository

### Pre-requisites 

- Git
- [Foundry](https://book.getfoundry.sh/)
- yarn
- npm

### Getting Started

Create a local instance of this repository by running the commands:

```bash
npx thirdweb create --template anvil-local-node
cd anvil-local-node
```

Then install all of the contract dependencies by running:

```bash
cd contracts
foundryup && forge clean && forge install
```

### Testing 

Run the tests:

```bash
forge test
```

### Deploying your Contract 

In a new terminal tab, start an instance of Anvil - the local node tool that ships with foundry. In order to be compatible with the thirdweb local node configuration, we will specify a chain-d of 1337 rather than the default (which is 31337) using the command:

```bash
anvil --chain-id 1337
```

This will print a list of addresses, that have funds that you can use for testing, to your terminal. Copy one of these addresses and add to your browser wallet (e.g. MetaMask)

Deploy your burn-to-evolve contract using thirdweb Deploy:

```bash
npx thirdweb deploy
```

Select `Evolve` as the contract to deploy.

This will bring up a deployment UI for you to fill out the constructor parameters. Ensure that your newly imported Anvil wallet address is connected to the site on Localhost:8545 and select `LocalHost` as your Network/Chain. 

Finally, click `Deploy Now` which will trigger a transaction to sign to deploy the contract & a message to sign (this step is gassless) to add the contract to your wallet address' Dashboard.

### Using the App Template

From inside the `app` directory run

```bash
yarn 
```

To install dependencies. To run a local, development instance of your app, run:

```bash
yarn dev
```

which will bring up a browser tab for your to view your app!

### Configuring Your App to LocalHost

This project's app is already configured to use LocalHost but it is important to understand how this is done. Inside `app/pages/_app.tsx` you will be able to see the following code:

```tsx
import type { AppProps } from "next/app";
import { ChainId, ThirdwebProvider } from "@thirdweb-dev/react";
import "../styles/globals.css";
import Head from "next/head";

// This is the chainId your dApp will work on.
const activeChainId = ChainId.Localhost;

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <ThirdwebProvider desiredChainId={activeChainId}>
      <Head>
        <title>thirdweb NFT Burn to Evolve Customizable Page</title>
      </Head>
      <Component {...pageProps} />
    </ThirdwebProvider>
  );
}

export default MyApp;
```

here, you can see that we set the `desiredChainId` to `ChainId.Localhost` - this allows you to use your local node for testing! Should you deploy your contract to a testnet or mainnet e.g. Goerli, this will need to be changed to e.g. `ChainId.Goerli`. 

## Join our Discord!

For any questions or suggestions, join our discord at [https://discord.gg/thirdweb](https://discord.gg/thirdweb).
