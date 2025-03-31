-- 1. Get faculty first names where the department is 'Computer Science'
SELECT Fname
FROM FACULTY
WHERE Department = 'Computer Science';

-- 2. Get faculty first names where Advisor in CS_DEPARTMENT is 'Chair'
SELECT Fname
FROM CIS
WHERE CS_DEPARTMENT.Advisor = 'Chair';

-- 3. Get student first names where major is in CY and class is 'freshman'
SELECT S.Fname
FROM STUDENT S
JOIN CY_Has_majors CY ON S.Student_ID = CY.Student_ID
WHERE S.Class = 'freshman';

-- 4. Get course names where registered students are less than 15
SELECT Cname
FROM COURSE
WHERE CURR_SECTION.Registered_students < 15;

-- 5. Get student first names majoring in 'Computer Science', class is 'senior', and GPA is greater than 3.5
SELECT S.Fname
FROM STUDENT S
JOIN DEPARTMENT D ON S.Majors_in = D.Dname
WHERE D.Dname = 'Computer Science' AND S.Class = 'senior' AND S.GPA > 3.5;

-- 6. Get student first names majoring in 'CIS', ordered by GPA in ascending order
SELECT Fname
FROM STUDENT
WHERE Majors_in = 'CIS'
ORDER BY GPA ASC
LIMIT 10;

-- 7. Get average GPA of courses where registered students are greater than or equal to 30
SELECT AVG(GPA)
FROM STUDENT
WHERE Student_ID IN (
    SELECT Registered_students
    FROM COURSES
    WHERE Registered_students >= 30
);
