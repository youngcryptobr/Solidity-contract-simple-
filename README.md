This Solidity contract creates a simple cryptocurrency using the Ethereum blockchain. It defines a token contract called MyToken with a few key attributes. The name, symbol, and totalSupply variables define the basic information about the token. The balanceOf mapping tracks the token balances of all accounts.

The constructor function sets the initial values for the name, symbol, totalSupply, and also initializes the balanceOf mapping to assign the total supply to the contract creator's account.

The transfer function allows token holders to transfer their tokens to another account. It first checks that the sender has enough tokens to make the transfer and then updates the balanceOf mapping for both the sender and recipient.

This contract is a very basic example of how a cryptocurrency can be created using Solidity. In a real-world scenario, a cryptocurrency contract would likely have many more features and functions to support things like transaction fees, token creation limits, and more.
