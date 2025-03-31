-- 1. Retrieve the names of all students enrolled in 'Database Systems' course.
SELECT S.Fname, S.Lname
FROM STUDENT S
JOIN ENROLLMENT E ON S.Student_ID = E.Student_ID
JOIN COURSE C ON E.Course_ID = C.Course_ID
WHERE C.Cname = 'Database Systems';

-- 2. Retrieve the list of faculty members who have more than 3 years of experience.
SELECT Fname, Lname, Experience
FROM FACULTY
WHERE Experience > 3;

-- 3. Get the total number of students in each department.
SELECT D.Dname, COUNT(S.Student_ID) AS Total_Students
FROM STUDENT S
JOIN DEPARTMENT D ON S.Majors_in = D.Dname
GROUP BY D.Dname;

-- 4. Find the department that has the maximum number of students.
SELECT D.Dname, COUNT(S.Student_ID) AS Total_Students
FROM STUDENT S
JOIN DEPARTMENT D ON S.Majors_in = D.Dname
GROUP BY D.Dname
ORDER BY Total_Students DESC
LIMIT 1;

-- 5. Get the average salary of faculty members in each department.
SELECT D.Dname, AVG(F.Salary) AS Avg_Salary
FROM FACULTY F
JOIN DEPARTMENT D ON F.Department = D.Dname
GROUP BY D.Dname;

-- 6. Retrieve the course names along with the number of students enrolled in each course.
SELECT C.Cname, COUNT(E.Student_ID) AS Enrolled_Students
FROM COURSE C
JOIN ENROLLMENT E ON C.Course_ID = E.Course_ID
GROUP BY C.Cname;

-- 7. List the students who have enrolled in more than 3 courses.
SELECT S.Fname, S.Lname, COUNT(E.Course_ID) AS Total_Courses
FROM STUDENT S
JOIN ENROLLMENT E ON S.Student_ID = E.Student_ID
GROUP BY S.Student_ID, S.Fname, S.Lname
HAVING COUNT(E.Course_ID) > 3;

-- 8. Retrieve faculty members who are not assigned to any department.
SELECT Fname, Lname
FROM FACULTY
WHERE Department IS NULL;

-- 9. Retrieve the names of students who have a GPA greater than the department’s average GPA.
SELECT S.Fname, S.Lname, S.GPA, D.Dname
FROM STUDENT S
JOIN DEPARTMENT D ON S.Majors_in = D.Dname
WHERE S.GPA > (
    SELECT AVG(S1.GPA)
    FROM STUDENT S1
    WHERE S1.Majors_in = D.Dname
);

-- 10. Get the details of students who are enrolled in all courses of their major department.
SELECT S.Student_ID, S.Fname, S.Lname
FROM STUDENT S
WHERE NOT EXISTS (
    SELECT C.Course_ID
    FROM COURSE C
    WHERE C.Department = S.Majors_in
    EXCEPT
    SELECT E.Course_ID
    FROM ENROLLMENT E
    WHERE E.Student_ID = S.Student_ID
);

-- 11. Retrieve the top 5 highest-paid faculty members.
SELECT Fname, Lname, Salary
FROM FACULTY
ORDER BY Salary DESC
LIMIT 5;

-- 12. Retrieve the student(s) with the highest GPA.
SELECT Fname, Lname, GPA
FROM STUDENT
WHERE GPA = (SELECT MAX(GPA) FROM STUDENT);

-- 13. Get the names of courses that are being taught by at least two different faculty members.
SELECT C.Cname
FROM COURSE C
JOIN TEACHES T ON C.Course_ID = T.Course_ID
GROUP BY C.Cname
HAVING COUNT(DISTINCT T.Faculty_ID) >= 2;

-- 14. Retrieve the names of students who are enrolled in at least one course taught by 'Dr. Smith'.
SELECT DISTINCT S.Fname, S.Lname
FROM STUDENT S
JOIN ENROLLMENT E ON S.Student_ID = E.Student_ID
JOIN TEACHES T ON E.Course_ID = T.Course_ID
JOIN FACULTY F ON T.Faculty_ID = F.Faculty_ID
WHERE F.Fname = 'Dr. Smith';

-- 15. Retrieve the faculty member who teaches the most courses.
SELECT F.Fname, F.Lname, COUNT(T.Course_ID) AS Total_Courses
FROM FACULTY F
JOIN TEACHES T ON F.Faculty_ID = T.Faculty_ID
GROUP BY F.Faculty_ID, F.Fname, F.Lname
ORDER BY Total_Courses DESC
LIMIT 1;

-- 16. Get the list of students who are not enrolled in any course.
SELECT Fname, Lname
FROM STUDENT
WHERE Student_ID NOT IN (SELECT Student_ID FROM ENROLLMENT);

-- 17. Get the course(s) with the highest number of enrolled students.
SELECT C.Cname, COUNT(E.Student_ID) AS Enrolled_Students
FROM COURSE C
JOIN ENROLLMENT E ON C.Course_ID = E.Course_ID
GROUP BY C.Cname
ORDER BY Enrolled_Students DESC
LIMIT 1;

-- 18. Retrieve the number of courses offered in each department.
SELECT D.Dname, COUNT(C.Course_ID) AS Total_Courses
FROM DEPARTMENT D
JOIN COURSE C ON D.Dname = C.Department
GROUP BY D.Dname;

-- 19. Find students who share the same last name.
SELECT Lname, COUNT(*) AS Student_Count
FROM STUDENT
GROUP BY Lname
HAVING COUNT(*) > 1;

-- 20. Retrieve the name of the department that has the lowest number of courses.
SELECT D.Dname, COUNT(C.Course_ID) AS Total_Courses
FROM DEPARTMENT D
JOIN COURSE C ON D.Dname = C.Department
GROUP BY D.Dname
ORDER BY Total_Courses ASC
LIMIT 1;
