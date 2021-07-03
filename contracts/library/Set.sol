// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/// @title Set data structure
/// @dev Supports `add`, `remove` and `has` methods. Use `values` property to iterate over values.
library Set {
    struct Data {
        mapping(address => uint256) valueIndexPlusOne;
        address[] values;
    }

    /// @dev Adds a value to the set.
    /// @return `true` if the value was successfully added; `false` if the value was already in the set.
    function add(Data storage set, address value) public returns (bool) {
        if (set.valueIndexPlusOne[value] != 0) {
            return false;
        }
		set.values.push(value);
		set.valueIndexPlusOne[value] = set.values.length;  // length == last_index + 1
        return true;
    }

    /// @dev Removes a value from the set.
    /// @return `true` if value was successfully removed; `false` if the value was not in the set.
    function remove(Data storage set, address value) public returns (bool) {
        if (set.valueIndexPlusOne[value] == 0) {
            return false;
        }
        uint256 valueToRemoveIndexPlusOne = set.valueIndexPlusOne[value];
        uint256 lastValueIndex = set.values.length - 1;

        // Swap indices
        set.valueIndexPlusOne[set.values[lastValueIndex]] = valueToRemoveIndexPlusOne;
        delete set.valueIndexPlusOne[value];

        // Move the last value to the deleted spot
        set.values[valueToRemoveIndexPlusOne - 1] = set.values[lastValueIndex];

        // Delete the duplicated last value
        set.values.pop();
        return true;
    }

    /// @dev Checks if a value is in the set.
    /// @return `true` if the value is in the set; `false` if the value is not in the set.
    function has(Data storage set, address value) public view returns (bool) {
        return set.valueIndexPlusOne[value] != 0;
    }
}
