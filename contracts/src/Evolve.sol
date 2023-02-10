// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// thirdweb ContractKit - Building blocks for common smart contract patterns (some examples below)
import "@thirdweb-dev/contracts/base/ERC1155LazyMint.sol";
import "@thirdweb-dev/contracts/extension/Permissions.sol"; // Extension contracts

// OpenZeppelin Contracts - More building blocks and utility functions (some examples below)
import "@openzeppelin/contracts/utils/math/Math.sol";

contract Evolve is ERC1155LazyMint, Permissions {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error InsufficientBalance(uint256 _tokenId, uint256 requiredBalance);
    error OnlyFirstLevelClaimable();
    error NoHigherLevel(uint256 _tokenId);

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    event NFTBurned(uint256 _tokenId, uint256 _amount);
    event NFTEvolved(address _reciever, uint256 _tokenId);

    // Constructor - run when contract is deployed
    constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    ) ERC1155LazyMint(_name, _symbol, _royaltyRecipient, _royaltyBps) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function verifyClaim(
        address _claimer,
        uint256 _tokenId,
        uint256 _quantity
    ) public view override {
        // Check if the claimer has the access key
        if (_tokenId != 0) revert OnlyFirstLevelClaimable();
    }

    function evolve(uint256 _tokenId) public {
        if (nextTokenIdToMint() <= _tokenId + 1) revert NoHigherLevel(_tokenId);
        uint256 _requiredBalance = Math.log2((_tokenId + 1) * 100);
        if (balanceOf[msg.sender][_tokenId] < _requiredBalance)
            revert InsufficientBalance(_tokenId, _requiredBalance);
        _burn(msg.sender, _tokenId, _requiredBalance);
        emit NFTBurned(_tokenId, _requiredBalance);
        _mint(msg.sender, _tokenId + 1, 1, "");
        emit NFTEvolved(msg.sender, _tokenId + 1);
    }

    function requiredNFTAmount(uint256 _tokenId)
        public
        pure
        returns (uint256 _requiredNFTAmount)
    {
        _requiredNFTAmount = Math.log2((_tokenId + 1) * 100);
    }
}
