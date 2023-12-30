---1.WRITE SQL QUERY TO FIND OUT.
   --1.NUMBER OF MATCHES "PLAYED" BY EACH TEAM.
   --2.NUMBER OF MATCHES "WON" BY EACH TEAM.
   --3.NUMBER OF MATCHES "LOST" BY EACH TEAM.
CREATE TABLE cricket
(
MATCH_NO INT,
TEAM_A VARCHAR2(20),
TEAM_B VARCHAR2(20),
WINNER VARCHAR2(20)
);

INSERT ALL
INTO CRICKET VALUES(1,'WESTINDIES','SRILANKA','WESTINDIES')
INTO CRICKET VALUES(2,'INDIA','SRILANKA','INDIA')
INTO CRICKET VALUES(3,'AUSTRALIA','SRILANKA','AUSTRALIA')
INTO CRICKET VALUES(4,'WESTINDIES','SRILANKA','SRILANKA')
INTO CRICKET VALUES(5,'AUSTRALIA','INDIA','AUSTRALIA')
INTO CRICKET VALUES(6,'WESTINDIES','SRILANKA','WESTINDIES')
INTO CRICKET VALUES(7,'INDIA','WESTINDIES','WESTINDIES')
INTO CRICKET VALUES(8,'WESTINDIES','AUSTRALIA','AUSTRALIA')
INTO CRICKET VALUES(9,'WESTINDIES','INDIA','INDIA')
INTO CRICKET VALUES(10,'AUSTRALIA','WESTINDIES','WESTINDIES')
INTO CRICKET VALUES(11,'WESTINDIES','SRILANKA','WESTINDIES')
INTO CRICKET VALUES(12,'INDIA','AUSTRALIA','INDIA')
INTO CRICKET VALUES(13,'SRILANKA','NEWZZELAND','NEWZZELAND')
INTO CRICKET VALUES(14,'NEWZZELAND','INDIA','INDIA')
SELECT * FROM DUAL;

WITH DT AS (
                SELECT TEAM_A TEAM_NAME, (CASE WHEN TEAM_A=WINNER THEN 1 ELSE 0 END) MATCHES_WON1
                FROM CRICKET
                UNION ALL
                SELECT TEAM_B TEAM_NAME, (CASE WHEN TEAM_B=WINNER THEN 1 ELSE 0 END) MATCHES_WON1
                FROM CRICKET)
SELECT TEAM_NAME,COUNT(*) MATCHES_PLAYED, SUM(MATCHES_WON1) MATCHES_WON, (COUNT(*)-SUM(MATCHES_WON1)) MATCHES_LOST FROM DT
GROUP BY TEAM_NAME;


----2. FIND HOW MANY NEW CUSTOMER AND HOW MANY REPEATED CUSTOMER ARE PURCHSED EVERY DAY.
CREATE TABLE customer_orders (
order_id INTEGER,
customer_id INTEGER,
order_date DATE,
order_amount INTEGER
);

SELECT * FROM customer_orders;

WITH DT AS(
SELECT CUSTOMER_ID , MIN(ORDER_DATE) FIRST_ORDER FROM customer_orders
GROUP BY CUSTOMER_ID)

SELECT CO.ORDER_DATE, SUM(CASE WHEN ORDER_DATE=FIRST_ORDER THEN 1 ELSE 0 END)FIRST_TIME_ORDER,
SUM(CASE WHEN ORDER_DATE<>FIRST_ORDER THEN 1 ELSE 0 END) REPEAT_ORDER
FROM customer_orders CO
INNER JOIN DT
ON CO.CUSTOMER_ID=DT.CUSTOMER_ID 
GROUP BY ORDER_DATE
ORDER BY ORDER_DATE;

----3.WRITE A QUERY TO FIND PERSONID, NAME, NUMBER OF FRIENDS, SUM OF MARKS OF PERSON WHO HAVE FRIENDS WITH TOTAL SCORE GRATER THAN 100.
SELECT * FROM PERSON;
SELECT * FROM FRIEND;

SELECT F.PERSONID, SUM(P.SCORE) TOTAL_FRIEND_SCORE,COUNT(*) NUMBER_OF_FRIENDS
FROM PERSON P
INNER JOIN FRIEND F
ON P.PERSONID=F.FRIENDID
GROUP BY f.personid
HAVING SUM(P.SCORE)>100;

---4.WRITE A SQL QUERY TO FIND THE CANCELLATION RATE OF REQUEST WITH UNBANNED USER (BOTH CLIENTS AND DRIVER MUST NOT BE BANNED) EACH DAY BETWEEN "2013-10-01"  AND "2013-10-03" ROUND CANCELLATION RATE TO TWO DECIMAL POINTS.
---THE CANCELLATION RATE IS COMPUTED BY DIVIDING THE NUMBER OF CANCELED (BY CLIENT OR DRIVER) REQUEST WITH UNBANNED USER BY THE TOTAL NUMBER OF REQUEST WITH UNBANNED USER ON THE DAY.

