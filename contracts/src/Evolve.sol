// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// thirdweb ContractKit - Building blocks for common smart contract patterns (some examples below)
import "@thirdweb-dev/contracts/base/ERC1155LazyMint.sol";
import "@thirdweb-dev/contracts/extension/Permissions.sol"; // Extension contracts

contract Evolve is ERC1155LazyMint, Permissions {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error InsufficientBalance(uint256 _tokenId);
    error OnlyFirstLevelClaimable();
    error NoHigherLevel(uint256 _tokenId);

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    event NFTBurned(uint256 indexed _tokenId, uint256 _amount);
    event NFTEvolved(address indexed _reciever, uint256 indexed _tokenId);

    // Constructor - run when contract is deployed
    constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    ) ERC1155LazyMint(_name, _symbol, _royaltyRecipient, _royaltyBps) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /**
     * @notice Only allow claiming the first level NFT with tokenId 0
     * @param _claimer address attempting to claim
     * @param _tokenId the NFT token Id
     * @param _quantity amount of NFTs being claimed
     */
    function verifyClaim(
        address _claimer,
        uint256 _tokenId,
        uint256 _quantity
    ) public pure override {
        // Check if the claimer has the access key
        if (_tokenId != 0) revert OnlyFirstLevelClaimable();
    }

    /**
     * @notice Evolve the NFT by minting the next levels & burning the current level NFT
     * @param _tokenId the NFT token Id being evolved
     */
    function evolve(uint256 _tokenId) public {
        if (_tokenId >= nextTokenIdToMint() - 1) revert NoHigherLevel(_tokenId);
        if (balanceOf[msg.sender][_tokenId] < 1)
            revert InsufficientBalance(_tokenId);
        _burn(msg.sender, _tokenId, 1);
        emit NFTBurned(_tokenId, 1);
        _mint(msg.sender, _tokenId + 1, 1, "");
        emit NFTEvolved(msg.sender, _tokenId);
    }
}
