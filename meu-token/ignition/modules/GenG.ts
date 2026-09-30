import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("GenGModule", (m) => {
  // Define 1.000.000 como fornecimento inicial e 2.000.000 como teto máximo (cap)
  const fornecimentoInicial = m.getParameter("fornecimentoInicial", 1_000_000n);
  const limiteMaximo = m.getParameter("limiteMaximo", 2_000_000n);

  const geng = m.contract("GenG", [fornecimentoInicial, limiteMaximo]);

  return { geng };
});