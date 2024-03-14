-- Elísabet Erlendsdóttir og Esja Kristín Siggeirsdóttir

CREATE TABLE Languages(
	ID INT,
	name VARCHAR NOT NULL,
	speakers VARCHAR NOT NULL,
    PRIMARY KEY(ID)
);

CREATE TABLE Courses(
	LanguagesID REFERENCES Languages(ID),
    TeacherID REFERENCES Teacher(ID),
    ID INT,
	name VARCHAR NOT NULL,
	start_date DATE NOT NULL,
	level VARCHAR NOT NULL, 
	PRIMARY KEY (ID)
);

CREATE TABLE Subscriber(
	ID INT,
	name VARCHAR NOT NULL,
	email VARCHAR NOT NULL,
	username VARCHAR NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE(username, email)
);

CREATE TABLE Teacher(
    SubscriberID REFERENCES Subscriber(ID),
    phone VARCHAR NOT NULL,
    office_hours VARCHAR, -- Can be NULL because some teachers have maybe not worked any hours yet
    bank VARCHAR NOT NULL,
    ledger VARCHAR NOT NULL,
    account_number VARCHAR NOT NULL,
    -- PRIMARY KEY(SubscriberID)
    UNIQUE(phone)  
);

CREATE TABLE Registered_to(
    CourseID INT REFERENCES Course(ID), 
    LearnerID INT REFERENCES Learner(ID), 
    PRIMARY KEY(CourseID, LearnerID) 
); 

CREATE TABLE Completes(
    CourseID INT REFERENCES Course(ID),
    LearnerID INT REFERENCES Learner(ID),
    MilestoneID INT REFERENCES Milestone(ID),
    grade VARCHAR NOT NULL,
    FOREIGN KEY(CourseID, LearnerID) INT REFERENCES Registered_to(CourseID, LearnerID),  
    PRIMARY KEY(CourseID, LearnerID, MilestoneID)
);

CREATE TABLE Learner(
    SubscriberID REFERENCES Subscriber(ID),
    SponseeID REFERENCES sponsee(ID),
    -- SquadID REFERENCES Squad(ID), one to many
    -- PRIMARY KEY(SubscriberID)
    last_login_date DATE NOT NULL,
    XP INT
);

CREATE TABLE Reviews(
    TeacherID INT REFERENCES Teacher(ID),
    LearnerID INT REFERENCES Learner(ID),
    stars INT CHECK (stars >= 1 AND stars <= 5), -- Stars are on the scale 1-5
    CHECK(TeacherID <> LearnerID) -- Check if learner and teacher is the same person, since teacher cannot review himself
); 

CREATE TABLE Milestone(
    CourseID REFERENCES Course(ID),
    ID INT,
    credits INT,
    PRIMARY KEY(ID) 
);

CREATE TABLE Assignment(
    MilestoneID REFERENCES Milestone(ID),
    due_date DATE NOT NULL
);

CREATE TABLE Exam(
    MilestoneID REFERENCES Milestone(ID),
    duration VARCHAR,
    date DATE NOT NULL
);

-- Weak entity
CREATE TABLE Question(
	ID INT REFERENCES Exams,
    number VARCHAR 
    weight VARCHAR
    text VARCHAR NOT NULL,
    PRIMARY KEY (number)
    FOREIGN KEY (ExamID) REFERENCES Exam(ID)
);

-- Union
CREATE TABLE Squad(
    SponseeID REFERENCES Sponsee(ID),
    ID INT,
    -- refrence language?
    -- Learner
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL, 
    PRIMARY KEY(ID) 
);

-- Union
CREATE TABLE Sponsee(
    ID INT, 
    grant_amount INT, -- Decimal
    PRIMARY KEY (ID)
);

CREATE TABLE Nominates(
    NominatesID INT NOT NULL REFERENCES Teacher(ID),
    SponseeID INT REFERENCES Party(ID),
    year INT,
    PRIMARY KEY (SponseeID, year)
);

