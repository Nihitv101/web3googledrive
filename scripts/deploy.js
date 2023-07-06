// deploying script:

const hre = require('hardhat');


async function main(){
    // we create the instance and we deploy using the instance:

    const Upload = await hre.ethers.getContractFactory('Upload');

    const upload = await Upload.deploy();

    await upload.deployed();


    console.log('Library Deployed to :', upload.address);

    


}



main().catch((error)=>{
    console.log(error);
    process.exitCode=1;
})