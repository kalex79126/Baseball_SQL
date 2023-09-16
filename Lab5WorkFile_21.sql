--drop the tables if they already exist
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WINNER]') AND type in (N'U'))
	DROP TABLE [dbo].[WINNER]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AWARD]') AND type in (N'U'))
	DROP TABLE [dbo].[AWARD]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ATHLETE]') AND type in (N'U'))
	DROP TABLE [dbo].[ATHLETE]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TEAM]') AND type in (N'U'))
	DROP TABLE [dbo].[TEAM]
GO

/* TEAM TABLE CREATE AND INSERT STATEMENTS */

CREATE TABLE TEAM 
(
	teamID				INT IDENTITY(1,1),
	teamName			VARCHAR(50) NOT NULL,
	teamCity			VARCHAR(20) NOT NULL,
	teamState			CHAR(2),
	teamCountry			VARCHAR(6),
	teamManager			VARCHAR(50),
	teamLeague			CHAR(2) NOT NULL,
	teamStadium			VARCHAR(30)

	CONSTRAINT pk_TEAM_teamID PRIMARY KEY(teamID)
)

INSERT INTO TEAM
	(teamName, teamCity, teamState, teamCountry, teamManager, teamLeague, teamStadium)
VALUES
	('Pittsburgh Pirates', 'Pittsburgh', 'PA', 'USA', 'Derek Shelton', 'NL', 'PNC Park'), 
	('Los Angeles Angels', 'Anaheim', 'CA', 'USA', 'Joe Maddon', 'AL', 'Angel Stadium of Anaheim'),
	('Colorado Rockies', 'Denver', 'CO', 'USA', 'Bud Black', 'NL', 'Coors Field'),
	('New York Mets', 'Queens', 'NY', 'USA', 'Luis Rojas', 'NL', 'Citi Field'),
	('Seattle Mariners', 'Seattle', 'WA', 'USA', 'Scott Servais', 'AL', 'T-Mobile Park'), 
	('Toronto Blue Jays', 'Toronto', 'ON', 'Canada', 'Charlie Montoyo', 'AL', 'Rogers Centre'),
	('Boston Red Sox', 'Boston', 'MA', 'USA', 'Alex Cora', 'AL', 'Fenway Park'),
	('New York Yankees', 'New York', 'NY', 'USA', 'Aaron Boone', 'AL', 'Yankee Stadium'),
	('Cleveland Indians', 'Cleveland', 'OH', 'USA', 'Terry Francona', 'AL', 'Progressive Field'),
	('Chicago White Sox', 'Chicago', 'IL', 'USA', 'Tony La Russa', 'AL', 'Guaranteed Rate Field'),
	('Minnesota Twins', 'Minneapolis', 'MN', 'USA', 'Rocco Baldelli', 'AL', 'Target Field'), 
	('Cincinnati Reds', 'Cincinnati', 'OH', 'USA', 'David Bell', 'NL', 'Great American Ball Park'), 
	('Tampa Bay Rays', 'Tampa Bay', 'FL', 'USA', 'Kevin Cash', 'AL', 'Tropicana Field'),
	('St. Louis Cardinals', 'St. Louis', 'MO', 'USA', 'Mike Shildt', 'NL', 'Busch Stadium')

/* ATHLETE TABLE CREATE AND INSERT STATEMENTS */

CREATE TABLE ATHLETE 
(
  athleteID				INT IDENTITY(1,1),
  athleteFirstName 		VARCHAR(20) NOT NULL,
  athleteLastName 		VARCHAR(30) NOT NULL,
  athleteDateofBirth 	DATE,
  athleteHeight			SMALLINT,
  athleteWeight			TINYINT,
  athletePosition 		CHAR(2) NOT NULL,
  athleteBattingAvg 	DECIMAL(4,3) DEFAULT 0.000,
  athleteNationality	VARCHAR(30), 
  teamID				INT,
  nominatedID			INT
  
  CONSTRAINT pk_ATHLETE_athleteID PRIMARY KEY(athleteID), 
  CONSTRAINT fk_TEAM_ATHLETE FOREIGN KEY(teamID) REFERENCES TEAM(teamID),
  CONSTRAINT fk_ATHLETE_nominatedID FOREIGN KEY(nominatedID) REFERENCES ATHLETE(athleteID)		--this is the foreign key constraint for 1:M recursive
) 


