// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GenG is ERC20, ERC20Burnable, ERC20Pausable, ERC20Capped, Ownable {
    constructor(uint256 fornecimentoInicial, uint256 limiteMaximo)
        ERC20("GenG", "GNG")
        ERC20Capped(limiteMaximo * 10 ** 18)
        Ownable(msg.sender)
    {
        require(fornecimentoInicial <= limiteMaximo, "Fornecimento inicial excede o teto");
        _mint(msg.sender, fornecimentoInicial * 10 ** 18);
    }

    // Pausa todas as transferências de tokens em emergências
    function pause() public onlyOwner {
        _pause();
    }

    // Reativa as movimentações do token
    function unpause() public onlyOwner {
        _unpause();
    }

    // Permite ao dono da carteira criar novos tokens no futuro (respeitando o cap)
    function mint(address destinatario, uint256 quantidade) public onlyOwner {
        _mint(destinatario, quantidade * 10 ** 18);
    }

    // Resolve os conflitos de herança da função _update no OpenZeppelin v5
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Capped, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}