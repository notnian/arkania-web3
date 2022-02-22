# Hardhat Project

```bash
pnpm install

pnpm exec hardhat compile
pnpm exec hardhat test
pnpm exec hardhat node
pnpm exec hardhat run --network localhost scripts/sample-script.js

# Pour le frontend
cd frontend
pnpm install
pnpm run start
```

Objectifs:
- 10 NFT
- 10% de royalties sur OpenSea
- Metadata sur IPFS
- Prix fixes
- Frontend pour acheter le NFT (via un wallet metamask)

Bonus:

- Split des royalties sur 2 addresses
- Lazy Minting

Pour voir le resultat (Rinkby testnet):

- https://testnets.opensea.io/collection/homework-collectibles
- Metadata (json) ipfs://QmP6Qh2cZemgAtbq7j4eR5gjAGA8mLGKmvRqXcLPr4PTDY
- Metadatas (images) ipfs://QmV3dBLBJsrzhXN3Kv3Dm6S2Yv36PChxoUQ3sRJsb9tmc2
- HomeworkToken contract 0xf4f2fcD073912D08EEDeA09Ac49eEd4F40803364
- https://rinkeby.etherscan.io/address/0xf4f2fcD073912D08EEDeA09Ac49eEd4F40803364
- Royalties contract 0xe6946958D4cC98E8dEcc0A7fACAe8225870CC1B1
- https://rinkeby.etherscan.io/address/0xe6946958D4cC98E8dEcc0A7fACAe8225870CC1B1

Aperçu du frontend

![Frontend](https://raw.githubusercontent.com/notnian/arkania-web3/main/frontend/screenshot-frontend.png)
![Frontend](https://raw.githubusercontent.com/notnian/arkania-web3/main/frontend/screenshot-frontend-bis.png)