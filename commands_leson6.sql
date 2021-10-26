-- 1. Покажите информацию по потокам. В отчет выведите номер потока, название курса и дату начала занятий.

SELECT streams.number AS 'Номер потока', 
    courses.name AS 'Название курса',
    started_at AS 'Дата начала'
FROM streams
    JOIN courses
        ON streams.course_id = courses.id ;

-- 2. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и количество учеников по всем потокам курса.

SELECT courses.name AS 'Название курса',
    SUM (streams.students_amount)  AS 'Колличество учеников'
FROM streams
    JOIN courses
        ON  streams.course_id = courses.id 
GROUP BY courses.name  ; 

-- 3. Для всех учителей найдите среднюю оценку по всем проведённым потокам. В отчёт выведите идентификатор, фамилию и имя учителя, среднюю оценку по всем проведенным потокам.
--  Важно чтобы учителя, у которых не было потоков, также попали в выборку


SELECT  teachers.id, 
    teachers.surname AS 'Фамилия', 
    teachers.name AS 'Имя',
    AVG(grades.performance)
FROM teachers
    LEFT JOIN grades 
        ON teachers.id=grades.teacher_id 
GROUP BY teachers.id ;

-- 4. Дополнительное задание. Для каждого преподавателя выведите имя, фамилию, минимальное значение успеваемости по всем потокам преподавателя, 
-- название курса, который соответствует потоку с минимальным значением успеваемости, максимальное значение успеваемости по всем потокам преподавателя, 
-- название курса, соответствующий потоку с максимальным значением успеваемости, дату начала следующего потока.


SELECT 
    teachers.surname,
    teachers.name,
    MIN(grades.performance) AS 'Успеваемость MIN',
    courses.name AS 'Курс',
    MAX(grades.performance) AS 'Успеваемость MAX ',
    courses.name AS 'Курс',
    streams.started_at
FROM grades
    JOIN teachers
        ON grades.teacher_id=teachers.id
    LEFT JOIN streams
        ON grades.stream_id=streams.id
    JOIN courses
        ON streams.course_id=courses.id
GROUP BY teachers.id  ;

-- Не понимаю , как можно в обном запросе без селектов сделать разное значение courses.name и без UNION !!!!!



-- dfsdlfkl

curl -H "Content-Type:application/json" -H "Accept:application/json"  -u basis:basis2020 http://teamcity-bssdev.rt.ru/app/rest/builds?locator=running:true  | jq '.build[].branchName'  | tr -d '"'

