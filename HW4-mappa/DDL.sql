-- Elísabet Erlendsdóttir og Esja Kristín Siggeirsdóttir

CREATE TABLE Languages(
	ID INT,
	name VARCHAR NOT NULL,
	speakers VARCHAR NOT NULL,
    PRIMARY KEY(ID)
);

CREATE TABLE Sponsee(
    ID INT, 
    grant_amount INT,
    PRIMARY KEY(ID)
);

CREATE TABLE Subscriber(
	ID INT,
	name VARCHAR NOT NULL,
	email VARCHAR NOT NULL,
	username VARCHAR NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE(username, email)
);

CREATE TABLE Squad(
    SponseeID INT REFERENCES Sponsee(ID),
    LanguagesID INT REFERENCES Languages(ID), -- ath betur
    ID INT,
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL, -- kannski meira rétt að gera address VARCHAR því það má vera null (stendur optional í verkefnalýsingunni)
    PRIMARY KEY(ID) 
);

CREATE TABLE Teacher(
    SubscriberID INT REFERENCES Subscriber(ID),
    phone VARCHAR NOT NULL,
    office_hours VARCHAR, -- Can be NULL because some teachers have maybe not worked any hours yet
    bank VARCHAR NOT NULL,
    ledger VARCHAR NOT NULL,
    account_number VARCHAR NOT NULL,
    PRIMARY KEY(SubscriberID), 
    UNIQUE(phone)  
);

CREATE TABLE Learner(
    SubscriberID INT REFERENCES Subscriber(ID),
    SponseeID INT REFERENCES Sponsee(ID),
    SquadID INT REFERENCES Squad(ID), -- one to many, ath betur
    PRIMARY KEY(SubscriberID), 
    last_login_date DATE NOT NULL,
    XP INT
);

CREATE TABLE Reviews(
    TeacherID INT REFERENCES Teacher(SubscriberID),
    LearnerID INT REFERENCES Learner(SubscriberID),
    stars INT CHECK (stars >= 1 AND stars <= 5), -- Stars are on the scale 1-5
    CHECK(TeacherID <> LearnerID) -- Check if learner and teacher is the same person, since teacher cannot review himself
); 

CREATE TABLE Nominates(
    NominatesID INT NOT NULL REFERENCES Teacher(SubscriberID),
    SponseeID INT REFERENCES Sponsee(ID),
    year INT,
    PRIMARY KEY (SponseeID, year)
);

CREATE TABLE Courses(
	LanguagesID INT REFERENCES Languages(ID),
    TeacherID INT REFERENCES Teacher(SubscriberID),
    ID INT,
	name VARCHAR NOT NULL,
	start_date DATE NOT NULL,
	level VARCHAR NOT NULL, 
	PRIMARY KEY(ID)
);

CREATE TABLE Registered_to(
    CoursesID INT REFERENCES Courses(ID), 
    LearnerID INT REFERENCES Learner(SubscriberID), 
    PRIMARY KEY(CoursesID, LearnerID) 
); 

CREATE TABLE Milestone(
    CoursesID INT REFERENCES Courses(ID),
    ID INT,
    credits INT,
    PRIMARY KEY(ID) 
);

CREATE TABLE Completes(
    CoursesID INT REFERENCES Courses(ID),
    LearnerID INT REFERENCES Learner(SubscriberID),
    MilestoneID INT REFERENCES Milestone(ID),
    grade VARCHAR NOT NULL,
    FOREIGN KEY(CoursesID, LearnerID) REFERENCES Registered_to(CoursesID, LearnerID),  
    PRIMARY KEY(CoursesID, LearnerID, MilestoneID)
);

CREATE TABLE Assignment(
    MilestoneID INT REFERENCES Milestone(ID),
    due_date DATE NOT NULL,
    PRIMARY KEY(MilestoneID) --ath betur
);

CREATE TABLE Exams(
    MilestoneID INT REFERENCES Milestone(ID),
    duration VARCHAR,
    date DATE NOT NULL,
    PRIMARY KEY(MilestoneID) -- ath betur
);

-- Weak entity
CREATE TABLE Question(
	ExamsID INT REFERENCES Exams(MilestoneID),
    number VARCHAR,
    weight VARCHAR,
    text VARCHAR NOT NULL,
    PRIMARY KEY(number)
);