// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import {SetWrapper} from "../contracts/library/wrappers/SetWrapper.sol";

contract TestSet {
    function testIsInitiallyEmpty() public {
        SetWrapper set = new SetWrapper();
        address[] memory expected;
        Assert.equal(set.values(), expected, "not empty");
    }

    function testAddingAnItem() public {
        SetWrapper set = new SetWrapper();
        Assert.isTrue(set.add(address(0)), "add was not successful");
        address[] memory expected = new address[](1);
        expected[0] = address(0);
        Assert.equal(set.values(), expected, "did not add an item");
    }

    function testAddingTheSameItem() public {
        SetWrapper set = new SetWrapper();
        Assert.isTrue(set.add(address(0)), "add was not successful");
        Assert.isFalse(set.add(address(0)), "adding an already existing item should not be successful");

        address[] memory expected = new address[](1);
        expected[0] = address(0);
        Assert.equal(set.values(), expected, "did not add an item");
    }

    function testAddingFewItems() public {
        SetWrapper set = new SetWrapper();
        Assert.isTrue(set.add(address(0)), "add was not successful");
        Assert.isTrue(set.add(address(1)), "add was not successful");
        Assert.isTrue(set.add(address(3)), "add was not successful");

        address[] memory expected = new address[](3);
        expected[0] = address(0);
        expected[1] = address(1);
        expected[2] = address(3);
        Assert.equal(set.values(), expected, "did not add all items");
    }

    function testRemovingAnItem() public {
        SetWrapper set = new SetWrapper();
        set.add(address(1));
        set.add(address(2));
        set.add(address(3));

        Assert.isTrue(set.remove(address(1)), "remove was not successful");
        address[] memory expected = new address[](2);
        expected[0] = address(3);
        expected[1] = address(2);
        Assert.equal(set.values(), expected, "did not remove an item");
    }

    function testRemovingUnexistingItem() public {
        SetWrapper set = new SetWrapper();
        Assert.isFalse(set.remove(address(5)), "removing an unexisting item should not be successful");
    }

    function testCheckingIfItemExists() public {
        SetWrapper set = new SetWrapper();
        set.add(address(1));
        set.add(address(3));

        Assert.isTrue(set.has(address(1)), "item should exist");
        Assert.isTrue(set.has(address(3)), "item should exist");
        Assert.isFalse(set.has(address(0)), "item should not exist");
        Assert.isFalse(set.has(address(2)), "item should not exist");
    }
}
