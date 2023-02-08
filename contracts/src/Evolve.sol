// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

// thirdweb ContractKit - Building blocks for common smart contract patterns (some examples below)
import "@thirdweb-dev/contracts/base/ERC1155LazyMint.sol";
import "@thirdweb-dev/contracts/extension/Permissions.sol"; // Extension contracts

// OpenZeppelin Contracts - More building blocks and utility functions (some examples below)
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Evolve is ERC1155LazyMint, Permissions {
    // Internal state to the contract
    string private greeting;
    // Any `bytes32` value is a valid role. You can create roles by defining them like this.
    bytes32 public constant OWNER = keccak256("owner");
    // Define a variable to store the access key smart contract
    ERC1155LazyMint public accessKeysCollection;

    event NFTEvolved(address reciever, uint256 tokenId, uint256 amount);

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
        if (_tokenId > 0) {
            require(
                balanceOf[_claimer][_tokenId - 1] >= _quantity,
                "Rejected: You do not own the pre-evolved NFT(s)"
            );
        }
    }

    function _transferTokensOnClaim(
        address _receiver,
        uint256 _tokenId,
        uint256 _quantity
    ) internal override {
        if (_tokenId == 0) {
            super._transferTokensOnClaim(_receiver, _tokenId, _quantity);
        } else {
            // First, burn the pre-evolve NFt from the user's wallet
            _burn(
                _receiver, // Burn from the receiver
                _tokenId - 1, // Token ID
                _quantity // Amount to burn is the quantity they are claiming
            );

            // Use the rest of the inherited claim function logic
            super._transferTokensOnClaim(_receiver, _tokenId, _quantity);
            emit NFTEvolved(_receiver, _tokenId, _quantity);
        }
    }
}
