# Scriptory

A decentralized platform for writers, researchers, and knowledge workers to publish, validate, and monetize intellectual content — with on-chain authorship, peer review, and fair compensation.

---

## Overview

Scriptory consists of ten modular smart contracts that together create a transparent, reputation-driven, and censorship-resistant network for publishing and reviewing long-form content:

1. **Author Registry Contract** – Verifies and manages author identities and credentials.
2. **Manuscript Contract** – Mints long-form content as versioned NFTs with on-chain metadata.
3. **Review Circle Contract** – Facilitates small DAOs that peer-review and endorse content.
4. **Engagement Contract** – Records interactions like likes, comments, and shares.
5. **Reputation Contract** – Calculates and updates author and reviewer reputations based on activity and feedback.
6. **Subscription Contract** – Manages paid subscriptions to authors or content categories.
7. **Curation Board Contract** – Enables creation of themed content boards by trusted curators.
8. **Appeals Contract** – Handles disputes related to content reviews or moderation.
9. **Bounty Contract** – Allows users or organizations to post paid requests for specific content.
10. **Patronage Contract** – Enables long-term, ad-free support relationships between readers and authors.

---

## Features

- **Immutable content ownership** with NFT-based manuscripts  
- **Expert peer-review system** via small Review Circles  
- **Transparent reputation** tied to on-chain contribution  
- **Micro-monetization** through tips, subscriptions, and bounties  
- **Reader-curated collections** with token-based incentives  
- **Dispute resolution** with decentralized arbitration  
- **Support for long-form intellectual content**, not just viral media  

---

## Smart Contracts

### Author Registry Contract
- Register unique author profiles tied to Stacks addresses  
- Optional DID or proof-of-credential integration  
- Role management for writers, reviewers, and curators  

### Manuscript Contract
- Mint content NFTs with title, abstract, and IPFS/Arweave content hash  
- Track version history and author attribution  
- Link to citations or related works  

### Review Circle Contract
- DAO-like review groups based on topic domains  
- Peer endorsements, review rewards, and badge issuance  
- Reputation-boosting or slashing based on review quality  

### Engagement Contract
- Log likes, shares, and comment metadata  
- Optionally weighted by user reputation  
- Trigger micro-rewards for popular content  

### Reputation Contract
- Assign and update reputation scores based on activity  
- Non-transferable reputation tokens  
- Penalize spammy or low-quality interactions  

### Subscription Contract
- Readers can subscribe to authors or topics with tokens  
- Monthly recurring payments and reward splitting  
- Subscriber-only content access  

### Curation Board Contract
- Create public or private content boards  
- Token-gated access for curators  
- Revenue-sharing based on board engagement  

### Appeals Contract
- File and arbitrate disputes over moderation decisions  
- Community voting with reputation-weighted stakes  
- Escrow and slashing mechanisms for fairness  

### Bounty Contract
- Post paid requests for essays, research, or analyses  
- Winner chosen by bounty creator or DAO  
- Automated payout on completion  

### Patronage Contract
- Long-term support relationships with custom tiers  
- No middlemen, no ads  
- Exclusive rewards or content for patrons  

---

## Installation

1. Install [Clarinet CLI](https://docs.hiro.so/clarinet/getting-started)  
2. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/scriptory.git
   ```
3. Run tests:
    ```bash
    npm test
    ```
4. Deploy contracts:
    ```bash
    clarinet deploy
    ```

## Usage

Each smart contract operates as an independent module with clear responsibilities. For full functionality, integrate multiple contracts into your front-end app or protocol.

Refer to each contract’s documentation (contracts/) for usage examples, parameters, and return types.

## License

MIT License