const { ethers } = require("ethers");

// Define the ABI of the constructor
const abi = ["constructor(address _collection)"];

// Address to encode
const address = "0x0000000000000000000000000000000000000000";

// Create a new interface for encoding
const iface = new ethers.Interface(abi);

// Encode the constructor arguments
const encodedArgs = iface.encodeDeploy([address]);

console.log(encodedArgs);
