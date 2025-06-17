-- Create Database
CREATE DATABASE CourtCaseDB;
USE CourtCaseDB;

-- Table: Court
CREATE TABLE Court (
    CourtID INT PRIMARY KEY,
    CourtName VARCHAR(100),
    Location VARCHAR(100)
);

-- Table: CaseInfo
CREATE TABLE CaseInfo (
    CaseID INT PRIMARY KEY,
    Title VARCHAR(100),
    CaseType VARCHAR(50),
    Status VARCHAR(50),
    FilingDate DATE,
    CourtID INT,
    FOREIGN KEY (CourtID) REFERENCES Court(CourtID)
);

-- Table: Party
CREATE TABLE Party (
    PartyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50), -- e.g., Plaintiff, Defendant
    ContactInfo VARCHAR(100)
);

-- Table: CaseParty (relationship between cases and parties)
CREATE TABLE CaseParty (
    CaseID INT,
    PartyID INT,
    PRIMARY KEY (CaseID, PartyID),
    FOREIGN KEY (CaseID) REFERENCES CaseInfo(CaseID),
    FOREIGN KEY (PartyID) REFERENCES Party(PartyID)
);

-- Table: Hearing
CREATE TABLE Hearing (
    HearingID INT PRIMARY KEY,
    CaseID INT,
    HearingDate DATE,
    HearingTime TIME,
    JudgeName VARCHAR(100),
    FOREIGN KEY (CaseID) REFERENCES CaseInfo(CaseID)
);

-- Insert sample data into Court
INSERT INTO Court VALUES 
(1, 'High Court', 'Delhi'),
(2, 'District Court', 'Mumbai');

-- Insert sample data into CaseInfo
INSERT INTO CaseInfo VALUES 
(101, 'Land Dispute', 'Civil', 'Open', '2023-06-01', 1),
(102, 'Cheque Bounce', 'Criminal', 'Closed', '2023-01-15', 2);

-- Insert sample data into Party
INSERT INTO Party VALUES 
(201, 'Ravi Kumar', 'Plaintiff', 'ravi@example.com'),
(202, 'Anil Verma', 'Defendant', 'anil@example.com'),
(203, 'Sunita Rao', 'Plaintiff', 'sunita@example.com');

-- Insert sample data into CaseParty
INSERT INTO CaseParty VALUES 
(101, 201),
(101, 202),
(102, 203),
(102, 202);

-- Insert sample data into Hearing
INSERT INTO Hearing VALUES 
(301, 101, '2023-07-10', '10:30:00', 'Justice Sinha'),
(302, 102, '2023-02-20', '14:00:00', 'Justice Mehra');

-- Sample Query 1: View all cases
SELECT * FROM CaseInfo;

-- Sample Query 2: View parties involved in Case 101
SELECT c.CaseID, c.Title, p.Name, p.Role
FROM CaseInfo c
JOIN CaseParty cp ON c.CaseID = cp.CaseID
JOIN Party p ON cp.PartyID = p.PartyID
WHERE c.CaseID = 101;

-- Sample Query 3: Upcoming hearings
SELECT * FROM Hearing
WHERE HearingDate >= CURDATE();
