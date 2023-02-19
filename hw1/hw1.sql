-- STUDENT number. UPDATE ONLY, DO NOT DELETE. 
select "1004890";
-- Replace the above with your student number

-- DATA LOADING Seperator. DO NOT DELETE
select "DATA LOADING";
-- Put your table creation annd data loading SQL statements here
CREATE TABLE weekdays (
did INT not null,
day_of_week VARCHAR(255),
PRIMARY KEY (did)
);
LOAD DATA INFILE 'weekdays.csv' INTO TABLE weekdays FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

CREATE TABLE flights ( fid INT not null, year INT, month_id INT, day_of_month INT, day_of_week_id INT, carrier_id VARCHAR(255), flight_num INT, origin_city VARCHAR(255), origin_state VARCHAR(255), dest_city VARCHAR(255), dest_state VARCHAR(255), departure_delay float, taxi_out float, arrival_delay float, cancelled INT, actual_time float, distance float, PRIMARY KEY (fid) );
LOAD DATA INFILE 'flights-small.csv' INTO TABLE flights FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

CREATE TABLE carriers ( 
cid VARCHAR(255) not null,
name VARCHAR(255),
PRIMARY KEY (cid)
);
LOAD DATA INFILE 'carriers.csv' INTO TABLE carriers FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

CREATE TABLE months (
mid INT not null,
month VARCHAR(255),
PRIMARY KEY (mid)
);
LOAD DATA INFILE 'months.csv' INTO TABLE months FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';


-- QUESTION 1 Seperator. DO NOT DELETE
select "QUESTION 1";
-- Put your Q1 SQL statements here
SELECT DISTINCT flights.flight_num FROM flights 
INNER JOIN carriers ON flights.carrier_id=carriers.cid 
INNER JOIN weekdays ON flights.day_of_week_id=weekdays.did 
WHERE origin_city='Seattle WA' 
AND dest_city='Boston MA' 
AND carriers.name='Alaska Airlines Inc.' 
AND weekdays.day_of_week='Monday';
/* 
+------------+
| flight_num |
+------------+
|         12 |
|         24 |
|        734 |
+------------+
3 rows in set (0.778 sec)
*/

-- QUESTION 2 Seperator. DO NOT DELETE
select "QUESTION 2";
-- Put your Q2 SQL statements here
SELECT AVG(arrival_delay), weekdays.day_of_week FROM flights 
INNER JOIN weekdays ON flights.day_of_week_id=weekdays.did 
GROUP BY day_of_week_id 
ORDER BY AVG(arrival_delay) DESC 
LIMIT 3;
/*
+--------------------+-------------+
| AVG(arrival_delay) | day_of_week |
+--------------------+-------------+
| 13.342771666868126 | Wednesday   |
| 12.264613086345982 | Thursday    |
| 11.726181691331357 | Tuesday     |
+--------------------+-------------+
3 rows in set (1.184 sec)
*/

-- QUESTION 3 Seperator. DO NOT DELETE
select "QUESTION 3";
-- Put your Q3 SQL statements here
SELECT DISTINCT carriers.name FROM flights 
INNER JOIN carriers ON flights.carrier_id=carriers.cid 
GROUP BY year, month_id, day_of_month, carriers.name 
HAVING count(*)>1000;
/*
+------------------------------+
| name                         |
+------------------------------+
| American Airlines Inc.       |
| Comair Inc.                  |
| Delta Air Lines Inc.         |
| Envoy Air                    |
| Northwest Airlines Inc.      |
| SkyWest Airlines Inc.        |
| Southwest Airlines Co.       |
| United Air Lines Inc.        |
| US Airways Inc.              |
| ExpressJet Airlines Inc. (1) |
| ExpressJet Airlines Inc.     |
+------------------------------+
11 rows in set (1.656 sec)
*/

-- QUESTION 4 Seperator. DO NOT DELETE
select "QUESTION 4";
-- Put your Q4 SQL statements here
SELECT SUM(departure_delay), carriers.name FROM flights 
INNER JOIN carriers ON flights.carrier_id=carriers.cid 
GROUP BY carriers.name;
/*
+----------------------+------------------------------------------------------------------------------------+
| SUM(departure_delay) | name                                                                               |
+----------------------+------------------------------------------------------------------------------------+
|               473993 | AirTran Airways Corporation                                                        |
|               285111 | Alaska Airlines Inc.                                                               |
|               173255 | America West Airlines Inc. (Merged with US Airways 9/05. Stopped reporting 10/07.) |
|              1849386 | American Airlines Inc.                                                             |
|                38676 | ATA Airlines d/b/a ATA                                                             |
|               282042 | Comair Inc.                                                                        |
|               414226 | Continental Air Lines Inc.                                                         |
|              1601314 | Delta Air Lines Inc.                                                               |
|               771679 | Envoy Air                                                                          |
|               934691 | ExpressJet Airlines Inc.                                                           |
|               483171 | ExpressJet Airlines Inc. (1)                                                       |
|               165126 | Frontier Airlines Inc.                                                             |
|                  386 | Hawaiian Airlines Inc.                                                             |
|               201418 | Independence Air                                                                   |
|               435562 | JetBlue Airways                                                                    |
|               531356 | Northwest Airlines Inc.                                                            |
|               682158 | SkyWest Airlines Inc.                                                              |
|              3056656 | Southwest Airlines Co.                                                             |
|               167894 | Spirit Air Lines                                                                   |
|              1483777 | United Air Lines Inc.                                                              |
|               577268 | US Airways Inc.                                                                    |
|                52597 | Virgin America                                                                     |
+----------------------+------------------------------------------------------------------------------------+
22 rows in set (1.697 sec)
*/

-- QUESTION 5 Seperator. DO NOT DELETE
select "QUESTION 5";
-- Put your Q5 SQL statements here
SELECT carriers.name, AVG(flights.cancelled) FROM flights 
INNER JOIN carriers ON flights.carrier_id=carriers.cid 
WHERE flights.origin_city='New York NY' 
GROUP BY carriers.cid 
HAVING AVG(flights.cancelled)>0.005 
ORDER BY AVG(flights.cancelled) ASC;
/*
+------------------------------------------------------------------------------------+------------------------+
| name                                                                               | AVG(flights.cancelled) |
+------------------------------------------------------------------------------------+------------------------+
| JetBlue Airways                                                                    |                 0.0104 |
| Continental Air Lines Inc.                                                         |                 0.0104 |
| AirTran Airways Corporation                                                        |                 0.0117 |
| America West Airlines Inc. (Merged with US Airways 9/05. Stopped reporting 10/07.) |                 0.0184 |
| Delta Air Lines Inc.                                                               |                 0.0189 |
| American Airlines Inc.                                                             |                 0.0199 |
| United Air Lines Inc.                                                              |                 0.0313 |
| US Airways Inc.                                                                    |                 0.0347 |
| ATA Airlines d/b/a ATA                                                             |                 0.0348 |
| Spirit Air Lines                                                                   |                 0.0411 |
| Independence Air                                                                   |                 0.0415 |
| Envoy Air                                                                          |                 0.0586 |
| ExpressJet Airlines Inc. (1)                                                       |                 0.0738 |
| Comair Inc.                                                                        |                 0.0770 |
| Northwest Airlines Inc.                                                            |                 0.0843 |
| ExpressJet Airlines Inc.                                                           |                 0.0877 |
+------------------------------------------------------------------------------------+------------------------+
16 rows in set (0.786 sec)
*/
