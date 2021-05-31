SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE Contender;
DROP TABLE Participant;
DROP TABLE Coach;
DROP TABLE TVShow;
DROP TABLE CoachInShow;
DROP TABLE ContenderInShow;
SET FOREIGN_KEY_CHECKS = 1;

-- /////// SCHEMA DEFINITION \\\\\\\ --
-- creates a schema and corresponding tables

CREATE TABLE TVShow (
    idShow INTEGER UNIQUE NOT NULL,
    location VARCHAR(30) DEFAULT 'television studio',
    date DATE NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    PRIMARY KEY (idShow)
);

CREATE TABLE Coach (
    idCoach INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    surname VARCHAR(30) NOT NULL,
    DoB DATE,
    phone VARCHAR(20),
    dailySalary INTEGER,
    gender VARCHAR(10),
    PRIMARY KEY (idCoach)
);

CREATE TABLE Contender (
    idContender INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
    coach INTEGER NOT NULL,
    stageName VARCHAR(30) NOT NULL,
    type VARCHAR(10) NOT NULL,
    PRIMARY KEY (idContender),

    FOREIGN KEY (coach)
            REFERENCES Coach(idCoach)
);

CREATE TABLE Participant (
    idParticipant INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
    contender INTEGER NOT NULL,
    name VARCHAR(20) NOT NULL,
    surname VARCHAR(30) NOT NULL,
    DoB DATE,
    phone VARCHAR(20),
    dailySalary INTEGER,
    gender VARCHAR(10),
    PRIMARY KEY (idParticipant),

    FOREIGN KEY (contender)
            REFERENCES Contender(idContender)
            ON DELETE CASCADE
);

