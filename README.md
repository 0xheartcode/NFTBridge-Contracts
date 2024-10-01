# NFTBridge

A cross-chain NFT bridge implementation allowing seamless transfer of ERC1155 tokens between Ethereum and NETWORK blockchain.

## Architecture

This project implements a one-way bridge for ERC1155 tokens with the following components:

- **OpenSeaNFT.sol**: Ethereum-side ERC1155 contract with four media token types
- **NFTBridge.sol**: Ethereum-side bridge contract that locks tokens by transferring to a dead address
- **NETWORK1155.sol**: NETWORK-side ERC1155 contract with corresponding tokens

### How It Works

1. Users approve the Bridge contract to transfer their tokens
2. When bridging, tokens are locked on Ethereum by sending to a dead address
3. The NETWORK-side contract pre-mints all tokens, which are released by admins

## Contract Addresses - **Testnet**

ETH 1155: ```0x0000000000000000000000000000000000000000```

Ethereum Bridge: ```0x0000000000000000000000000000000000000000```

NETWORK 1155: ```0x0000000000000000000000000000000000000000```

## Recent Updates

**Bridge Contract**
- `lock` function now takes an additional parameter "to" for users to provide the address to send NFTs to on NETWORK side

**ERC1155 NETWORK**
- `addAdmin` function now gives approval to move all NFTs upon adding, and removes approval when admin privileges are removed

**1155 Contracts**
- Imported Strings Library
- Deployed on Sepolia testnet
- Updated contract addresses on server

## Development

### Prerequisites

- [Foundry](https://getfoundry.sh/)
- Node.js and npm

### Installation

```bash
# Clone the repository
git clone https://github.com/0xheartcode/NFTBridge.git
cd NFTBridge

# Install dependencies
forge install
npm install
```

### Compile

```bash
forge build
```

### Testing

```bash
# Set RPC URL for testing
export RPC_URL=https://sepolia.infura.io/v3/YOUR_API_KEY

# Run tests
forge test
```

## Token Identifiers

### Ethereum Chain (OpenSeaNFT)
- mediathree: 33
- mediafour: 44
- mediatwo: 22
- mediaone: 11

### NETWORK Chain (NETWORK1155)
- mediathree: 0
- mediafour: 1
- mediatwo: 2
- mediaone: 3

## Usage

### Bridging Tokens from Ethereum to NETWORK

1. Approve the Bridge contract to move your tokens:
```solidity
// Approve bridge to transfer tokens
OpenSeaNFT.setApprovalForAll(bridgeAddress, true);
```

2. Call the lock function with the destination address and token amounts:
```solidity
// Bridge tokens to NETWORK
NFTBridge.lock(destinationAddress, mediathreeAmount, mediafourAmount, mediatwoAmount, mediaoneAmount);
```

### Administrative Functions on NETWORK Chain

```solidity
// Add or remove an admin
NETWORK1155.addAdmin(address, isAdmin);

// Mint tokens to a user (admin only)
NETWORK1155.mint(userAddress, tokenIds, amounts);
```

## License

This project is licensed under the UNLICENSED License.
