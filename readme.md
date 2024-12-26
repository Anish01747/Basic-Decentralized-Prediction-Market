# 🔮 Basic Decentralized Prediction Market

## Project Overview

A simple, transparent blockchain-based prediction market that allows users to create events, place bets, and claim rewards based on event outcomes.

## 🌟 Project Features

### Smart Contract Capabilities
- Event creation with custom duration
- Binary (YES/NO) prediction mechanism
- Stake-based betting
- Proportional reward distribution
- Event resolution functionality

### Frontend Functionality
- Wallet connection with MetaMask
- Create prediction events
- View available events
- Place bets on events
- Resolve events
- Claim rewards

## 🛠 Technical Stack

- **Blockchain**: Ethereum
- **Smart Contract Language**: Solidity ^0.8.0
- **Frontend**: HTML, CSS, JavaScript
- **Blockchain Interaction**: Web3.js
- **Wallet Integration**: MetaMask

## 🚀 How It Works

1. **Event Creation**
   - Users pay a small fee to create a prediction event
   - Set event description and duration
   - Event becomes available for betting

2. **Betting**
   - Users can place bets on YES or NO outcomes
   - Stake any amount of cryptocurrency
   - Bets tracked proportionally

3. **Resolution**
   - Event can be resolved after its end time
   - Outcome determined by event creator
   - Rewards distributed to correct predictors

## 📦 Contract Functions

- `createEvent()`: Create a new prediction event
- `placeBet()`: Place a stake on an event
- `resolveEvent()`: Set the final outcome of an event
- `claimReward()`: Claim rewards for correct predictions
- `getEventDetails()`: Retrieve event information

## 🔧 Setup and Installation

### Prerequisites
- Node.js
- MetaMask Browser Extension
- Ethereum Wallet with Test ETH

### Installation Steps
1. Clone the repository
2. Install dependencies
3. Deploy smart contract to desired network
4. Update contract ABI and address in frontend
5. Open frontend in browser

## 🌐 Deployment Considerations

### Recommended Networks
- Ethereum Sepolia Testnet
- Ethereum Goerli Testnet

### Contract Deployment
- Estimated Deployment Cost: ~0.1 ETH
- Event Creation Fee: 0.01 ETH

## 🚧 Future Improvements

1. Implement Chainlink oracles for decentralized resolution
2. Add multi-option prediction events
3. Develop more robust dispute resolution
4. Create reputation scoring system
5. Enhance frontend with more detailed analytics

## 🔒 Security Considerations

- Minimal smart contract complexity
- Basic access controls
- Time-based event management
- Proportional reward distribution
- Prevents multiple reward claims

## 📝 Limitations

- Binary outcome predictions only
- Manual event resolution
- Limited to Ethereum ecosystem
- Requires manual intervention for complex scenarios

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a pull request

## 📜 License

MIT License

## ⚠️ Disclaimer

This is an experimental project. Participate at your own risk and always conduct thorough research before engaging in any prediction market.

## 💬 Community & Support

- GitHub Discussions
- Discord Channel
- Email Support

---

**Powered by Blockchain Technology**