CREATE TABLE CoachInShow (
    coach INTEGER NOT NULL,
    tvShow INTEGER NOT NULL,

    FOREIGN KEY (coach)
            REFERENCES Coach(idCoach)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,

    FOREIGN KEY (tvShow)
            REFERENCES TVShow(idShow)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE ContenderInShow (
    contender INTEGER NOT NULL,
    tvShow INTEGER NOT NULL,

    FOREIGN KEY (contender)
            REFERENCES Contender(idContender)
            ON DELETE CASCADE,

    FOREIGN KEY (tvShow)
            REFERENCES TVShow(idShow)
);

-- /////// POPULATION \\\\\\\ --
-- Populate the database with data

INSERT INTO TVShow
    (idShow, location, date, startTime, endTime)
VALUES
    (1, 'television studio', '2019-03-02', '19:00:00', '21:00:00'),
    (2, 'television studio', '2019-03-03', '20:00:00', '22:00:00'),
    (3, 'television studio', '2019-03-09', '19:00:00', '21:00:00'),
    (4, 'television studio', '2019-03-10', '20:00:00', '22:00:00'),
    (5, 'television studio', '2019-03-16', '18:00:00', '20:00:00'),
    (6, 'television studio', '2019-03-17', '20:00:00', '22:00:00'),
    (7, 'television studio', '2019-03-23', '19:00:00', '21:00:00'),
    (8, 'television studio', '2019-03-24', '20:00:00', '22:00:00'),
    (9, 'television studio', '2019-03-30', '20:00:00', '22:00:00'),
    (10, 'television studio', '2019-03-31', '21:00:00', '23:00:00'),
    (11, 'television studio', '2019-04-06', '19:00:00', '21:00:00'),
    (12, 'television studio', '2019-04-07', '20:00:00', '22:00:00'),
    (13, 'television studio', '2019-04-13', '19:00:00', '21:00:00'),
    (14, 'television studio', '2019-04-14', '19:00:00', '21:00:00'),
    (15, 'covent garden', '2019-04-20', '17:00:00', '19:00:00'),
    (16, 'borough market', '2019-04-21', '18:00:00', '20:00:00'),
    (17, 'television studio', '2019-04-27', '20:00:00', '22:00:00'),
    (18, 'television studio', '2019-04-28', '20:00:00', '22:00:00');

INSERT INTO Coach
    (idCoach, name, surname, DoB, phone, dailySalary, gender)
VALUES
    (1, 'Lebron', 'James', '1984-12-30', '+12345237001', 280,  'male'),
    (2, 'Margot', 'Robbie', '1990-07-02', '+61412686900', 270, 'female'),
    (3, 'Aaron', 'Paul', '1979-08-27', '+13323728900', 220, 'male'),
    (4, 'Anderson', 'Paak', '1986-02-08', '+18005220706', 100, 'male');

INSERT INTO Contender
    (idContender, coach, stageName, type)
VALUES
    (1, (SELECT idCoach from Coach WHERE idCoach = 1) , 'DJ Smith', 'individual'),
    (2, (SELECT idCoach from Coach WHERE idCoach = 1) , 'Jazzy Beast', 'individual'),
    (3, (SELECT idCoach from Coach WHERE idCoach = 2) , 'Summer Hoops', 'individual'),
    (4, (SELECT idCoach from Coach WHERE idCoach = 2) , 'Pianoman', 'individual'),
    (5, (SELECT idCoach from Coach WHERE idCoach = 3) , 'Echo Beavers', 'group'),
    (6, (SELECT idCoach from Coach WHERE idCoach = 3) , 'Purple bolt', 'individual'),
    (7, (SELECT idCoach from Coach WHERE idCoach = 3) , 'Should be Individual', 'group'),
    (8, (SELECt idCoach from Coach WHERE idCoach = 3) , 'Should be Group', 'individual');

-- ALL PARTICIPANTS HAVE THE SAME NUMBER
INSERT INTO Participant
    (idParticipant, contender, name, surname, DoB, phone, dailySalary, gender)
VALUES
    (1, (SELECT idContender FROM Contender WHERE idContender = 1), 'John', 'Smith', '1990-11-20', '+442344437151', 200 , 'male'),
    (2, (SELECT idContender FROM Contender WHERE idContender = 2), 'Liam', 'Davies', '1994-03-17', '+442344437151', 220 , 'male'),
    (3, (SELECT idContender FROM Contender WHERE idContender = 3), 'Emma', 'James', '1985-01-04', '+442344437151', 250 , 'female'),
    (4, (SELECT idContender FROM Contender WHERE idContender = 4), 'Olivia', 'Adams', '1998-10-13', '+442344437151', 180 , 'female'),
    (5, (SELECT idContender FROM Contender WHERE idContender = 5), 'Logan', 'Cole', '1992-11-29', '+442344437151', 45 , 'male'),
    (6, (SELECT idContender FROM Contender WHERE idContender = 5), 'John', 'Ford', '1989-08-21', '+442344437151', 45 , 'male'),
    (7, (SELECT idContender FROM Contender WHERE idContender = 5), 'Charlotte', 'Perry', '1999-08-02', '+442344437151', 45 , 'female'),
    (8, (SELECT idContender FROM Contender WHERE idContender = 5), 'Mia', 'Rose', '2001-07-24', '+442344437151', 45 , 'female'),
    (9, (SELECT idContender FROM Contender WHERE idContender = 5), 'Ava', 'Smith', '1997-12-16', '+442344437151', 45 , 'female'),
    (10, (SELECT idContender FROM Contender WHERE idContender = 5), 'Mason', 'Ward', '1993-04-10', '+442344437151', 45 , 'male'),
    (11, (SELECT idContender FROM Contender WHERE idContender = 6), 'Emma', 'Watson', '1990-01-07', '+442344437151', 240 , 'female'),
    (12, (SELECT idContender FROM Contender WHERE idContender = 7), 'James', 'McDonald', '1990-01-10', '+442333337151', 200 , 'male'),
    (13, (SELECT idContender FROM Contender WHERE idContender = 8), 'Alan', 'Lan', '1992-12-12', '+442333337151', 80 , 'male'),
    (14, (SELECT idContender FROM Contender WHERE idContender = 8), 'Lan', 'Alan', '1991-11-11', '+442333337151', 80 , 'male');


INSERT INTO CoachInShow
    (coach, tvShow)
VALUES
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 2)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 2)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 3)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 3)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 4)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 4)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 4)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 5)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 5)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 5)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 7)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 7)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 8)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 8)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 9)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 9)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 9)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 10)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 10)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 10)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 12)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 12)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 13)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 13)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 14)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 14)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 15)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 15)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 16)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 16)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 16)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idCoach from Coach WHERE idCoach = 1), (SELECT idShow FROM TVShow WHERE idShow = 18)),
        ((SELECT idCoach from Coach WHERE idCoach = 2), (SELECT idShow FROM TVShow WHERE idShow = 18)),
        ((SELECT idCoach from Coach WHERE idCoach = 3), (SELECT idShow FROM TVShow WHERE idShow = 18));

