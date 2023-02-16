// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/Evolve.sol";

contract EvolveTest is Test {
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
    event TokensClaimed(
        address indexed claimer,
        address indexed receiver,
        uint256 indexed tokenId,
        uint256 quantityClaimed
    );

    Evolve public evolve;
    address claimer;

    function setUp() public {
        evolve = new Evolve("Evolve", "EVO", address(this), 0);
        claimer = makeAddr("claimer");
        // amount = 100 * 10**evolve.decimals();

        // Lazy mint 3 ERC1155 token "levels"
        vm.startPrank(address(this));
        evolve.lazyMint(1, "level_1", "");
        evolve.lazyMint(1, "level_2", "");
        evolve.lazyMint(1, "level_3", "");
        vm.stopPrank();
    }

    function test_claimTokenIdZero(uint256 quantity) public {
        vm.assume(quantity > 0);
        vm.startPrank(claimer);
        vm.expectEmit(true, true, true, true);
        emit TokensClaimed(claimer, claimer, 0, quantity);
        evolve.claim(claimer, 0, quantity);
        vm.stopPrank();
        assertEq(evolve.balanceOf(claimer, 0), quantity);
    }

    // fuzz test to test that tokenId != 0 is not claimable
    function testclaimTokenIdNotZero(uint256 tokenId, uint256 quantity) public {
        vm.assume(quantity > 0);
        vm.assume(tokenId > 0);
        vm.assume(tokenId < evolve.nextTokenIdToMint());
        vm.startPrank(claimer);
        vm.expectRevert(abi.encodeWithSignature("OnlyFirstLevelClaimable()"));
        evolve.claim(claimer, tokenId, quantity);
        vm.stopPrank();
    }

    function test_evolveWithPrevToken() public {
        vm.startPrank(claimer);
        evolve.claim(claimer, 0, 1);
        for (uint256 id = 0; id < evolve.nextTokenIdToMint() - 1; id++) {
            vm.expectEmit(true, false, false, true);
            emit NFTBurned(id, 1);
            vm.expectEmit(true, true, false, false);
            emit NFTEvolved(claimer, id);
            evolve.evolve(id);
            assertEq(evolve.balanceOf(claimer, id), 0);
            assertEq(evolve.balanceOf(claimer, id + 1), 1);
        }
        vm.stopPrank();
    }

    function test_evolveWithoutPrevToken(uint256 tokenId) public {
        vm.assume(tokenId < evolve.nextTokenIdToMint() - 1);
        vm.startPrank(claimer);
        vm.expectRevert(
            abi.encodeWithSignature("InsufficientBalance(uint256)", tokenId)
        );
        evolve.evolve(tokenId);
    }

    function test_evolveHigherTokenId() public {
        vm.startPrank(claimer);
        uint256 tokenId = evolve.nextTokenIdToMint() - 1;
        evolve.claim(claimer, 0, 1);
        for (uint256 id = 0; id < tokenId; id++) {
            evolve.evolve(id);
        }
        vm.expectRevert(
            abi.encodeWithSignature("NoHigherLevel(uint256)", tokenId)
        );
        evolve.evolve(tokenId);
        vm.stopPrank();
    }
}