INSERT INTO ATHLETE
	(athleteFirstName, athleteLastName, athleteDateofBirth, athleteHeight, athleteWeight, athletePosition, athleteBattingAvg, athleteNationality, teamID) 
VALUES
	('Bo', 'Bichette',				'1998-03-05', 183, 83,	'SS', 0.294, 'USA', 6),
	('Kevin', 'Kiermaier',			'1990-04-22', 185, 95,  'CF', 0.247, 'USA', 13),
	('Nolan', 'Arenado', 			'1991-04-16', 188, 97,  '3B', 0.255, 'USA', 14),
	('Vladimir', 'Guererro Jr.',	'1999-03-16', 188, 113, '1B', 0.321, 'Canada', 6),
	('Mike', 'Trout', 				'1991-08-07', 188, 106, 'CF', 0.333, 'USA', 2),
	('Jose', 'Abreu', 				'1987-01-29', 190, 115, '1B', 0.263, 'Cuba', 10),
	('Tyler', 'O''Neill',			'1995-06-22', 180, 90,	'LF', 0.282, 'Canada', 14),
	('Aaron', 'Judge', 				'1992-04-26', 201, 127, 'RF', 0.284, 'USA', 8),
	('Joey', 'Votto', 				'1983-09-10', 188, 99,  '1B', 0.267, 'Canada', 12),
	('Kevin', 'Pillar', 			'1989-01-04', 183, 95,  'CF', 0.223, 'USA', 4),
	('Abraham', 'Toro',				'1996-12-20', 183, 93,	'IF', 0.247, 'Canada', 5),
	('Cavan', 'Biggio',				'1995-04-11', 188, 90,  'IF', 0.215, 'USA', 6),
	('Travis', 'Shaw',				'1990-04-16', 193, 104, 'IF', 0.202, 'USA', 7),
	('Josh', 'Donaldson', 			'1985-12-08', 185, 95,  '3B', 0.245, 'USA', 11),
	('Danny', 'Jansen',				'1995-04-15', 188, 104, 'C',  0.209, 'USA', 6),
	('Randal', 'Grichuk',			'1991-08-13', 188, 96,  'OF', 0.247, 'USA', 6),
	('Teoscar', 'Hernandez',		'1992-10-15', 188, 92,	'OF', 0.303, 'Dominican Republic', 6),
	('Tim', 'Anderson',				'1993-06-23', 185, 83,	'SS', 0.301, 'USA', 10), 
	('Marcus', 'Semien',			'1990-09-17', 183, 88,  'IF', 0.270, 'USA', 6), 
	('Josh', 'Naylor',				'1997-06-22', 180, 113, 'OF', 0.253, 'Canada', 9)
	

/* AWARD TABLE CREATE AND INSERT STATEMENTS */


CREATE TABLE AWARD 
(
	awardID			INT IDENTITY(1,1),
	awardName		VARCHAR(30) NOT NULL,
	awardSponsor	VARCHAR(100)
	
	CONSTRAINT pk_AWARD_awardID PRIMARY KEY(awardID)
)

INSERT INTO AWARD
	(awardName, awardSponsor)
VALUES 
	('Most Valuable Player', 'Baseball Writers Association of America'),
	('Gold Glove', 'Rawlings'),
	('Silver Slugger', 'Hillerich & Bradsby'),
	('Rookie of the Year', 'Baseball Writers Association of America')
	

/* WINNER TABLE CREATE AND INSERT STATEMENTS */