INSERT INTO ContenderInShow
    (contender, tvShow)
VALUES
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 1)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 2)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 2)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 2)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 3)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 3)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 3)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 4)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 4)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 4)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 5)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 5)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 5)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 6)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 7)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 7)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 7)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 8)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 8)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 8)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 9)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 9)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 9)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 10)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 10)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 10)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 11)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 12)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 12)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 12)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 12)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 13)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 13)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 13)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 13)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 14)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 14)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 14)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 15)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 15)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 15)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 16)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 16)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 16)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 17)),
        ((SELECT idContender from Contender WHERE idContender = 1), (SELECT idShow FROM TVShow WHERE idShow = 18)),
        ((SELECT idContender from Contender WHERE idContender = 2), (SELECT idShow FROM TVShow WHERE idShow = 18)),
        ((SELECT idContender from Contender WHERE idContender = 3), (SELECT idShow FROM TVShow WHERE idShow = 18)),
        ((SELECT idContender from Contender WHERE idContender = 4), (SELECT idShow FROM TVShow WHERE idShow = 18)),
        ((SELECT idContender from Contender WHERE idContender = 5), (SELECT idShow FROM TVShow WHERE idShow = 18)),
        ((SELECT idContender from Contender WHERE idContender = 6), (SELECT idShow FROM TVShow WHERE idShow = 18));


-- /////// QUERIES \\\\\\\ --

/*
 Average Female Salary. 
 SELECT query that gives the average daily salary for female participants.
 */
SELECT CONCAT(CAST(AVG(dailySalary) AS DECIMAL (10,2)), ' ', '£') AS 'Average female salary'
FROM Participant
WHERE gender = 'female';

/*
 Coaching Report. 
 For each coach, the query lists the total number of contenders they are coaching.
 */

SELECT Coach.name AS 'Coach name', Coach.surname AS 'Coach surname', Count(Contender.coach) AS 'Number of contenders'
FROM Coach LEFT OUTER JOIN Contender ON idCoach = coach
GROUP BY idCoach;

/*
 Coach Monthly Attendance Report. 
 For each coach, the query lists the total number of shows attended in each month.
 */

SELECT
    FirstSet.idCoach,
    FirstSet.name,
    FirstSet.surname,
    FirstSet.March,
    SecondSet.April
FROM
(
    SELECT C.idCoach, C.name, C.surname, Count(TVShow.idShow) AS March
    FROM  Coach C
    LEFT JOIN CoachInShow ON idCoach = coach
    LEFT JOIN TVShow ON idShow = tvShow AND MONTH(date) = 3
    GROUP BY idCoach
    ) as FirstSet
LEFT JOIN
(
    SELECT C.idCoach, C.name, C.surname, Count(TVShow.idShow) AS April
    FROM  Coach C
    LEFT JOIN CoachInShow ON idCoach = coach
    LEFT JOIN TVShow ON idShow = tvShow AND MONTH(date) = 4
    GROUP BY idCoach
    ) as SecondSet
on FirstSet.idCoach = SecondSet.idCoach
GROUP BY FirstSet.idCoach;

/*
Most Expensive Contender. 
Write a SELECT query that lists the stage name of the contender with the highest total daily salary.
 */

SELECT C.stageName, SUM(P.dailySalary) AS Salary
FROM Participant P, Contender C
WHERE P.contender = C.idContender
GROUP BY C.idContender
ORDER BY Salary DESC
LIMIT 1;

/*
 March Payment Report.
 Payment report for March corresponding to the shows attended by each coach and participant in March.

        - For each coach, it shows their name, the number of shows attended in March, their daily salary
        and their total salary for March (calculated as the number of shows attended multiplied by their daily salary).

        - For each participant, it shows their name, the number of shows attended in March,
        their daily salary and their total salary for March.

        - The last line of the report contains the total amount to be paid in March.
 */

    SELECT IF (C.name IS NOT NULL, 'Coach', 'Participant') AS Type, CONCAT(C.name, ' ', C.surname) AS Name,
           Count(TVShow.idShow) AS 'Attendance in March', C.dailySalary AS 'Daily salary',
           (Count(TVShow.idShow) * C.dailySalary) AS 'Overall Salary'
    FROM  Coach C
    LEFT JOIN CoachInShow ON idCoach = coach
    LEFT JOIN TVShow ON idShow = tvShow AND MONTH(date) = 3
    GROUP BY C.idCoach
    UNION
    SELECT IF (P.name IS NOT NULL, 'Participant', 'Coach'), CONCAT(P.name, ' ', P.surname),
           Count(TVShow.idShow), P.dailySalary, (Count(TVShow.idShow) * P.dailySalary)
    FROM  Participant P
    LEFT JOIN ContenderInShow ON ContenderInShow.contender = P.contender
    LEFT JOIN TVShow ON idShow = tvShow AND MONTH(date) = 3
    GROUP BY P.idParticipant
