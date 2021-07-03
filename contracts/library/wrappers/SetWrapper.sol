// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Set} from "../Set.sol";

/// @dev Wrapper for testing.
contract SetWrapper {
    using Set for Set.Data;

    Set.Data private set;

    function values() public view returns (address[] memory) {
        return set.values;
    }

    function add(address value) public returns (bool) {
        return set.add(value);
    }

    function remove(address value) public returns (bool) {
        return set.remove(value);
    }

    function has(address value) public view returns (bool) {
        return set.has(value);
    }
}
