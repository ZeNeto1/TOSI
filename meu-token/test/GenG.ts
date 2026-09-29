import { expect } from "chai";
import { network } from "hardhat";

const { ethers, networkHelpers } = await network.create();

describe("GenG", function () {
  async function implantarFixture() {
    const [dono, outraConta] = await ethers.getSigners();
    // Implantando o contrato GenG com fornecimento inicial de 1.000.000 de tokens
    const token = await ethers.deployContract("GenG", [1_000_000n]);
    return { token, dono, outraConta };
  }

  it("tem o nome e o símbolo corretos", async function () {
    const { token } = await networkHelpers.loadFixture(implantarFixture);
    expect(await token.name()).to.equal("GenG");
    expect(await token.symbol()).to.equal("GNG");
  });

  it("credita todo o fornecimento inicial ao dono", async function () {
    const { token, dono } = await networkHelpers.loadFixture(implantarFixture);
    const saldoDono = await token.balanceOf(dono.address);
    expect(await token.totalSupply()).to.equal(saldoDono);
  });

  it("permite transferir tokens entre contas", async function () {
    const { token, outraConta } = await networkHelpers.loadFixture(implantarFixture);
    await token.transfer(outraConta.address, 100n);
    expect(await token.balanceOf(outraConta.address)).to.equal(100n);
  });

  it("impede que outra conta faça mint", async function () {
    const { token, outraConta } = await networkHelpers.loadFixture(implantarFixture);
    await expect(
      token.connect(outraConta).mint(outraConta.address, 100n)
    ).to.be.revert(ethers);
  });
});