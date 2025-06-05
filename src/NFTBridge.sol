// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {OpenseaNFT} from "./OpenSeaNFT.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";

contract NFTBridge is ERC1155Holder, Ownable {
    OpenseaNFT public immutable openseaNFT;

    struct TokenIds {
        uint256 mediathree;
        uint256 mediafour;
        uint256 mediatwo;
        uint256 mediaone;
    }

    TokenIds public tokenIds;

    event Locked(address indexed toAddress, uint256 mediathree, uint256 mediafour, uint256 mediatwo, uint256 mediaone);

    constructor() Ownable(msg.sender) {
        openseaNFT = OpenseaNFT(0x0000000000000000000000000000000000000000);
        tokenIds.mediathree = 33;
        tokenIds.mediafour = 44;
        tokenIds.mediatwo = 22;
        tokenIds.mediaone = 11;
    }

    function lock(
        address _to,
        uint256 _mediathreeAmount,
        uint256 _mediafourAmount,
        uint256 _mediatwoAmount,
        uint256 _mediaoneAmount
    ) external {
        _transferToken(tokenIds.mediathree, _mediathreeAmount);
        _transferToken(tokenIds.mediafour, _mediafourAmount);
        _transferToken(tokenIds.mediatwo, _mediatwoAmount);
        _transferToken(tokenIds.mediaone, _mediaoneAmount);

        emit Locked(_to, _mediathreeAmount, _mediafourAmount, _mediatwoAmount, _mediaoneAmount);
    }

    function _transferToken(uint256 tokenId, uint256 amount) internal {
        if (amount > 0) {
            openseaNFT.safeTransferFrom(msg.sender, 0x000000000000000000000000000000000000dEaD, tokenId, amount, "");
        }
    }
}
