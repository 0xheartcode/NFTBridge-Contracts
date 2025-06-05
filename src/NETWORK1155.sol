// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NETWORK1155 is ERC1155, Ownable(msg.sender) {
    mapping(address => bool) public isAdmin;

    // Token IDs
    uint256 public constant mediathree = 0;
    uint256 public constant mediafour = 1;
    uint256 public constant mediatwo = 2;
    uint256 public constant mediaone = 3;

    // Base URI
    string private _baseURI = "https://network-server-production.up.railway.app/metadata/";

    // Minting limits
    uint256 public constant MAX_mediathree = 50;
    uint256 public constant MAX_mediafour = 50;
    uint256 public constant MAX_mediatwo = 50;
    uint256 public constant MAX_mediaone = 1;

    modifier onlyAdmin() {
        require(isAdmin[msg.sender], "Unauthorized!");
        _;
    }

    constructor() ERC1155("https://network-server-production.up.railway.app/{id}") {
        addAdmin(msg.sender, true);

        // ALL tokens are minted upon deployment, no more can be minted after this
        _mint(address(this), mediathree, MAX_mediathree, "");
        _mint(address(this), mediafour, MAX_mediafour, "");
        _mint(address(this), mediatwo, MAX_mediatwo, "");
        _mint(address(this), mediaone, MAX_mediaone, "");
    }

    /**
     * @dev Function to update the base URI.
     * Only callable by the contract owner.
     */
    function setURI(string memory newURI) external onlyOwner {
        _baseURI = newURI;
    }

    function mint(address account, uint256[] memory ids, uint256[] memory amounts) external onlyAdmin {
        require(ids.length == amounts.length, "IDs and amounts length mismatch");

        for (uint256 i = 0; i < ids.length; i++) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            require(id == mediathree || id == mediafour || id == mediatwo || id == mediaone, "Invalid token ID");

            if (amount > 0) {
                safeTransferFrom(address(this), account, id, amount, "");
            }
        }
    }

    function uri(uint256 id) public view override returns (string memory) {
        // Convert token ID to string
        return string(abi.encodePacked(_baseURI, Strings.toString(id)));
    }

    function addAdmin(address _newAdmin, bool _approval) public onlyOwner {
        if (_approval) {
            isAdmin[_newAdmin] = true;
            _setApprovalForAll(address(this), _newAdmin, true);
        } else {
            isAdmin[_newAdmin] = false;
            _setApprovalForAll(address(this), _newAdmin, false);
        }
    }
}
