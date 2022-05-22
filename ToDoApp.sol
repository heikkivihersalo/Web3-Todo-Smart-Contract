// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.4.0 <0.9.0;

/**
 * A simple ToDo smart contract app to demonstrate the idea of an web3 todo-app.
 * Can be further extended as an full application with front-end control panel
 *
 */
contract ToDoApp {
    /**
     * Data types
     */
    struct ToDo {
        uint256 id;
        string name;
        string content;
        bool status; // done = true, not done = false
    }

    /**
     * Mappings
     * - "todos" -mapping is used to store content of the todo
     * - "counter -mapping list is used as an index of the todos -list
     */
    mapping(address => ToDo[]) public todos;
    mapping(address => uint256) public counter; 

    /**
     * Constructor
     */
    constructor() {}

    /**
     * Modifiers
     */

    /* Make sure that user has added todos */
    modifier todoCount() {
        require(counter[msg.sender] > 0, "No todos found.");
        _;
    }

    /**
     * Add new todo to todos -list. ID defaults to counter index and status defaults to false
     */
    function addTodo(string memory name, string memory content) public {
        /* Update counter by one */
        counter[msg.sender]++;

        /* Add todo to senders address */
        todos[msg.sender].push(
            ToDo({
                id: counter[msg.sender], 
                name: name, 
                content: content, 
                status: false
            })
        );
    }

    /**
     * Get todo. Give error code if id is not valid. 
     * Can be further extended to store all todos to an list (maybe better to do on front-end?).
     */
    function getTodo(uint id) view public todoCount returns(ToDo memory) {
        require(id <= counter[msg.sender], "Todo with current ID not found");
        return todos[msg.sender][id - 1];
    }


    /**
     * Get amount of todos
     */
    function getAmount() view public returns(uint){
        return counter[msg.sender];
    }

    /**
     * Set todo as done. If no todos are found send error.
     * Takes the ID of the todo (starting from 1).
     */
    function setAsDone(uint id) public todoCount {
        todos[msg.sender][id - 1].status = true;
    }

    /**
     * Set todo as undone. If no todos are found send error.
     * Takes the ID of the todo (starting from 1).
     */
    function setAsUndone(uint id) public todoCount {
        todos[msg.sender][id - 1].status = false;
    }
}
