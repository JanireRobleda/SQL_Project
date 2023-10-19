CREATE DATABASE University;

USE University;

CREATE TABLE Students (
    StudentID int NOT NULL AUTO_INCREMENT,
    StudentName varchar(50) NOT NULL,
	PRIMARY KEY (StudentID)
);

INSERT INTO Students (StudentName)
VALUES ('Lur'),
		('Coco'),
		('Nana'),
		('Pin'),
		('Aitor')
;


CREATE TABLE Grades (
    GradeID int NOT NULL AUTO_INCREMENT,
    Grade int NOT NULL,
    PRIMARY KEY (GradeID)
);
INSERT INTO Grades (Grade)
VALUES ('1'),
		('2'),
		('3'),
		('4'),
		('5'),
		('6'),
		('7'),
		('8'),
		('9'),
		('10')
;


CREATE TABLE Profs (
    ProfID int NOT NULL AUTO_INCREMENT,
    ProfName varchar(50) NOT NULL,
    PRIMARY KEY (ProfID)
);
INSERT INTO Profs (ProfName)
VALUES ('Pepa'),
		('Manola'),
		('Mauricio'),
		('Amanda'),
		('La Mari')
;


CREATE TABLE Courses (
    CourseID int NOT NULL AUTO_INCREMENT,
    CourseName varchar(100) NOT NULL,
    PRIMARY KEY (CourseID)
);
INSERT INTO Courses (CourseName)
VALUES ('Statistics'),
		('Geology'),
		('Organic Chemistry'),
		('Physics'),
		('Thermodynamics')
;


----------------------------------------------------------------------

CREATE TABLE SampleData (
    SampleDataID int NOT NULL AUTO_INCREMENT,
    StudentID int NOT NULL,
	CourseID int NOT NULL,
	GradeID int NOT NULL,
	ProfID int NOT NULL,
	FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (GradeID) REFERENCES  Grades(GradeID),
	FOREIGN KEY (ProfID) REFERENCES Profs(ProfID),
    PRIMARY KEY (SampleDataID)
);

INSERT INTO SampleData (StudentID, CourseID, GradeID, ProfID)
VALUES (1,1,4,5),
		(1,4,7,3),
		(2,5,10,2),
		(3,3,9,1),
		(4,2,3,2),
		(2,1,6,4),
		(3,5,7,1),
		(4,4,5,3),
        (5,2,3,5),
        (1,4,4,5),
		(5,4,4,5),
		(3,2,7,1);

select avg(Grades.Grade) as Average_Grade,
		Profs.ProfName as Professor_Name 
From SampleData
join Profs on Profs.ProfID = SampleData.ProfID
join Grades on Grades.GradeID = SampleData.GradeID
group by Profs.ProfName;


select 
	MAX(Grades.Grade) as Max_Grade,
	Students.StudentName as Student_Name
from SampleData
join Grades on Grades.GradeID = SampleData.GradeID
join Students on Students.StudentID = SampleData.StudentID
group by Students.StudentName
order by MAX(Grades.Grade) desc
;


select  
	Students.StudentName as Student_Name,
    Courses.CourseName as Course
from SampleData
join Students on Students.StudentID = SampleData.StudentID
join Courses on Courses.CourseID = SampleData.CourseID
order by Courses.CourseName;

select 
	avg(Grades.Grade) as AVG_Grade,
    Courses.CourseName as Course_Name
from SampleData
join Courses on Courses.CourseID = SampleData.CourseID
join Grades on Grades.GradeID = SampleData.GradeID
group by Courses.CourseName
order by avg(Grades.Grade);


select 
	 Students.StudentName as Student_Name,
	 Profs.ProfName as Professor_Name, 
	 COUNT(Courses.CourseName) as Number_of_courses
from SampleData
join Courses on Courses.CourseID = SampleData.CourseID
join Students on Students.StudentID = SampleData.StudentID
join Profs on Profs.ProfID = SampleData.ProfID
group by Students.StudentName, Profs.ProfName
order by COUNT(Courses.CourseName) desc
limit 1