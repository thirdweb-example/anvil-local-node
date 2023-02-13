import type { AppProps } from "next/app";
import { ChainId, ThirdwebProvider } from "@thirdweb-dev/react";
import "../styles/globals.css";
import Head from "next/head";
import ThirdwebGuideFooter from "../components/GitHubLink";

// This is the chainId your dApp will work on.
const activeChainId = ChainId.Localhost;

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <ThirdwebProvider desiredChainId={activeChainId}>
      <Head>
        <title>thirdweb NFT Drop Minting Customizable Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta
          name="description"
          content="Learn How To Use thirdweb's ERC1155 Lazy Mint contract and extend to create burn to evolve functionality"
        />
        <meta
          name="keywords"
          content="thirdweb, thirdweb ERC1155 NFT drop, how to make thirdweb nft drop"
        />
      </Head>
      <Component {...pageProps} />
      <ThirdwebGuideFooter />
    </ThirdwebProvider>
  );
}

export default MyApp;
