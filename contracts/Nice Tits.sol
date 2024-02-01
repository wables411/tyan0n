// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


contract DegenLisa is ERC721 {
    uint256 currentTokenId = 0;
    string public defaultURI;

    mapping(address => bool) public hasMinted;
    mapping(address authorizedMinter => bool authorized) public authorizedMinters;
    mapping(uint256 tokenId => string tokenURI) public tokenURIs;
    mapping(uint256 tokenId => bool locked) public lockedTokenURIs;
      uint256 public maxMintPerAddress;
    mapping(address minted => uint256 count) public mintCount;
        event DefaultTokenURISet(string tokenURI);
    event TokenURISet(uint256 indexed tokenId, string tokenURI);
    event TokenURILocked(uint256 indexed tokenId);
    event AuthorizedMinterSet(address indexed minter, bool authorized);
 modifier onlyAuthorizedMinter() {
        require(authorizedMinters[msg.sender], "FrameNFTs: Mint must be triggered by API");
        _;
    }
    
    modifier onlyUnlockedTokenURI(uint256 tokenId) {
        require(!lockedTokenURIs[tokenId], "FrameNFTs: Token URI is locked");
        _;
    }

    modifier onlyBelowMaxMint(address to) {
        require(mintCount[to] < maxMintPerAddress, "FrameNFTs: Max mint reached");
        _;
    }
      function mint(address to, string memory _tokenURI) public onlyAuthorizedMinter onlyBelowMaxMint(to) {
        ++currentTokenId;
        ++mintCount[to];
        tokenURIs[currentTokenId] = _tokenURI;
        _mint(to, currentTokenId);

        emit TokenURISet(currentTokenId, _tokenURI);
    }
  constructor() ERC721("Degen Mona Lisa", "Degen Mona Lisa") {
        // Update this with your own NFT collection's metadata
        defaultURI = "ipfs://bafkreif7zy64fask5kl7krraijkkythjn5lcerzkvb3tbwwyryx7jjdcdu";
        maxMintPerAddress = 1;
               emit AuthorizedMinterSet(msg.sender, true);

        // Authorize Syndicate's API-based wallet pool as a minter on Base
        // Mainnet
        authorizeBaseMainnetSyndicateAPI();
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


// Only the owner can set authorized minters. True = authorized, false =
    // unauthorized
    function setAuthorizedMinter(address minter, bool authorized) public onlyAuthorizedMinter {
        authorizedMinters[minter] = authorized;

        emit AuthorizedMinterSet(minter, authorized);
    }

    // These addresses are for Base Mainnet only. Contact @will on Farcaster
    // or @WillPapper on Telegram if you need other networks
    // If you've set up your own Syndicate account, you can change this function
    // to your own wallet addresses
    function authorizeBaseMainnetSyndicateAPI() internal {
        authorizedMinters[0x3D0263e0101DE2E9070737Df30236867485A5208] = true;
        authorizedMinters[0x98407Cb54D8dc219d8BF04C9018B512dDbB96caB] = true;
        authorizedMinters[0xF43A72c1a41b7361728C83699f69b5280161F0A5] = true;
        authorizedMinters[0x94702712BA81C0D065665B8b0312D87B190EbA37] = true;
        authorizedMinters[0x6e6e3Ac4aBa720Ab576D0f16042A16D6d9b78886] = true;

        emit AuthorizedMinterSet(0x3D0263e0101DE2E9070737Df30236867485A5208, true);
        emit AuthorizedMinterSet(0x98407Cb54D8dc219d8BF04C9018B512dDbB96caB, true);
        emit AuthorizedMinterSet(0xF43A72c1a41b7361728C83699f69b5280161F0A5, true);
        emit AuthorizedMinterSet(0x94702712BA81C0D065665B8b0312D87B190EbA37, true);
        emit AuthorizedMinterSet(0x10FD71C6a3eF8F75d65ab9F3d77c364C321Faeb5, true);
        emit AuthorizedMinterSet(0x6e6e3Ac4aBa720Ab576D0f16042A16D6d9b78886, true);
    }
}
