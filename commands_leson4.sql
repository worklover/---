SELECT CURRENT_TIMESTAMP
SELECT SUBSTR (started_at, 7, 4) || '-' || SUBSTR (started_at, 4,2) || '-' || SUBSTR (started_at , 1,2 ) FROM streams  ;
-- Преобразовать дату начала потока в таблице потоков к виду год-месяц-день. Используйте команду UPDATE.
UPDATE streams SET started_at =  SUBSTR (started_at, 7, 4) || '-' || SUBSTR (started_at, 4,2) || '-' || SUBSTR (started_at , 1,2 )  ;
-- Получите идентификатор и номер потока, запланированного на самую позднюю дату.
SELECT id, number, MAX(started_at) from streams ;
-- Покажите уникальные значения года по датам начала потоков обучения.
SELECT SUBSTR (started_at, 1,4) AS year FROM streams GROUP BY year ;
-- Найдите количество преподавателей в базе данных. Выведите искомое значение в столбец с именем total_teachers.
SELECT count(*) AS total_teachers  from teachers ;
-- Покажите даты начала двух последних по времени потоков.
SELECT started_at  from streams ORDER BY started_at DESC LIMIT 2;
-- Найдите среднюю успеваемости учеников по потокам преподавателя с идентификатором равным 1.
SELECT teacher_id, stream_id, AVG (performance)  from grades WHERE teacher_id = 1  ;
-- Дополнительное задание (выполняется по желанию): найдите идентификаторы преподавателей, у которых средняя успеваемость по всем потокам меньше 4.8.
SELECT teacher_id,  AVG(performance) as avg  FROM grades GROUP BY teacher_id HAVING avg < 4.8  ;
