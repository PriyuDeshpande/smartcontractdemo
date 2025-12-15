// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ToolManagement {

    struct Tool {
        uint id;
        string name;
        bool isAvailable;
        address borrowedBy;
    }

    uint public toolCount = 0;
    mapping(uint => Tool) public tools;

    // Add a new tool
    function addTool(string memory _name) public {
        toolCount++;
        tools[toolCount] = Tool(
            toolCount,
            _name,
            true,
            address(0)
        );
    }

    // Borrow a tool
    function borrowTool(uint _id) public {
        require(tools[_id].isAvailable, "Tool not available");

        tools[_id].isAvailable = false;
        tools[_id].borrowedBy = msg.sender;
    }

    // Return a tool
    function returnTool(uint _id) public {
        require(tools[_id].borrowedBy == msg.sender, "Not the borrower");

        tools[_id].isAvailable = true;
        tools[_id].borrowedBy = address(0);
    }
}
