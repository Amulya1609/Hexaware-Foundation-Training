/*

SQL Coding Challenge, 3/10/2024

Crime Management

*/

--Create Tables
create database CrimeManagement

use CrimeManagement

CREATE TABLE Crime (
    CrimeID INT PRIMARY KEY,
    IncidentType VARCHAR(255),
    IncidentDate DATE,
    Location VARCHAR(255),
    Description TEXT,
    Status VARCHAR(20)
);

CREATE TABLE Victim (
    VictimID INT PRIMARY KEY,
    CrimeID INT,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255),
    Injuries VARCHAR(255),
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);


CREATE TABLE Suspect (
    SuspectID INT PRIMARY KEY,
    CrimeID INT,
    Name VARCHAR(255),
    Description TEXT,
    CriminalHistory TEXT,
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
    (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
    (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
    (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES
    (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
    (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
    (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None');

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES
    (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
    (2, 2, 'Unknown', 'Investigation ongoing', NULL),
    (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');

--1. Select all open incidents.

SELECT * FROM Crime WHERE Status = 'Open';

--2. Find the total number of incidents.

SELECT COUNT(*) AS TotalIncidents FROM Crime;

--3. List all unique incident types.

SELECT DISTINCT IncidentType FROM Crime;

--4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.

SELECT * FROM Crime
WHERE IncidentDate BETWEEN '2023-09-01' AND '2023-09-10';

--5. List persons involved in incidents in descending order of age.

-- Add Age column and values
ALTER TABLE Victim ADD Age INT;

ALTER TABLE Suspect ADD Age INT;

UPDATE Victim SET Age = 30
WHERE VictimID = 1;

UPDATE Victim SET Age = 45
WHERE VictimID = 2;

UPDATE Victim SET Age = 35
WHERE VictimID = 3;

UPDATE Suspect SET Age = 40
WHERE SuspectID = 1;

UPDATE Suspect SET Age = 29
WHERE SuspectID = 2;

UPDATE Suspect SET Age = 50
WHERE SuspectID = 3;

-- List persons by age in descending order
SELECT Name, Age, 'Victim' AS Role FROM Victim

UNION

SELECT Name, Age, 'Suspect' AS Role FROM Suspect
ORDER BY Age DESC;

--6. Find the average age of persons involved in incidents.

SELECT AVG(Age) AS VictimAverageAge FROM Victim;

SELECT AVG(Age) AS SuspectAverageAge FROM Suspect;

--7. List incident types and their counts, only for open cases.

SELECT IncidentType, COUNT(*) AS IncidentCount
FROM Crime
WHERE Status = 'Open'
GROUP BY IncidentType;

--8. Find persons with names containing 'Doe'.

SELECT Name, 'Victim' AS Role
FROM Victim
WHERE Name LIKE '%Doe%'

UNION

SELECT Name, 'Suspect' AS Role
FROM Suspect
WHERE Name LIKE '%Doe%';

--9. Retrieve the names of persons involved in open cases and closed cases.

SELECT V.Name,'Victim' AS Role
FROM Victim V
JOIN Crime C ON V.CrimeID = C.CrimeID
WHERE C.Status = 'Open' AND C.Status = 'Closed'

UNION

SELECT S.Name,'Suspect' AS Role
FROM Suspect S
JOIN Crime C ON S.CrimeID = C.CrimeID
WHERE C.Status = 'Open' AND C.Status = 'Closed';


--10. List incident types where there are persons aged 30 or 35 involved.

SELECT DISTINCT C.IncidentType
FROM Crime C
JOIN Victim V ON C.CrimeID = V.CrimeID
WHERE V.Age IN (30, 35)

UNION

SELECT DISTINCT C.IncidentType
FROM Crime C
JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE S.Age IN (30, 35);

--11. Find persons involved in incidents of the same type as 'Robbery'.

SELECT V.Name, 'Victim' AS Role
FROM Victim V
JOIN Crime C ON V.CrimeID = C.CrimeID
WHERE C.IncidentType = 'Robbery'

UNION ALL

SELECT S.Name, 'Suspect' AS Role
FROM Suspect S
JOIN Crime C ON S.CrimeID = C.CrimeID
WHERE C.IncidentType = 'Robbery';

--12. List incident types with more than one open case.

SELECT IncidentType, COUNT(*) AS CaseCount
FROM Crime
WHERE Status = 'Open'
GROUP BY IncidentType
HAVING COUNT(*) > 1;

--13. List all incidents with suspects whose names also appear as victims in other incidents.

SELECT C.CrimeID, C.IncidentType
FROM Crime C
JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE S.Name IN (SELECT Name FROM Victim);

--14. Retrieve all incidents along with victim and suspect details.

SELECT C.CrimeID, C.IncidentType, 
       V.Name AS VictimName, 
       S.Name AS SuspectName 
	   FROM Crime C
LEFT JOIN Victim V ON C.CrimeID = V.CrimeID
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;

--15. Find incidents where the suspect is older than any victim.

SELECT C.CrimeID, C.IncidentType
FROM Crime C
JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE S.Age > (SELECT MIN(V.Age) FROM Victim V WHERE V.CrimeID = C.CrimeID);

--16. Find suspects involved in multiple incidents:

SELECT S.Name, COUNT(*) AS IncidentCount
FROM Suspect S
GROUP BY S.Name
HAVING COUNT(*) > 1;

--17. List incidents with no suspects involved.

SELECT C.CrimeID, C.IncidentType
FROM Crime C
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE S.SuspectID IS NULL;

--18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'.

SELECT C.IncidentType
FROM Crime C
GROUP BY C.IncidentType
HAVING COUNT(CASE WHEN C.IncidentType = 'Homicide' THEN 1 END) > 0
   AND COUNT(CASE WHEN C.IncidentType = 'Robbery' THEN 1 END) = COUNT(*);

--19. Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.

SELECT C.CrimeID, C.IncidentType
FROM Crime C
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;

--20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'

SELECT S.Name
FROM Suspect S
JOIN Crime C ON S.CrimeID = C.CrimeID
WHERE C.IncidentType IN ('Robbery', 'Assault');
