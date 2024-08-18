-- HW 12 08 2024 --
	USE Academy
	GO
--1. Вивести кількість викладачів кафедри «Software Development».
SELECT COUNT(T.Id) AS TeacherCount
FROM Teachers AS T
JOIN Lectures AS L ON T.Id = L.TeacherId
JOIN GroupsLectures AS GL ON L.Id = GL.LecturesId
JOIN Groups AS G ON GL.GroupId = G.Id
JOIN Departments AS D ON G.DepartmentId = D.Id
WHERE D.Name = N'Department of AI Systems'; -- ЗАМЕНА)
GO
--2. Вивести кількість лекцій, які читає викладач “Dave McQueen”. // ЗАМЕНИЛ НА СТОИХ
SELECT COUNT(S.Id) AS LecturesCount
FROM Subjects AS S
JOIN Lectures AS L ON L.SubjectId = S.Id
JOIN Teachers AS T ON L.TeacherId = T.Id
WHERE CONCAT(T.Name,' ',T.Surname) = N'Susan Wilson';
GO
--3. Вивести кількість занять, які проводяться в аудиторії “D201”.
SELECT COUNT(S.Id) AS SubjectsCount
FROM Subjects AS S
JOIN Lectures AS L ON L.SubjectId = S.Id
WHERE L.LectureRoom = N'Room 101';
GO
--4. Вивести назви аудиторій та кількість лекцій, що проводяться в них.
INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId) VALUES (N'Room 101', 1, 1);
INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId) VALUES (N'Room 101', 3, 2);
GO
SELECT LectureRoom, COUNT(*) AS LectureCount
FROM Lectures
GROUP BY LectureRoom;
GO
--5. Вивести кількість студентів, які відвідують лекції викладача “Jack Underhill”.
 CREATE TABLE Students
 (
	Id INT PRIMARY KEY IDENTITY (1,1),
	Name NVARCHAR(MAX) NOT NULL CHECK (Name != N''),
    Surname NVARCHAR(MAX) NOT NULL CHECK (Surname != N''),
    Age INT NOT NULL CHECK (Age >= 18),
	GroupId INT FOREIGN KEY REFERENCES Groups(Id) NOT NULL
 )
 INSERT INTO Students (Name, Surname, Age, GroupId) VALUES
(N'John', N'Doe', 19, 1),
(N'Jane', N'Smith', 20, 1),
(N'Michael', N'Johnson', 21, 1),
(N'Emily', N'Davis', 22, 1),
(N'Chris', N'Brown', 23, 1),

(N'Alice', N'Wilson', 18, 2),
(N'Bob', N'Moore', 19, 2),
(N'Eva', N'Taylor', 20, 2),
(N'Nick', N'Anderson', 21, 2),
(N'Laura', N'Thomas', 22, 2),

(N'Sam', N'Jackson', 23, 3),
(N'Emma', N'White', 19, 3),
(N'Owen', N'Harris', 20, 3),
(N'Mia', N'Martin', 21, 3),
(N'Liam', N'Thompson', 22, 3),

(N'Ella', N'Garcia', 18, 4),
(N'Oliver', N'Martinez', 19, 4),
(N'Sophia', N'Robinson', 20, 4),
(N'Lucas', N'Clark', 21, 4),
(N'Ava', N'Rodriguez', 22, 4),

(N'Noah', N'Lewis', 23, 5),
(N'Grace', N'Lee', 18, 5),
(N'Mason', N'Walker', 19, 5),
(N'Isabella', N'Allen', 20, 5),
(N'James', N'Young', 21, 5),

(N'Lily', N'Hall', 22, 6),
(N'Ethan', N'Hernandez', 23, 6),
(N'Madison', N'King', 18, 6),
(N'Ryan', N'Wright', 19, 6),
(N'Chloe', N'Lopez', 20, 6),

(N'Adam', N'Hill', 21, 7),
(N'Sarah', N'Scott', 22, 7),
(N'Joshua', N'Green', 23, 7),
(N'Olivia', N'Adams', 18, 7),
(N'Aiden', N'Baker', 19, 7),

(N'Charlotte', N'Gonzalez', 20, 8),
(N'Dylan', N'Nelson', 21, 8),
(N'Ella', N'Carter', 22, 8),
(N'Jackson', N'Mitchell', 23, 8),
(N'Aubrey', N'Perez', 18, 8),

(N'Caleb', N'Roberts', 19, 9),
(N'Harper', N'Turner', 20, 9),
(N'Elijah', N'Phillips', 21, 9),
(N'Zoe', N'Campbell', 22, 9),
(N'Alexander', N'Parker', 23, 9),

