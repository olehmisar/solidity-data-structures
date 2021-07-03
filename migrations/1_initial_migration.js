const Migrations = artifacts.require("Migrations")
const Set = artifacts.require("Set")
const SetWrapper = artifacts.require("SetWrapper")

module.exports = function (deployer) {
  deployer.deploy(Migrations)
  deployer.deploy(Set)
  deployer.link(Set, SetWrapper)
  deployer.deploy(SetWrapper)
}
