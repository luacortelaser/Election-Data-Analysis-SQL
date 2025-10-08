--1.Find the Total Seats in Parliament.
SELECT DISTINCT COUNT (parliament_constituency) AS Total_Seats
FROM constituency_results

--2.What is the total number of seats available for elections in each state
SELECT s.state AS state_name,
	COUNT(cr.constituency_id) AS total_seats_available
FROM constituency_results cr
JOIN statewise_results sr ON 
	sr.parliament_constituency = cr.parliament_constituency
JOIN states s ON s.state_id = sr.state_id
GROUP BY s.state
ORDER BY s.state;

--3.Total Seats Won by NDA Allianz
SELECT 
	SUM(
		CASE 
			WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN pr.won
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    partywise_results pr

--4.Seats Won by NDA Allianz Parties
SELECT party as Party_Name,won as Seats_Won
FROM partywise_results
WHERE party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY Seats_Won DESC;

--5.Total Seats Won by I.N.D.I.A. Allianz
SELECT 
	SUM(
		CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN pr.won
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results pr

--6.Seats Won by I.N.D.I.A. Allianz Parties
SELECT party as Party_Name, won as Seats_Won
FROM partywise_results
WHERE party IN (
        'Indian National Congress - INC',
		'Aam Aadmi Party - AAAP',
		'All India Trinamool Congress - AITC',
		'Bharat Adivasi Party - BHRTADVSIP',
		'Communist Party of India  (Marxist) - CPI(M)',
		'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
		'Communist Party of India - CPI',
		'Dravida Munnetra Kazhagam - DMK',
		'Indian Union Muslim League - IUML',
		'Nat`Jammu & Kashmir National Conference - JKN',
		'Jharkhand Mukti Morcha - JMM',
		'Jammu & Kashmir National Conference - JKN',
		'Kerala Congress - KEC',
		'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
		'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
		'Rashtriya Janata Dal - RJD',
		'Rashtriya Loktantrik Party - RLTP',
		'Revolutionary Socialist Party - RSP',
		'Samajwadi Party - SP',
		'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
		'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY Seats_Won DESC;

/*7.Add new column field in table partywise_results to get
the Party Allianz as NDA, I.N.D.I.A and OTHER*/
ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);

--I.N.D.I.A Allianz
UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
	);

--NDA Allianz
UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

--OTHER
UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

SELECT * FROM partywise_results;


/*8.Which party alliance (NDA, I.N.D.I.A, or OTHER) won the
most seats across all states?*/
SELECT p.party_alliance, COUNT(cr.constituency_id) AS Seats_Won
FROM constituency_results cr
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
WHERE p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY p.party_alliance
ORDER BY Seats_Won DESC;

/*9.Winning candidate's name, their party name, total votes,
and the margin of victory for a specific state and constituency?*/
SELECT cr.winning_candidate, p.party, p.party_alliance, 
	cr.total_votes, cr.margin, cr.constituency_name, s.state
FROM constituency_results cr
JOIN partywise_results p ON p.party_id = cr.party_id
JOIN statewise_results sr ON sr.parliament_constituency = cr.parliament_constituency
JOIN states s ON s.state_id = sr.state_id
WHERE s.state = 'Maharashtra' AND cr.constituency_name = 'AKOLA';

/*10.What is the distribution of EVM votes versus postal votes 
for candidates in a specific constituency?*/
SELECT cd.candidate,cd.party,cd.evm_votes,cd.postal_votes,
    cd.total_votes,cr.constituency_name
FROM constituency_details cd
JOIN constituency_results cr ON cr.constituency_id = cd.constituency_id
WHERE cr.constituency_name = 'AKOLA'
ORDER BY cd.total_votes DESC;

/*11.Which parties won the most seats in State, and 
how many seats did each party win?*/
SELECT p.party,COUNT(cr.constituency_id) AS Seats_Won
FROM constituency_results cr
JOIN partywise_results p ON p.party_id = cr.party_id
JOIN statewise_results sr ON
	sr.parliament_constituency = cr.parliament_constituency
JOIN states s ON s.state_id = sr.state_id
WHERE s.state = 'Maharashtra'
GROUP BY p.party
ORDER BY Seats_Won DESC;

/*12.What is the total number of seats won by each party alliance
(NDA, I.N.D.I.A, and OTHER)in each state for the India Elections 2024*/
SELECT s.state AS State_Name,
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM constituency_results cr
JOIN partywise_results p ON p.party_id = cr.party_id
JOIN statewise_results sr ON 
	sr.parliament_constituency = cr.parliament_constituency
JOIN states s ON s.state_id = sr.state_id
WHERE p.party_alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')
GROUP BY s.state
ORDER BY s.state;

/*13.Which candidate received the highest number of EVM votes 
in each constituency (Top 10)?*/
SELECT cr.constituency_name,cd.constituency_id,
    cd.candidate,cd.evm_votes
FROM constituency_details cd
JOIN constituency_results cr ON cr.constituency_id = cd.constituency_id
WHERE 
    cd.EVM_Votes = (
        SELECT MAX(cd1.evm_votes)
        FROM constituency_details cd1
        WHERE cd1.constituency_id = cd.constituency_id
    )
ORDER BY cd.evm_votes DESC
LIMIT 10;

/*14.Which candidate won and which candidate was the runner-up 
in each constituency of State for the 2024 elections?*/
WITH RankedCandidates AS (
    SELECT cd.constituency_id,cd.candidate,cd.party,
        cd.evm_votes,cd.postal_votes,cd.total_votes,
        ROW_NUMBER() OVER (PARTITION BY cd.constituency_id 
			ORDER BY cd.total_votes DESC) AS VoteRank
    FROM constituency_details cd
    JOIN constituency_results cr ON cr.constituency_id = cd.constituency_id
    JOIN statewise_results sr ON 
		sr.parliament_constituency = cr.parliament_constituency
    JOIN states s ON s.state_id = sr.state_id
    WHERE s.state = 'Maharashtra'
)

SELECT cr.constituency_name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.candidate END) AS Runnerup_Candidate
FROM RankedCandidates rc
JOIN constituency_results cr ON cr.constituency_id = rc.constituency_id
GROUP BY cr.constituency_name
ORDER BY cr.constituency_name;


/*15.For the state of Maharashtra, what are the total number of seats, 
total number of candidates, total number of parties, 
total votes (including EVM and postal), and the breakdown of
EVM and postal votes?*/
SELECT 
    COUNT(DISTINCT cr.constituency_id) AS Total_Seats,
    COUNT(DISTINCT cd.candidate) AS Total_Candidates,
    COUNT(DISTINCT p.party) AS Total_Parties,
    SUM(cd.total_votes) AS Total_Votes,
    SUM(cd.evm_votes) AS Total_EVM_Votes,
    SUM(cd.postal_votes) AS Total_Postal_Votes
FROM constituency_results cr
JOIN constituency_details cd ON cd.constituency_id = cr.constituency_id
JOIN statewise_results sr ON 
	sr.parliament_constituency = cr.parliament_constituency
JOIN states s ON sr.state_id = s.state_id
JOIN partywise_results p ON p.party_id = cr.party_id
WHERE s.state = 'Maharashtra';

