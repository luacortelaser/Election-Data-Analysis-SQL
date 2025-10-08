-- 1. States Table
CREATE TABLE states (
    state_id VARCHAR(10) PRIMARY KEY,
    state VARCHAR(100) NOT NULL
);      

-- 2. Partywise Results Table
CREATE TABLE partywise_results (
    party_id INT PRIMARY KEY,
    party VARCHAR(100) NOT NULL,
    won INT
);

-- 3. Statewise Results Table
CREATE TABLE statewise_results (
    constituency VARCHAR(100),
    const_no INT,
    parliament_constituency VARCHAR(100) PRIMARY KEY,
    leading_candidate VARCHAR(150),
    trailing_candidate VARCHAR(150),
    margin INT,
    status VARCHAR(50),
    state_id VARCHAR(10),
	state_name VARCHAR(100),
    FOREIGN KEY (state_id) REFERENCES states(state_id)
);

-- 4. Constituencywise Results Table
CREATE TABLE constituency_results (
	s_no INT,
    parliament_constituency VARCHAR(100),
    constituency_name VARCHAR(100),
    winning_candidate VARCHAR(150),
    total_votes INT,
    margin INT,
    constituency_id VARCHAR(20) PRIMARY KEY,
    party_id INT,
    FOREIGN KEY (party_id) REFERENCES partywise_results(party_id),
    FOREIGN KEY (parliament_constituency) REFERENCES statewise_results(parliament_constituency)
);

-- 5. Constituencywise Details Table
CREATE TABLE constituency_details (
	s_no INT,
    candidate VARCHAR(150) NOT NULL,
    party VARCHAR(100),
    evm_votes INT,
    postal_votes INT,
    total_votes INT,
    percentage_of_votes DECIMAL(5,2),
    constituency_id VARCHAR(20),
    FOREIGN KEY (constituency_id) REFERENCES constituency_results(constituency_id)
);