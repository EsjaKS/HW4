-- Elísabet Erlendsdóttir og Esja Kristín Siggeirsdóttir

CREATE TABLE Languages(
	ID INT,
	name VARCHAR NOT NULL,
	speakers VARCHAR NOT NULL
)

CREATE TABLE Courses(
	ID INT,
	name VARCHAR NOT NULL,
	start_date DATE NOT NULL,
	level INT,
	PRIMARY KEY (ID)
)

CREATE TABLE Subscriber(
	ID INT,
	name VARCHAR NOT NULL,
	email VARCHAR NOT NULL,
	username VARCHAR NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE(username, email)
)

CREATE TABLE Teacher(
    phone INT,
    office_hours INT,
    bank_account VARCHAR NOT NULL
    UNIQUE(phone)
    -- bank account er með 3 út frá sér, hvernig á að skrifa það?
)

-- tígull - aggregation?
-- lausn 1
CREATE TABLE Registered_to(
    CourseID INT REFERENCES Course(ID),
    LearnerID INT REFERENCES Learner(ID),
    MilestoneID INT REFERENCES Milestone(ID),
    PRIMARY KEY(CourseID, LearnerID) -- ekki milestones af því það er tígull þar á milli?
)

-- lausn 2
CREATE TABLE Registered_to(
    ID INT,
    CourseID INT REFERENCES Course(ID),
    LearnerID INT REFERENCES Learner(ID),
    MilestoneID INT REFERENCES Milestone(ID),
    PRIMARY KEY(ID) -- ekki milestones af því það er tígull þar á milli?
    UNIQUE(CourseID, LearnerID)
)

CREATE TABLE Completes(
    Registered_toID INT REFERENCES Registered_to(ID),
    CompletesID INT NOT NULL REFERENCES Milestone(ID),
    grade INT NULL,
    PRIMARY KEY(Registered_toID)
)

-- union
CREATE TABLE Learner(
    last_login_date DATE NOT NULL,
    XP INT --? 
)

-- tígull
CREATE TABLE Reviews(
    ReviewsID INT NOT NULL REFERENCES Teacher(ID),
    ReviewsID INT NOT NULL REFERENCES Learner(ID),
    stars INT -- from 1 to 5
    -- CHECK (stars >= 1) and (stars <= 5)
) 

CREATE TABLE Milestone(
    ID INT,
    credits INT,
    PRIMARY KEY(ID)
)

CREATE TABLE Assignment(
    due_date DATE NOT NULL
)

CREATE TABLE Exam(
    duration INT, --??
    date DATE NOT NULL
)

-- weak entity
CREATE TABLE Question(
	ID INT REFERENCES Exams,
    number INT,
    weight INT,
    text VARCHAR NOT NULL,
    PRIMARY KEY (number)
)

-- union
CREATE TABLE Squat(
    ID INT,
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    PRIMARY KEY (ID)
)

-- union
CREATE TABLE Sponsee(
    -- LearnerID INT REFERENCES Learner(ID),
    -- SquadID INT REFERENCES Squad(ID)
    ID INT, 
    grant_amount INT,
    PRIMARY KEY (ID)
    -- PRIMARY KEY (LearnerID, SquadID)
)

-- tígull
CREATE TABLE Nominates(
    NominatesID INT NOT NULL REFERENCES Teacher(ID),
    SponseeID INT REFERENCES Party(ID),
    year INT,
    PRIMARY KEY (SponseeID, year)
)

