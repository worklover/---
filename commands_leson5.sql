-- 1. Найдите потоки, количество учеников в которых больше или равно 40. В отчет выведите номер потока, название курса и количество учеников.

SELECT number AS 'Номер потока',
    (SELECT name FROM courses WHERE streams.course_id=id) AS 'Название курса' , 
    students_amount AS 'Количество учеников'   
FROM streams
WHERE students_amount >= 40;

-- 2. Найдите два потока с самыми низкими значениями успеваемости. В отчет выведите номер потока, название курса, фамилию и имя преподавателя (одним столбцом), оценку успеваемости.

SELECT 
    (SELECT number FROM streams WHERE grades.stream_id=id) AS 'Номер поток' ,
    (SELECT name FROM courses WHERE 
        (SELECT course_id FROM streams WHERE grades.stream_id=id)=id) AS 'Название курса',
    (SELECT name || ' ' || surname  FROM teachers WHERE grades.teacher_id=id ) AS 'Преподаватель',
    performance AS 'Успеваемость'
FROM grades ORDER BY performance ASC LIMIT 2 ;

-- 3. Найдите среднюю успеваемость всех потоков преподавателя Николая Савельева. В отчёт выведите идентификатор преподавателя и среднюю оценку по потокам.

SELECT 
    teacher_id AS 'Идентификатор преподавателя',
    AVG(performance) AS 'Средняя оценка по потокам'
FROM grades 
WHERE  grades.teacher_id=
    (SELECT id  FROM teachers WHERE name='Николай' AND surname='Савельев' ) ;

-- 4. Найдите потоки преподавателя Натальи Петровой, а также потоки, по которым успеваемость ниже 4.8. В отчёт выведите идентификатор потока, фамилию и имя преподавателя.

SELECT 
    stream_id, 
    (SELECT surname || ' ' || name FROM teachers WHERE grades.teacher_id=id)
FROM grades
WHERE
    grades.teacher_id=
    (SELECT id  FROM teachers WHERE name='Наталья' AND surname='Петрова' ) 
UNION 
SELECT 
    stream_id,
    (SELECT surname || ' ' || name FROM teachers WHERE grades.teacher_id=id)
FROM grades
WHERE performance < 4.8 ;

--  5. Дополнительное задание. Найдите разницу между средней успеваемостью преподавателя с наивысшим соответствующим значением и средней успеваемостью преподавателя с наименьшим значением. Средняя успеваемость считается по всем потокам преподавателя.

SELECT teacher_id, 
    AVG(performance)  - (SELECT MAX(performance) FROM grades)  AS 'Разница'
FROM grades GROUP BY teacher_id 
UNION
SELECT teacher_id, 
    AVG(performance)  -  (SELECT MIN(performance) FROM grades) AS 'Разница' 
FROM grades GROUP BY teacher_id ;



