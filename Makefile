# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes
test   :; forge test -vvv --rpc-url=${ETH_RPC_URL} --fork-block-number ${BLOCK_NUMBER}
trace   :; forge test -vvvv --rpc-url=${ETH_RPC_URL} --fork-block-number ${BLOCK_NUMBER}
clean  :; forge clean
snapshot :; forge snapshot

# utils
download :; ETHERSCAN_API_KEY=${ETHERSCAN_API_KEY} cast etherscan-source -d src/etherscan/${address} ${address} 
rinkeby-download :; ETHERSCAN_API_KEY=${ETHERSCAN_API_KEY} cast etherscan-source -c rinkeby -d src/etherscan/${address} ${address} 

# deploy
rinkeby-deploy :; forge script script/RedeemFeiPayload.s.sol:RedeemFeiDeployScript --rpc-url=${RINKEBY_RPC_URL} --private-key ${PRIVATE_KEY} --broadcast --verify

deploy :;  forge script script/RedeemFeiPayload.s.sol:RedeemFeiDeployScript --rpc-url=${ETH_RPC_URL} --ledger --sender 0xde30040413b26d7aa2b6fc4761d80eb35dcf97ad --broadcast --verify

submit :;  forge script script/RedeemFeiSubmission.s.sol:FeiRedeemSubmitScript --rpc-url=${ETH_RPC_URL} --private-key ${PRIVATE_KEY} --broadcast

verify :; forge verify-contract --compiler-version 0.8.11 0xE0F926b45A68514FaE901b9F07201Ce5F9AaF7c7 ./src/AFeiToDaiSwapper.sol:AFeiToDaiSwapper --watch