UNION
    SELECT '   -------', '  ------------', '    ----------------------', '  --------------------',
           CONCAT('TOTAL: ', SUM(TotalSet.`Overall Salary`))
    FROM (
        SELECT C.name, (Count(TVShow.idShow) * C.dailySalary) AS 'Overall Salary'
        FROM Coach C
        LEFT JOIN CoachInShow ON idCoach = coach
        LEFT JOIN TVShow ON idShow = tvShow AND MONTH(date) = 3
        GROUP BY C.idCoach
    UNION
        SELECT P.name, (Count(TVShow.idShow) * P.dailySalary) AS 'Overall Salary'
        FROM Participant P
        LEFT JOIN ContenderInShow ON ContenderInShow.contender = P.contender
        LEFT JOIN TVShow ON idShow = tvShow AND MONTH(date) = 3
        GROUP BY P.idParticipant
    ) AS TotalSet;

/*
 Well Formed Groups! 
 Group contenders should be formed by more than one participant (otherwise they
 are individual contenders).
 
 SELECT statement that returns True if there are no violations in the database
 of this regulation, otherwise False.

 There is a violation if there is a group contender formed by less than 2 participants.
 */

SELECT IF (CheckSet.`CHECK` = 1, 'TRUE', 'FALSE') AS 'Contender Types'
FROM (
    SELECT IF (((COUNT(P.idParticipant) = 1 AND C.type = 'individual') OR
                (COUNT(P.idParticipant) > 1 AND C.type = 'group')),1, 0) AS 'CHECK'
    FROM Contender C, Participant P
    WHERE P.contender = C.idContender
    GROUP BY idContender
    ORDER BY `CHECK`
    LIMIT 1
) AS CheckSet;

-- /////// UPDATES \\\\\\\ --

/*
 Updates the coach and participant information to only contain the hourly payment.
 */

UPDATE Coach C, Participant P
SET C.dailySalary = C.dailySalary / 4,
    P.dailySalary = P.dailySalary / 4;

ALTER TABLE Coach CHANGE dailySalary hourlySalary INTEGER;
ALTER TABLE Participant CHANGE dailySalary hourlySalary INTEGER;


 /*
 Adds new fields to the attendance table to register
 when coaches and contenders arrive to and leave the shows.
 */

ALTER TABLE CoachInShow
    ADD (arriveTime TIME,
         departTime TIME);


ALTER TABLE ContenderInShow
    ADD (arriveTime TIME,
         departTime TIME);

 /*
 UPDATE the attendance information to include the arrival and departure times for the past shows.
 */

UPDATE CoachInShow
        INNER JOIN
    TVShow TVS ON CoachInShow.tvShow = TVS.idShow
SET
    CoachInShow.arriveTime = TVS.startTime - INTERVAL 1 HOUR,
    CoachInShow.departTime = TVS.endTime + INTERVAL 1 HOUR
WHERE CoachInShow.tvShow = CoachInShow.tvShow;


UPDATE ContenderInShow
        INNER JOIN
    TVShow TVS ON ContenderInShow.tvShow = TVS.idShow
SET
    ContenderInShow.arriveTime = TVS.startTime - INTERVAL 1 HOUR,
    ContenderInShow.departTime = TVS.endTime + INTERVAL 1 HOUR
WHERE ContenderInShow.tvShow = ContenderInShow.tvShow;

-- /////// DELETE \\\\\\\ --

 /*
 DELETE statement that removes the contender and all their related data with the lowest total salary
 */

DELETE FROM Contender
WHERE stageName =
    (   SELECT CheckSet.stageName
        FROM
        (   SELECT C.stageName, SUM(P.hourlySalary) AS Salary
            FROM Participant P, (SELECT * FROM Contender) AS C
            WHERE P.contender = C.idContender
            GROUP BY C.idContender
            ORDER BY Salary
         ) as CheckSet
        HAVING MIN(Salary)
    );

