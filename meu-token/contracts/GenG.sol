// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GenG is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    constructor(uint256 fornecimentoInicial)
        ERC20("GenG", "GNG")
        Ownable(msg.sender)
    {
        _mint(msg.sender, fornecimentoInicial * 10 ** decimals());
    }

    // Pausa todas as transferências de tokens em emergências
    function pause() public onlyOwner {
        _pause();
    }

    // Reativa as movimentações do token
    function unpause() public onlyOwner {
        _unpause();
    }

    // Permite ao dono da carteira criar novos tokens no futuro
    function mint(address destinatario, uint256 quantidade) public onlyOwner {
        _mint(destinatario, quantidade * 10 ** decimals());
    }

    // Função interna para resolver o conflito de herança da função _update
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}