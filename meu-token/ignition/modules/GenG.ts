import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("GenGModule", (m) => {
  const fornecimentoInicial = m.getParameter("fornecimentoInicial", 1_000_000n);
  const geng = m.contract("GenG", [fornecimentoInicial]);
  return { geng };
});