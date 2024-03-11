-- Elísabet Erlendsdóttir og Esja Kristín Siggeirsdóttir

CREATE TABLE Languages(
	ID INT,
	name VARCHAR NOT NULL,
	speakers VARCHAR NOT NULL,
    PRIMARY KEY (ID)
)

CREATE TABLE Courses(
	ID INT,
	name VARCHAR NOT NULL,
	start_date DATE NOT NULL,
	level VARCHAR NOT NULL, 
    Languagesid REFERENCES Languages (ID)
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
    subscriberid REFERENCES Subscriber (ID)
    phone VARCHAR NOT NULL
    office_hours INT,  --varchar?
    bank_account VARCHAR NOT NULL
    UNIQUE(phone)
    -- bank account er með 3 út frá sér, hvernig á að skrifa það?
)

-- tígull - aggregation?
-- lausn 1
CREATE TABLE Registered_to(
    CourseID INT REFERENCES Course(ID), -- á þetta a vera svona af því er í kassa útan um tígull refrence.
    LearnerID INT REFERENCES Learner(ID), -- same
    MilestoneID INT REFERENCES Milestone(ID),
    PRIMARY KEY(CourseID, LearnerID) -- ekki milestones af því það er tígull þar á milli?
) -- foreign eða uniqe

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
    Registered_toID INT REFERENCES Registered_to(ID),  -- á þetta að vera?
    CompletesID INT NOT NULL REFERENCES Milestone(ID),
    grade INT NULL,
    PRIMARY KEY(Registered_toID)
)

-- union
CREATE TABLE Learner(
    sponseeid references sponsee(id)
    last_login_date DATE NOT NULL,
    XP INT -- varchar? 
)

-- tígull, á að vera?
CREATE TABLE Reviews(
    ReviewsID INT NOT NULL REFERENCES Teacher(ID),
    ReviewsID INT NOT NULL REFERENCES Learner(ID),
    stars INT CHECK (stars >= 1 AND stars <= 5)
    ) 

CREATE TABLE Milestone(
    ID INT,
    credits INT,
    courseid REFERENCES course (ID)
    PRIMARY KEY(ID) 
)

CREATE TABLE Assignment(
    milestoneid REFERENCES milestone(id)
    due_date DATE NOT NULL
)

CREATE TABLE Exam(
    milestoneid REFERENCES milestone(id)
    duration INT, -- Varchar??
    date DATE NOT NULL
)

-- weak entity
CREATE TABLE Question(
	ID INT REFERENCES Exams,
    number INT, --Varchar
    weight INT, --varchar
    text VARCHAR NOT NULL,
    PRIMARY KEY (number)
    FOREIGN KEY (examID) REFERENCES Exam (ID)
)

-- union
CREATE TABLE Squad(
    ID INT,
    sponseeid REFERENCES sponsee (ID)
    -- refrence language?
    -- Learner
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL, 
    PRIMARY KEY (ID) 
)

-- union
CREATE TABLE Sponsee(
    ID INT, 
    grant_amount INT, -- Decimal
    PRIMARY KEY (ID)
)

-- tígull á tígull að vera
CREATE TABLE Nominates(
    NominatesID INT NOT NULL REFERENCES Teacher(ID),
    SponseeID INT REFERENCES Party(ID),
    year INT,
    PRIMARY KEY (SponseeID, year)
)

