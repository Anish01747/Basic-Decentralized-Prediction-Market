// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PredictionMarket {
    // Struct to represent a prediction event
    struct Event {
        string description;
        uint256 startTime;
        uint256 endTime;
        bool isResolved;
        bool outcome;  // true for YES, false for NO
        uint256 totalYesStake;
        uint256 totalNoStake;
        mapping(address => uint256) yesStakes;
        mapping(address => uint256) noStakes;
        mapping(address => bool) hasClaimed;
    }

    // Mapping to store events
    mapping(uint256 => Event) public events;
    uint256 public eventCounter;

    // Fee for creating events (can be adjusted)
    uint256 public constant EVENT_CREATION_FEE = 0.01 ether;

    // Events to log important actions
    event EventCreated(uint256 indexed eventId, string description, uint256 startTime, uint256 endTime);
    event StakePlaced(uint256 indexed eventId, address indexed participant, bool prediction, uint256 amount);
    event EventResolved(uint256 indexed eventId, bool outcome);
    event RewardClaimed(uint256 indexed eventId, address indexed participant, uint256 reward);

    // Modifier to check if an event exists
    modifier eventExists(uint256 eventId) {
        require(eventId > 0 && eventId <= eventCounter, "Event does not exist");
        _;
    }

    // Create a new prediction event
    function createEvent(string memory _description, uint256 _duration) public payable {
        require(msg.value >= EVENT_CREATION_FEE, "Insufficient event creation fee");
        require(_duration > 0, "Duration must be greater than 0");

        eventCounter++;
        Event storage newEvent = events[eventCounter];
        
        newEvent.description = _description;
        newEvent.startTime = block.timestamp;
        newEvent.endTime = block.timestamp + _duration;
        newEvent.isResolved = false;

        emit EventCreated(eventCounter, _description, newEvent.startTime, newEvent.endTime);
    }

    // Place a stake on an event (YES or NO)
    function placeBet(uint256 eventId, bool prediction) public payable eventExists(eventId) {
        Event storage predictionEvent = events[eventId];
        
        require(!predictionEvent.isResolved, "Event already resolved");
        require(block.timestamp < predictionEvent.endTime, "Event has ended");
        require(msg.value > 0, "Stake must be greater than 0");

        if (prediction) {
            predictionEvent.yesStakes[msg.sender] += msg.value;
            predictionEvent.totalYesStake += msg.value;
        } else {
            predictionEvent.noStakes[msg.sender] += msg.value;
            predictionEvent.totalNoStake += msg.value;
        }

        emit StakePlaced(eventId, msg.sender, prediction, msg.value);
    }

    // Resolve the event (only owner or authorized party)
    function resolveEvent(uint256 eventId, bool _outcome) public eventExists(eventId) {
        Event storage predictionEvent = events[eventId];
        
        require(!predictionEvent.isResolved, "Event already resolved");
        require(block.timestamp >= predictionEvent.endTime, "Event has not ended");
        
        // In a real-world scenario, this would be replaced with an oracle or voting mechanism
        predictionEvent.isResolved = true;
        predictionEvent.outcome = _outcome;

        emit EventResolved(eventId, _outcome);
    }

    // Claim rewards for a resolved event
    function claimReward(uint256 eventId) public eventExists(eventId) {
        Event storage predictionEvent = events[eventId];
        
        require(predictionEvent.isResolved, "Event not yet resolved");
        require(!predictionEvent.hasClaimed[msg.sender], "Reward already claimed");

        uint256 userStake;
        bool userPrediction;
        uint256 totalCorrectStake;
        uint256 totalRewardPool;

        if (predictionEvent.outcome) {
            userStake = predictionEvent.yesStakes[msg.sender];
            userPrediction = true;
            totalCorrectStake = predictionEvent.totalYesStake;
            totalRewardPool = predictionEvent.totalNoStake + predictionEvent.totalYesStake;
        } else {
            userStake = predictionEvent.noStakes[msg.sender];
            userPrediction = false;
            totalCorrectStake = predictionEvent.totalNoStake;
            totalRewardPool = predictionEvent.totalNoStake + predictionEvent.totalYesStake;
        }

        require(userStake > 0, "No stake in the correct prediction");

        // Calculate reward proportional to stake
        uint256 reward = (userStake * totalRewardPool) / totalCorrectStake;

        // Mark as claimed and transfer reward
        predictionEvent.hasClaimed[msg.sender] = true;
        payable(msg.sender).transfer(reward);

        emit RewardClaimed(eventId, msg.sender, reward);
    }

    // View function to get event details
    function getEventDetails(uint256 eventId) public view eventExists(eventId) returns (
        string memory description,
        uint256 startTime,
        uint256 endTime,
        bool isResolved,
        bool outcome,
        uint256 totalYesStake,
        uint256 totalNoStake
    ) {
        Event storage predictionEvent = events[eventId];
        return (
            predictionEvent.description,
            predictionEvent.startTime,
            predictionEvent.endTime,
            predictionEvent.isResolved,
            predictionEvent.outcome,
            predictionEvent.totalYesStake,
            predictionEvent.totalNoStake
        );
    }

    // Fallback function
    receive() external payable {
        revert("Direct sends not allowed");
    }
}