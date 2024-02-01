// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DegenLisa is ERC721 {
    uint256 currentTokenId = 0;
    mapping(address => bool) public hasMinted;
    address royaltyReceiver; 
    constructor() ERC721("Degen Mona Lisa", "Degen Mona Lisa") {
        royaltyReceiver=msg.sender;
    }

    function mint() public {
        require(!hasMinted[msg.sender], "You have already minted an NFT.");
        ++currentTokenId;
        _mint(msg.sender, currentTokenId);
        hasMinted[msg.sender] = true;
    }

 function tokenURI(uint256 tokenId) public pure override returns (string memory) {
    // Every 10th NFT 
    if (tokenId % 10 == 0) {
        return "https://bafkreif7zy64fask5kl7krraijkkythjn5lcerzkvb3tbwwyryx7jjdcdu.ipfs.nftstorage.link";
    } else if (tokenId % 4 == 0) {
        // Every 5th NFT is some other type
        return "https://bafkreicwnltaxbqo6hwkqz5ptvizwch3urxu3rvqg7mmtlkyvynuqvh444.ipfs.nftstorage.link";
    } else if (tokenId % 3 == 0) {
        // Every 3rd NFT is Mona Lisa Holding her Hards Close to her Heart
        return "https://bafkreieiguvxlgxk6b4nnf7rmxyjoivzsdqroqgu4ubdi6chua7reo3uhu.ipfs.nftstorage.link";
    } else {
        // All other NFTS are Degen Mona Lisa
        return "https://bafkreiez3updzwhgqexlfx5tsd76b3cmtqoccuhmu4jxpbju6doeg74v6q.ipfs.nftstorage.link";
    }
}
}
