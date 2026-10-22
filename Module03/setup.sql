jaliahnamatovu@Jaliahs-MacBook-Air iot-portfolio-template % sqlite3 Module03/warehouse.db "SELECT 'orders', COUNT(*) FROM orders UNION ALL SELECT 'lines', COUNT(*) FROM order_line;"
orders|60000
lines|240000
jaliahnamatovu@Jaliahs-MacBook-Air iot-portfolio-template % jaliahnamatovu@Jaliahs-MacBook-Air iot-portfolio-template % sqlite3 Module03/warehouse.db "SELECT 'orders', COUNT(*) FROM orders UNION ALL SELECT 'lines', COUNT(*) FROM order_line;"
orders|60000
lines|2400 
zsh: command not found: jaliahnamatovu@Jaliahs-MacBook-Air
zsh: command not found: orders
zsh: command not found: 60000
zsh: command not found: lines
zsh: command not found: 2400
jaliahnamatovu@Jaliahs-MacBook-Air iot-portfolio-template % sqlite3 Module03/warehouse.db
SQLite version 3.51.0 2025-06-12 13:14:41
Enter ".help" for usage hints.
sqlite> EXPLAIN QUERY PLAN
   ...> SELECT c.city, 
   ...>        COUNT(DISTINCT c.customer_id) AS customers,
   ...>        SUM(ol.qty * p.price) AS revenue
   ...> FROM customer c
   ...> JOIN orders o      ON o.customer_id = c.customer_id
   ...> JOIN order_line ol ON ol.order_id = o.order_id
   ...> JOIN product p     ON p.product_id = ol.product_id
   ...> WHERE o.ordered_on >= '2025-01-01' AND o.ordered_on < '2026-01-01'
   ...> GROUP BY c.city
   ...> ORDER BY revenue DESC;
QUERY PLAN
|--SCAN ol
|--SEARCH o USING INTEGER PRIMARY KEY (rowid=?)
|--SEARCH c USING INTEGER PRIMARY KEY (rowid=?)
|--SEARCH p USING INTEGER PRIMARY KEY (rowid=?)
|--USE TEMP B-TREE FOR GROUP BY
|--USE TEMP B-TREE FOR count(DISTINCT)
`--USE TEMP B-TREE FOR ORDER BY
sqlite> .timer on
sqlite> SELECT c.city, 
   ...>        COUNT(DISTINCT c.customer_id) AS customers,
   ...>        SUM(ol.qty * p.price) AS revenue
   ...> FROM customer c
   ...> JOIN orders o      ON o.customer_id = c.customer_id
   ...> JOIN order_line ol ON ol.order_id = o.order_id
   ...> JOIN product p     ON p.product_id = ol.product_id
   ...> WHERE o.ordered_on >= '2025-01-01' AND o.ordered_on < '2026-01-01'
   ...> GROUP BY c.city
   ...> ORDER BY revenue DESC;
Bielefeld|500|11242176.0
Gütersloh|500|8422344.0
Münster|500|5493504.0
Paderborn|500|2815656.0
Run Time: real 0.120 user 0.101791 sys 0.008783
sqlite> CREATE INDEX idx_orders_ordered_on ON orders(ordered_on);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_order_line_order ON order_line(order_id);
CREATE INDEX idx_order_line_product ON order_line(product_id);Run Time: real 0.035 user 0.017671 sys 0.013356
sqlite> CREATE INDEX idx_orders_customer ON orders(customer_id);
Run Time: real 0.022 user 0.010591 sys 0.004573
sqlite> CREATE INDEX idx_order_line_order ON order_line(order_id);
Run Time: real 0.073 user 0.032007 sys 0.007218
sqlite> CREATE INDEX idx_order_line_product ON order_line(product_id);
Run Time: real 0.040 user 0.032717 sys 0.004823
sqlite> EXPLAIN QUERY PLAN
SELECT c.city, 
       COUNT(DISTINCT c.customer_id) AS customers,
       SUM(ol.   ...> SELECT c.city, 
   ...>        COUNT(DISTINCT c.customer_id) AS customers,
   ...>        SUM(ol.qty * p.price) AS revenue
   ...> FROM customer c
   ...> JOIN orders o      ON o.customer_id = c.customer_id
   ...> JOIN order_line ol ON ol.order_id = o.order_id
   ...> JOIN product p     ON p.product_id = ol.product_id
   ...> WHERE o.ordered_on >= '2025-01-01' AND o.ordered_on < '2026-01-01'
   ...> GROUP BY c.city
   ...> ORDER BY revenue DESC;
QUERY PLAN
|--SEARCH o USING INDEX idx_orders_ordered_on (ordered_on>? AND ordered_on<?)
|--SEARCH c USING INTEGER PRIMARY KEY (rowid=?)
|--SEARCH ol USING INDEX idx_order_line_order (order_id=?)
|--SEARCH p USING INTEGER PRIMARY KEY (rowid=?)
|--USE TEMP B-TREE FOR GROUP BY
|--USE TEMP B-TREE FOR count(DISTINCT)
`--USE TEMP B-TREE FOR ORDER BY
Run Time: real 0.010 user 0.000217 sys 0.008427
sqlit
