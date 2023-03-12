1.Найти ФИО клиентов из таблицы client, у которых нет ни одной карты в таблице card, результат отсортировать по ФИО;

SELECT client.fio FROM client 
LEFT JOIN card ON client.id = card.client_id
WHERE card.id IS NULL
ORDER BY client.fio

2. Найти ФИО клиентов, у которых имеется более двух карт;

SELECT client.fio FROM client
JOIN card ON client.id = card.client_id
GROUP BY client.id
HAVING COUNT(card.client_id) > 2

3. Вывести список клиентов, у которых есть и карта Visa (cardnumber начинается на «4»), и карта Mastercard (cardnumber начинается на «5»);

WITH card_vis_mast AS (
 SELECT 
    client_id, 
    id 
 FROM card 
 WHERE cardnumber like '4%' 
 GROUP BY client_id
 
 UNION ALL 
 
 SELECT 
    client_id, 
    id 
 FROM card 
 WHERE cardnumber like '5%' 
 GROUP BY client_id
 )
 SELECT * 
 FROM client 
 WHERE EXISTS(SELECT client_id 
              FROM card_vis_mast
              WHERE client_id = client.id
              GROUP BY client_id
              HAVING COUNT(client_id) > 1);

4. Вывести список клиентов, фамилия которых начинается на «П» и заканчивается на «В»;

SELECT * FROM client 
WHERE UPPER(SUBSTR(fio,1,INSTR(fio,' ')-1)) LIKE 'П%В'

5. Вывести список всех клиентов с признаком совершеннолетия в формате: client.fio, client.date_of_birth, isAdult («+» если клиенту
18 и более лет; «-» если клиент моложе 18 лет);

SELECT 
    fio,
    date_of_birth,
    CASE
        WHEN date_of_birth IS null THEN null
        WHEN MONTH_BETWEEN(SYSDATE,date_of_birth)/12 >= 18 THEN '+'
        ELSE '-'
    END isAdult
FROM client
