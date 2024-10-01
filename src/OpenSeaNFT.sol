// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract OpenseaNFT is ERC1155, Ownable(msg.sender) {
    // Token IDs
    uint256 public constant mediathree =
        33;
    uint256 public constant mediafour =
        44;
    uint256 public constant mediatwo =
        22;
    uint256 public constant mediaone =
        11;

    // Base URI
    string private _baseURI =
        "https://network-server-production.up.railway.app/metadata/";

    constructor()
        ERC1155("https://network-server-production.up.railway.app/{id}")
    {}

    /**
     * @dev Function to update the base URI.
     * Only callable by the contract owner.
     */
    function setURI(string memory newURI) external onlyOwner {
        _baseURI = newURI;
    }

    function burn(address account, uint256 id, uint256 amount) public {
        _burn(account, id, amount);
    }

    function mint(address account, uint256 id, uint256 amount) external {
        require(
            id == mediathree || id == mediafour || id == mediatwo || id == mediaone,
            "Invalid token ID"
        );
        _mint(account, id, amount, "");
    }

    function uri(uint256 id) public view override returns (string memory) {
        // Convert token ID to string
        return string(abi.encodePacked(_baseURI, Strings.toString(id)));
    }

  
}
