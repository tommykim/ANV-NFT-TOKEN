const AVN_ERC20Token = artifacts.require("AVN_TOKEN");

module.exports = function(deployer) {
    deployer.deploy(AVN_ERC20Token);
};
