1.Найти ФИО клиентов из таблицы client, у которых нет ни одной карты в таблице card, результат отсортировать по ФИО;

SELECT client.fio FROM client 
LEFT JOIN card ON client.id = card.client_id
WHERE card.client_id IS NULL
ORDER BY client.fio

2. Найти ФИО клиентов, у которых имеется более двух карт;

SELECT client.fio FROM client
JOIN card ON client.id = card.client_id
GROUP BY client.fio
HAVING COUNT(card.id) > 2

3. Вывести список клиентов, у которых есть и карта Visa (cardnumber начинается на «4»), и карта Mastercard (cardnumber начинается на «5»);

SELECT client.fio FROM client
JOIN card ON client.id = card.client_id
WHERE card.cardnumber LIKE '4%' AND '5%'
GROUP BY client.fio

4. Вывести список клиентов, фамилия которых начинается на «П» и заканчивается на «В»;

SELECT client.fio FROM client
WHERE UPPER(client.fio) LIKE ('П%В %% %%')

5. Вывести список всех клиентов с признаком совершеннолетия в формате: client.fio, client.date_of_birth, isAdult («+» если клиенту
18 и более лет; «-» если клиент моложе 18 лет);