(N'Liam', N'Evans', 18, 10),
(N'Sophia', N'Edwards', 19, 10),
(N'Benjamin', N'Collins', 20, 10),
(N'Isabella', N'Stewart', 21, 10),
(N'Henry', N'Morris', 22, 10);

SELECT COUNT(DISTINCT S.Id) AS StudentCount
FROM Students AS S
JOIN GroupsLectures AS GL ON S.GroupId = GL.GroupId
JOIN Lectures AS L ON GL.LecturesId = L.Id
JOIN Teachers AS T ON L.TeacherId = T.Id
WHERE CONCAT(T.Name,' ',T.Surname) ='Linda Williams';

--6. Вивести середню ставку викладачів факультету Computer
--Science.
SELECT AVG(T.Salary) AS TechSalaryAVG
FROM Teachers AS T
JOIN Lectures AS L ON L.TeacherId = T.Id
JOIN GroupsLectures AS GL ON GL.LecturesId = L.Id
JOIN Groups AS G ON GL.GroupId =G.Id
JOIN Departments AS D ON G.DepartmentId = D.Id
WHERE D.Name = N'Department of Data Analysis';
GO
--7. Вивести мінімальну та максимальну кількість студентів
--серед усіх груп.
INSERT INTO Students (Name, Surname, Age, GroupId) VALUES
(N'John', N'Doe', 19, 2),
(N'Jane', N'Smith', 20, 2),
(N'Michael', N'Johnson', 21, 3),
(N'Emily', N'Davis', 22, 4),
(N'Chris', N'Brown', 23, 5);

SELECT MIN(StudentCount) AS MINST, max(studentCount) AS MAXST
FROM (SELECT COUNT(Students.Id) AS StudentCount FROM Students
JOIN Groups AS G ON G.Id = Students.GroupId
GROUP BY G.Id) Groups;
GO

--8. Вивести середній фонд фінансування кафедр.
SELECT AVG(Financing) AS AVGFIN FROM Departments;
GO
--9. Вивести повні імена викладачів та кількість читаних ними
--дисциплін.
SELECT CONCAT(T.Name, ' ', T.Surname) AS Teacher, COUNT(S.Id) AS CountSubj 
FROM Teachers AS T
JOIN Lectures AS L ON L.TeacherId = T.Id
JOIN Subjects AS S ON S.Id = L.SubjectId
GROUP BY CONCAT(T.Name, ' ', T.Surname)

--10. Вивести кількість лекцій щодня протягом тижня.
CREATE TABLE Dayofweek(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Day NVARCHAR(20) NOT NULL CHECK(Day != N'')
	)
INSERT INTO Dayofweek (Day) VALUES
('Monday'),('Tuesday'),('Wednesday'),('Thursday'),('Friday');
GO
ALTER TABLE GroupsLectures
ADD DayofweekId INT FOREIGN KEY REFERENCES Dayofweek(Id);
GO

SELECT Day.Day AS DayOfWeek, COUNT(L.Id) AS CountLect
FROM Dayofweek AS Day
JOIN GroupsLectures AS GL ON GL.DayofweekId = Day.Id
JOIN Lectures AS L ON L.Id = GL.LecturesId
GROUP BY Day.Day

GO
--11. Вивести номери аудиторій та кількість кафедр, чиї лекції
--в них читаються.
SELECT L.LectureRoom, COUNT(D.Id) AS DepCount
FROM Lectures AS L
JOIN GroupsLectures AS GL ON GL.LecturesId = L.Id
JOIN Groups AS G ON G.Id = GL.GroupId
JOIN Departments AS D ON D.Id = G.DepartmentId
GROUP BY L.LectureRoom
GO
--12.Вивести назви факультетів та кількість дисциплін, які на
--них читаються.
SELECT F.Name AS FacultName, COUNT(S.Id) AS SubjCount
FROM Faculties AS F
JOIN Departments AS D ON D.FacultyId = F.Id
JOIN Groups AS G ON G.DepartmentId = D.Id
JOIN GroupsLectures AS GL ON GL.GroupId = G.Id
JOIN Lectures AS L ON L.Id = GL.LecturesId
JOIN Subjects AS S ON L.SubjectId = L.Id
GROUP BY F.Name
GO
--13. Вивести кількість лекцій для кожної пари викладач-аудиторія.
SELECT CONCAT(T.Name,' ',T.Surname) AS Teacher, L.LectureRoom AS Room, COUNT(S.Id) AS LectCount
FROM Teachers AS T
JOIN Lectures AS L ON L.TeacherId= T.Id
JOIN Subjects AS S ON L.SubjectId = S.Id
GROUP BY CONCAT(T.Name,' ',T.Surname),L.LectureRoom