-- Elísabet Erlendsdóttir og Esja Kristín Siggeirsdóttir

CREATE TABLE Languages(
	ID INT,
	name VARCHAR NOT NULL,
	speakers VARCHAR NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE Courses(
	ID INT,
	name VARCHAR NOT NULL,
	start_date DATE NOT NULL,
	level VARCHAR NOT NULL, 
    Languagesid REFERENCES Languages (ID)
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
    subscriberid REFERENCES Subscriber (ID)
    phone VARCHAR NOT NULL
    office_hours VARCHAR
    bank VARCHAR NOT NULL
    ledger VARCHAR NOT NULL
    account_number VARCHAR NOT NULL
    UNIQUE(phone)  
);


CREATE TABLE Registered_to(
    CourseID INT REFERENCES Course(ID), 
    LearnerID INT REFERENCES Learner(ID), 
    PRIMARY KEY(CourseID, LearnerID) 
); 

CREATE TABLE Completes(
    CourseID INT REFERENCES Course (ID)
    LearnerID INT REFERENCES Learner (ID)
    MilestoneID INT REFERENCES Milestone (ID)
    grade VARCHAR NOT NULL
    Foreign Key(courseid, learnerid) INT REFERENCES Registered_to(CourseID, learnerID),  
    PRIMARY KEY(CourseID, LearnerID, milestoneID)
);




CREATE TABLE Learner(
    sponseeid references sponsee(id)
    last_login_date DATE NOT NULL,
    XP INT
);

-- Komið en má fara yfir fyrir ofan

-- tígull, á að vera?
CREATE TABLE Reviews(
    TeacherID INT REFERENCES Teacher(ID),
    LearnerID INT REFERENCES Learner(ID),
    stars INT CHECK (stars >= 1 AND stars <= 5), -- Stjörnur meiga bara vera á þessu bili.
    CHECK(TeacherID<>LearnerID) -- tjékka hvort learner id sé sama og teacher id.
); 

CREATE TABLE Milestone(
    ID INT,
    credits INT,
    courseid REFERENCES course (ID)
    PRIMARY KEY(ID) 
);

CREATE TABLE Assignment(
    milestoneid REFERENCES milestone(id)
    due_date DATE NOT NULL
);

CREATE TABLE Exam(
    milestoneid REFERENCES milestone(id)
    duration VARCHAR
    date DATE NOT NULL
);

-- weak entity
CREATE TABLE Question(
	ID INT REFERENCES Exams,
    number VARCHAR 
    weight VARCHAR
    text VARCHAR NOT NULL,
    PRIMARY KEY (number)
    FOREIGN KEY (examID) REFERENCES Exam (ID)
);

-- union
CREATE TABLE Squad(
    ID INT,
    sponseeid REFERENCES sponsee (ID)
    -- refrence language?
    -- Learner
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL, 
    PRIMARY KEY (ID) 
);

-- union
CREATE TABLE Sponsee(
    ID INT, 
    grant_amount INT, -- Decimal
    PRIMARY KEY (ID)
);

-- tígull á tígull að vera
CREATE TABLE Nominates(
    NominatesID INT NOT NULL REFERENCES Teacher(ID),
    SponseeID INT REFERENCES Party(ID),
    year INT,
    PRIMARY KEY (SponseeID, year)
);

