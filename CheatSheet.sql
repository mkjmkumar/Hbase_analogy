--Connect to phoenix shell
./sqlline.py localhost

--Show tables
0: jdbc:phoenix:localhost> !tables

--Create table
CREATE TABLE IF NOT EXISTS STOCK_SYMBOL (ID INTEGER NOT NULL PRIMARY KEY, DATE date, COMPANY VARCHAR, PRICE DECIMAL);

--Insert data Manually
UPSERT INTO STOCK_SYMBOL VALUES (1,'12-12-2016','SalesForce.com', 200);
UPSERT INTO STOCK_SYMBOL VALUES (2,'12-12-2016','CNN.com', 100);
UPSERT INTO STOCK_SYMBOL VALUES (3,'12-12-2016','GOOGLE.com', 20);
UPSERT INTO STOCK_SYMBOL VALUES (4,'12-12-2016','FACEBOOK.com', 120);
UPSERT INTO STOCK_SYMBOL VALUES (5,'12-12-2016','ERP.com', 99);

UPSERT INTO STOCK_SYMBOL VALUES (6,'13-12-2016','SalesForce.com', 200);
UPSERT INTO STOCK_SYMBOL VALUES (7,'13-12-2016','CNN.com', 100);
UPSERT INTO STOCK_SYMBOL VALUES (8,'13-12-2016','GOOGLE.com', 20);
UPSERT INTO STOCK_SYMBOL VALUES (9,'13-12-2016','FACEBOOK.com', 120);
UPSERT INTO STOCK_SYMBOL VALUES (10,'13-12-2016','ERP.com', 99);

UPSERT INTO STOCK_SYMBOL VALUES (11,'14-12-2016','FACEBOOK.com', 120);
UPSERT INTO STOCK_SYMBOL VALUES (12,'15-12-2016','ERP.com', 99);

--SELECT
SELECT * FROM STOCK_SYMBOL;

SELECT * FROM STOCK_SYMBOL; 
SELECT DISTINCT COMPANY FROM STOCK_SYMBOL; 
SELECT ID, COUNT(1) FROM STOCK_SYMBOL GROUP BY ID; 
SELECT COMPANY, SUM(PRICE) FROM STOCK_SYMBOL GROUP BY COMPANY HAVING COUNT(1) > 2; 
SELECT 'ID' COL, MAX(PRICE) AS MAX FROM STOCK_SYMBOL; 
SELECT * FROM STOCK_SYMBOL LIMIT 1000;

---Create Index
CREATE INDEX my_idx ON STOCK_SYMBOL(COMPANY DESC);
CREATE INDEX my_idx ON log.event(created_date DESC) INCLUDE (name, payload) SALT_BUCKETS=10 
CREATE INDEX IF NOT EXISTS my_comp_idx ON server_metrics ( gc_time DESC, created_date DESC ) DATA_BLOCK_ENCODING='NONE',VERSIONS=?,MAX_FILESIZE=2000000 split on (?, ?, ?)


--Explain Commands
0: jdbc:phoenix:localhost> EXPLAIN SELECT * FROM STOCK_SYMBOL;
+------------------------------------------------------------------------+
|                                  PLAN                                  |
+------------------------------------------------------------------------+
| CLIENT 1-CHUNK PARALLEL 1-WAY ROUND ROBIN FULL SCAN OVER STOCK_SYMBOL  |
+------------------------------------------------------------------------+

0: jdbc:phoenix:localhost> explain select * from STOCK_SYMBOL where COMPANY = 'GOOGLE.com';
+------------------------------------------------------------------------+
|                                  PLAN                                  |
+------------------------------------------------------------------------+
| CLIENT 1-CHUNK PARALLEL 1-WAY ROUND ROBIN FULL SCAN OVER STOCK_SYMBOL  |
|     SERVER FILTER BY COMPANY = 'GOOGLE.com'                            |
+------------------------------------------------------------------------+
2 rows selected (0.023 seconds)
