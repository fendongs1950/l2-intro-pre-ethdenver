import { Wallet, utils } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";

// 一个部署Greeter合约的示例脚本

export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`运行Greeter合约的部署脚本`);

  // 初始化钱包
  const wallet = new Wallet("0x07c67739877c9680e42b0faa4842597a34ce8d50ddc45a4bf01153097df2f9ca");

  // 创建deployer对象，并从abi中初始化合约对象 
  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("CryptoCENU"); //可以换成自己的合约名，合约名必须与文件名一样

  // 估计部署合约需要的手续费
  // const greeting = "";
  // const deploymentFee = await deployer.estimateDeployFee(artifact, [greeting]);

  // // ⚠️ 可选步骤：如果你的L2账户中已经有资金，可以跳过此步骤
  // // 把资金存入L2
  // const depositHandle = await deployer.zkWallet.deposit({
  //   to: deployer.zkWallet.address,
  //   token: utils.ETH_ADDRESS,
  //   amount: deploymentFee.mul(2),
  // });
  // // 等待zkSync处理存款
  // await depositHandle.wait();

  // 部署合约。返回的对象类型与`ethers`中的合约类型类似。
  //`greeting`是合约构造函数的一个参数。
  //const parsedFee = ethers.utils.formatEther(deploymentFee.toString());
  //console.log(`部署合约需要花费 ${parsedFee} ETH`);

  const greeterContract = await deployer.deploy(artifact/*, [greeting]*/);

  // 获取构造函数参数
  // console.log(
  //   "构造函数参数: " + greeterContract.interface.encodeDeploy([greeting])
  // );

  // 显示合约信息
  const contractAddress = greeterContract.address;
  console.log(`${artifact.contractName}已经部署到 ${contractAddress}`);
}
