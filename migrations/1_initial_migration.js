const Migrations = artifacts.require("Migrations")
const SetMethods = artifacts.require("SetMethods")
const SetWrapper = artifacts.require("SetWrapper")

module.exports = function (deployer) {
  deployer.deploy(Migrations)
  deployer.deploy(SetMethods)
  deployer.link(SetMethods, SetWrapper)
  deployer.deploy(SetWrapper)
}
