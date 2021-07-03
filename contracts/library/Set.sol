// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/// @title Set data structure
/// @dev Supports `add`, `remove` and `has` methods. Use `values` property to iterate over values. Do not edit properties directly.
struct Set {
    address[] values;
    mapping(address => uint256) _valueIndexPlusOne;
}

library SetMethods {
    /// @dev Adds a value to the set.
    /// @return `true` if the value was successfully added; `false` if the value was already in the set.
    function add(Set storage set, address value) public returns (bool) {
        if (set._valueIndexPlusOne[value] != 0) {
            return false;
        }
		set.values.push(value);
		set._valueIndexPlusOne[value] = set.values.length;  // length == last_index + 1
        return true;
    }

    /// @dev Removes a value from the set.
    /// @return `true` if value was successfully removed; `false` if the value was not in the set.
    function remove(Set storage set, address value) public returns (bool) {
        if (set._valueIndexPlusOne[value] == 0) {
            return false;
        }
        uint256 valueToRemoveIndexPlusOne = set._valueIndexPlusOne[value];
        uint256 lastValueIndex = set.values.length - 1;

        // Swap indices
        set._valueIndexPlusOne[set.values[lastValueIndex]] = valueToRemoveIndexPlusOne;
        delete set._valueIndexPlusOne[value];

        // Move the last value to the deleted spot
        set.values[valueToRemoveIndexPlusOne - 1] = set.values[lastValueIndex];

        // Delete the duplicated last value
        set.values.pop();
        return true;
    }

    /// @dev Checks if a value is in the set.
    /// @return `true` if the value is in the set; `false` if the value is not in the set.
    function has(Set storage set, address value) public view returns (bool) {
        return set._valueIndexPlusOne[value] != 0;
    }
}