CREATE TABLE WINNER
(
	winID		INT IDENTITY(1,1),
	winYear		INT NOT NULL,
	athleteID	INT NOT NULL,
	awardID		INT NOT NULL
	
	CONSTRAINT pk_WINNER_winID PRIMARY KEY(winID),
	CONSTRAINT fk_WINNER_ATHLETE FOREIGN KEY(athleteID) REFERENCES ATHLETE(athleteID),
	CONSTRAINT fk_WINNER_AWARD FOREIGN KEY(awardID) REFERENCES AWARD(awardID)
)

INSERT INTO WINNER
	(winYear, athleteID, awardID)
VALUES 
	(2017, 8, 4),	--judge, roy
	(2017, 8, 3),	--judge, ss
	(2020, 7, 2),	--o'neill, gg
	(2013, 3, 2),	--arenado, gg
	(2014, 3, 2),	--arenado, gg
	(2015, 3, 2),	--arenado, gg
	(2016, 3, 2),	--arenado, gg
	(2017, 3, 2),	--arenado, gg
	(2018, 3, 2),	--arenado, gg
	(2019, 3, 2),	--arenado, gg
	(2020, 3, 2),	--arenado, gg
	(2015, 3, 3), 	--arenado, ss
	(2016, 3, 3), 	--arenado, ss
	(2017, 3, 3), 	--arenado, ss
	(2018, 3, 3), 	--arenado, ss
	(2010, 9, 1), 	--votto, mvp
	(2011, 9, 2),	--votto, gg
	(2012, 5, 4), 	--trout, roy
	(2014, 6, 4),	--abreu, roy
	(2014, 6, 3),	--abreu, ss
	(2018, 6, 3),	--abreu, ss
	(2020, 6, 3),	--abreu, ss
	(2014, 5, 1),	--trout, mvp
	(2016, 5, 1),	--trout, mvp
	(2019, 5, 1),	--trout, mvp
	(2015, 2, 2), 	--kiermaier, gg
	(2016, 2, 2), 	--kiermaier, gg
	(2019, 2, 2), 	--kiermaier, gg
	(2015, 14, 1),	--donaldson, mvp
	(2015, 14, 3),	--donaldson, ss
	(2016, 14, 3)	--donaldson, ss
	
	
SELECT * FROM ATHLETE
--REMEMBER TO EXECUTE THE CREATE AND INSERT STATEMENTS BEFORE EXECUTING THE UPDATES!

--WRITE	YOUR UPDATE STATEMENTS HERE...
--4. Write and execute UPDATE statements for the ATHLETE table to record the following information in the database:
-- Joey Votto nominates Danny Jansen
UPDATE ATHLETE
SET nominatedID = 15
WHERE athleteID = 9

-- Kevin Kiermaier nominates Mike Trout
UPDATE ATHLETE
SET nominatedID = 5
WHERE athleteID = 2

-- Bo Bichette, Randal Grichuk, and Abraham Toro all nominate Vladimir Guererro Jr.
UPDATE ATHLETE
SET nominatedID = 4
WHERE athleteID IN (1, 16, 11)

-- Jose Abreu and Aaron Judge both nominate Nolan Arenado
UPDATE ATHLETE
SET nominatedID = 3
WHERE athleteID IN (6, 8)

-- Tyler O’Neill and Teoscar Hernandez nominate Josh Naylor
UPDATE ATHLETE
SET nominatedID = 20
WHERE athleteID IN (7, 17)

-- Vladimir Guererro Jr. and Cavan Biggio both nominate Marcus Semien
UPDATE ATHLETE
SET nominatedID = 19
WHERE athleteID IN (4, 12)

-- Nolan Arenado, Tim Anderson, and Kevin Pillar nominate Travis Shaw
UPDATE ATHLETE
SET nominatedID = 13
WHERE athleteID IN (3, 18, 10)

-- Mike Trout, Josh Donaldson, Danny Jansen, Marcus Semien, Josh Naylor, and Travis Shaw all did not nominate anyone.	

