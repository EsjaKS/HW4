-- Elísabet Erlendsdóttir og Esja Kristín Siggeirsdóttir

-- A
CREATE TABLE Languages(
    ID INT,
    name VARCHAR NOT NULL,
    speakers VARCHAR NOT NULL,
    PRIMARY KEY(ID)
);

-- J
-- These sponsees must be kept track of
CREATE TABLE Sponsee(
    ID INT,
    grant_amount INT,
    PRIMARY KEY(ID)
);

-- C
CREATE TABLE Subscriber(
    ID INT,
    name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    username VARCHAR NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE(username, email)
);

-- I, J
CREATE TABLE Squad(
    SponseeID INT REFERENCES Sponsee(ID),
    LanguagesID INT REFERENCES Languages(ID), -- Squads can be associated to a specific language but that is not a requirement.
    ID INT,
    name VARCHAR NOT NULL,
    address VARCHAR, -- Can be NULL since address is optional
    PRIMARY KEY(ID)
);

-- D, J
CREATE TABLE Teacher(
    SubscriberID INT REFERENCES Subscriber(ID),
    phone VARCHAR NOT NULL,
    office_hours VARCHAR, -- Can be NULL since some teachers have maybe not worked any hours yet
    bank VARCHAR NOT NULL,
    ledger VARCHAR NOT NULL,
    account_number VARCHAR NOT NULL,
    PRIMARY KEY(SubscriberID),
    UNIQUE(phone)  
);

-- C, I, J
-- Learners can follow each other on the platform
CREATE TABLE Learner(
    SubscriberID INT REFERENCES Subscriber(ID),
    SponseeID INT REFERENCES Sponsee(ID),
    SquadID INT REFERENCES Squad(ID),
    last_login_date DATE NOT NULL,
    XP INT,
    PRIMARY KEY(SubscriberID)
);

-- E
-- A single learner can review the same teacher multiple times
CREATE TABLE Reviews(
    TeacherID INT REFERENCES Teacher(SubscriberID),
    LearnerID INT REFERENCES Learner(SubscriberID),
    stars INT CHECK (stars >= 1 AND stars <= 5), -- Stars are on the scale 1-5
    CHECK(TeacherID <> LearnerID) -- Check if learner and teacher is the same person, since teacher cannot review himself
);

-- J
CREATE TABLE Nominates(
    NominatesID INT NOT NULL REFERENCES Teacher(SubscriberID),
    SponseeID INT REFERENCES Sponsee(ID),
    year INT, -- A teacher may nominate the same learner/squad multiple times, but only once per year.
    PRIMARY KEY (SponseeID, year)
);

-- B, E
-- Courses are cancelled if fewer than 10 learner sign up
CREATE TABLE Courses(
    LanguagesID INT REFERENCES Languages(ID),
    TeacherID INT REFERENCES Teacher(SubscriberID),
    ID INT,
    name VARCHAR NOT NULL,
    start_date DATE NOT NULL,
    level VARCHAR NOT NULL,
    PRIMARY KEY(ID)
);

-- E
CREATE TABLE Registered_to(
    CoursesID INT REFERENCES Courses(ID),
    LearnerID INT REFERENCES Learner(SubscriberID),
    PRIMARY KEY(CoursesID, LearnerID)
);

-- F, G
CREATE TABLE Milestone(
    CoursesID INT REFERENCES Courses(ID),
    ID INT,
    credits INT,
    PRIMARY KEY(ID)
);

-- F
CREATE TABLE Completes(
    CoursesID INT REFERENCES Courses(ID),
    LearnerID INT REFERENCES Learner(SubscriberID),
    MilestoneID INT REFERENCES Milestone(ID),
    grade VARCHAR NOT NULL,
    FOREIGN KEY(CoursesID, LearnerID) REFERENCES Registered_to(CoursesID, LearnerID),  
    PRIMARY KEY(CoursesID, LearnerID, MilestoneID)
);

-- G
CREATE TABLE Assignment(
    MilestoneID INT REFERENCES Milestone(ID),
    due_date DATE NOT NULL,
    PRIMARY KEY(MilestoneID)
);

-- G, H
CREATE TABLE Exams(
    MilestoneID INT REFERENCES Milestone(ID),
    duration VARCHAR,
    date DATE NOT NULL,
    PRIMARY KEY(MilestoneID)
);

-- H
CREATE TABLE Question(
    ExamsID INT REFERENCES Exams(MilestoneID),
    number VARCHAR,
    weight VARCHAR,
    text VARCHAR NOT NULL,
    PRIMARY KEY(number)
);