CREATE TABLE  trips 
(ID INT, 
client_id INT, 
driver_id INT, 
city_id INT, 
status VARCHAR(50), 
request_at VARCHAR(50));

CREATE TABLE USERS 
(users_id INT,
banned VARCHAR(50), 
ROLE VARCHAR(50));

select * from USERS;
select * from trips;

insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');


insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');


SELECT REQUEST_AT, count(case when  status in ('cancelled_by_driver','cancelled_by_client') then 1 else null end) as cancelled_trip_count,
count(*) total_trip,
round(count(case when  status in ('cancelled_by_driver','cancelled_by_client') then 1 else null end)/ count(*),2) cancelled_percent
FROM TRIPS T
INNER JOIN USERS C
ON C.USERS_ID=T.CLIENT_ID 
INNER JOIN USERS D
ON D.USERS_ID=T.DRIVER_ID
WHERE C.BANNED='No' and d.banned ='No'
group by REQUEST_AT;

---5. WRITE SQL QUERY TO FIND WINNER IN EACH GROUP.
---THE WINNER IN EACH GROUP IS THE PLAYER WHO SCORED THE MAXIMUM TOTAL POINTS WITHIN THE GROUP. IN THE CASE OF TIE.
--- THE LOWEST PLAYER_ID WINS.

CREATE TABLE players
(player_id INT,
GROUP_ID INT);

INSERT INTO players VALUES (15,1);
INSERT INTO players VALUES (25,1);
INSERT INTO players VALUES (30,1);
INSERT INTO players VALUES (45,1);
INSERT INTO players VALUES (10,2);
INSERT INTO players VALUES (35,2);
INSERT INTO players VALUES (50,2);
INSERT INTO players VALUES (20,3);
INSERT INTO players VALUES (40,3);


CREATE TABLE matches
(
match_id INT,
first_player INT,
second_player INT,
first_score INT,
second_score INT);


INSERT INTO matches VALUES (1,15,45,3,0);
INSERT INTO matches VALUES (2,30,25,1,2);
INSERT INTO matches VALUES (3,30,15,2,0);
INSERT INTO matches VALUES (4,40,20,5,2);
INSERT INTO matches VALUES (5,35,50,1,1);

select * from matches;
select * from players;

 WITH DT AS (
SELECT FIRST_PLAYER AS PLAYER, FIRST_SCORE AS SCORE
FROM matches
UNION ALL 
SELECT SECOND_PLAYER AS PLAYER, SECOND_SCORE AS SCORE
FROM matches),
DS AS (
SELECT PLAYER,SUM(SCORE) TOTAL_SCORE FROM DT
GROUP BY PLAYER
ORDER BY PLAYER)

SELECT * FROM (
SELECT DS.PLAYER, DS.TOTAL_SCORE, P.GROUP_ID,RANK() OVER(PARTITION BY P.GROUP_ID ORDER BY DS.TOTAL_SCORE  DESC,DS.PLAYER ASC) RANK   FROM DS
INNER JOIN PLAYERS P
ON P.PLAYER_ID=DS.PLAYER
ORDER BY P.GROUP_ID)
WHERE RANK=1;

---6.
CREATE TABLE USERSAMITH (
user_id         INT     ,
 join_date       DATE    ,
 favorite_brand  VARCHAR(50));

 CREATE TABLE ordersamith (
 order_id       INT     ,
 order_date     DATE    ,
 item_id        INT     ,
 buyer_id       INT     ,
 seller_id      INT 
 );

 CREATE TABLE items
 (
 item_id        INT     ,
 item_brand     VARCHAR(50)
 );

select * from items;
select * from ordersamith;
select * from USERSAMITH;

 insert into USERSAMITH values (1,'01-01-2019','Lenovo');
 insert into USERSAMITH values(2,'09-02-2019','Samsung');
 insert into USERSAMITH values(3,'19-01-2019','LG');
 insert into USERSAMITH values(4,'21-05-2019','HP');

 insert into items values (1,'Samsung');
 insert into items values(2,'Lenovo');
 insert into items values(3,'LG');
 insert into items values(4,'HP');

 insert into ordersamith values (1,'01-08-2019',4,1,2);
 insert into ordersamith values(2,'02-08-2019',2,1,3);
 insert into ordersamith values(3,'03-08-2019',3,2,3);
 insert into ordersamith values(4,'04-08-2019',1,4,2);
 insert into ordersamith values(5,'04-08-2019',1,3,4);
 insert into ordersamith values(6,'05-08-2019',2,2,4);