SELECT * FROM ATHLETE
--ANSWER THE SELECT QUERIES...
--5. Write and execute SELECT queries to answer the following questions. Remember to match your output to the samples given, including the column aliases.
--a. Display a list of all athletes and the name of the person he nominated. Include the athlete’s team name. Order the athletes by last name.
SELECT NOMINATOR.athleteFirstName as [athleteFirst], NOMINATOR.athleteLastName as [athleteLast], teamName as [athleteTeam], CONCAT(NOMINEE.athleteFirstNAme, ' ', NOMINEE.athleteLastName) AS [recipientName]
FROM ATHLETE NOMINATOR 
	LEFT JOIN ATHLETE NOMINEE ON NOMINATOR.nominatedID = NOMINEE.athleteID	--reqursive joins nominee and nominator
	INNER JOIN TEAM ON NOMINATOR.teamID = TEAM.teamID	--inner joins nominator and team tables
ORDER BY NOMINATOR.athleteLastName		--shows the result based on the order of athlete's last name of nominator table


SELECT NOMINATOR.nominatedID
FROM ATHLETE NOMINATOR 
	LEFT JOIN ATHLETE NOMINEE ON NOMINATOR.nominatedID = NOMINEE.athleteID	
WHERE NOMINATOR.nominatedID=3 OR NOMINATOR.nominatedID=4
ORDER BY NOMINATOR.athleteLastName

--b. How many athletes nominated someone who has the same nationality as himself?
SELECT COUNT(NOMINEE.athleteID) AS [Same Nationality Nominations]		
FROM ATHLETE NOMINATOR 
	INNER JOIN ATHLETE NOMINEE ON NOMINATOR.nominatedID = NOMINEE.athleteID		--reqursive joins nominee and nominator 
WHERE NOMINATOR.athleteNationality = NOMINEE.athleteNationality		--where the nationality of nominator and nominee are the same

--c. Which athletes received more than one nomination? Sort by athlete's first name, then last name.
SELECT NOMINEE.athleteFirstName, NOMINEE.athleteLastName, COUNT(NOMINEE.athleteID) AS [numberOfNominations] 
FROM ATHLETE NOMINATOR 
	INNER JOIN ATHLETE NOMINEE ON NOMINATOR.nominatedID = NOMINEE.athleteID		--reqursive joins nominee and nominator
GROUP BY NOMINEE.athleteFirstName, NOMINEE.athleteLastName		--group the values for each row together
HAVING COUNT(*) > 1		--where the number of nomination is greater than 1
ORDER BY NOMINEE.athleteFirstName, NOMINEE.athleteLastName	--shows the result based on the order of athlete's first then last names of nominee table

--d. Show the total number of nominations received per TEAM, ordered by number of nominations from least to most.
SELECT teamName, COUNT(NOMINEE.athleteID) as [nominations]
FROM ATHLETE NOMINATOR 
	INNER JOIN ATHLETE NOMINEE ON NOMINATOR.nominatedID = NOMINEE.athleteID		--reqursive joins nominee and nominator
	INNER JOIN TEAM ON NOMINEE.teamID = TEAM.teamID		--inner joins nominee table with team table
GROUP BY teamName		--group the values for each row together
ORDER BY COUNT(NOMINEE.athleteID)		--shows the result based on the number of nominations per team

--e. Repeat query a, but when a player did not nominate anyone, display the message "***None***".
SELECT NOMINATOR.athleteFirstName as [athleteFirst], NOMINATOR.athleteLastName as [athleteLast], teamName as [athleteTeam], COALESCE(NULLIF(CONCAT(NOMINEE.athleteFirstNAme, ' ', NOMINEE.athleteLastName),''), '***None***') AS [recipientName]		--shows ***None*** for the ones that didn't nominate anyone
FROM ATHLETE NOMINATOR 
	LEFT JOIN ATHLETE NOMINEE ON NOMINATOR.nominatedID = NOMINEE.athleteID		--reqursive joins nominee and nominator tables
	INNER JOIN TEAM ON NOMINATOR.teamID = TEAM.teamID		--inner joins nominator and team tables
ORDER BY NOMINATOR.athleteLastName		--shows the result by the athlete's last name of nominator table