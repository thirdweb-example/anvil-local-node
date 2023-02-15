import {
  useContract,
  Web3Button,
  useAddress,
  useOwnedNFTs,
  ThirdwebNftMedia,
  useNFTs,
} from "@thirdweb-dev/react";
import type { NextPage } from "next";
import styles from "../styles/Home.module.css";
import { evolveContract } from "../utils/constants";
import { BigNumber } from "ethers";

const Home: NextPage = () => {
  // Currently connected wallet address
  const address = useAddress();
  const { contract } = useContract(evolveContract);

  const { data: nfts, isLoading } = useNFTs(contract, { start: 0, count: 100 });

  // Hook to check if the user has any NFT(s)
  const { data: ownedNfts, isLoading: nftsLoading } = useOwnedNFTs(
    contract,
    address
  );

  return (
    <div className={styles.outerContainer}>
      <div className={styles.nftCollection}>
        {address ? (
          !nftsLoading && nfts ? (
            nfts.map((nft) => (
              <div
                className={styles.nftContainer}
                key={nft.metadata.id.toString()}
              >
                <ThirdwebNftMedia metadata={nft.metadata} height={"330px"} />
                <div className={styles.descriptionContainer}>
                  <h2 key={nft.metadata.id.toString()}>
                    {nft?.metadata?.name?.toString()}
                  </h2>
                  <div className={styles.quantityContainer}>
                    <h3>Quantity:</h3>
                    <div className={styles.quantity}>
                      {ownedNfts?.find(
                        (ownedNft) => ownedNft.metadata.id === nft.metadata.id
                      ) ? (
                        <p>
                          {
                            ownedNfts?.find(
                              (ownedNft) =>
                                ownedNft.metadata.id === nft.metadata.id
                            )?.quantityOwned
                          }
                        </p>
                      ) : (
                        <p>0</p>
                      )}
                    </div>
                  </div>
                </div>
                {ownedNfts?.find(
                  (ownedNft) => ownedNft.metadata.id === nft.metadata.id
                ) && (
                  <div className={styles.btnHero}>
                    <Web3Button
                      contractAddress={evolveContract}
                      action={(contract) => {
                        console.log(nft.metadata.id);
                        return contract.call(
                          "evolve",
                          BigNumber.from(nft.metadata.id)
                        );
                      }}
                    >
                      Evolve your {nft?.metadata?.name?.toString()}
                    </Web3Button>
                  </div>
                )}
              </div>
            ))
          ) : nftsLoading ? (
            <div>
              <h1>Loading ...</h1>
            </div>
          ) : (
            <div>
              <h1>you don't own any NFTs</h1>
            </div>
          )
        ) : (
          <div>
            <h1>Please connect your wallet</h1>
          </div>
        )}
      </div>
      <div className={styles.btnHero}>
        <Web3Button
          contractAddress={evolveContract}
          action={(contract) => contract.erc1155.claim(0, 1)}
        >
          Mint an NFT!
        </Web3Button>
      </div>
    </div>
  );
};

export default Home;
