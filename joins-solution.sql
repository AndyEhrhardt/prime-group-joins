1. Get all customers and their addresses.
SELECT *
FROM "customers"
JOIN "addresses" 
ON "customers"."id" = "addresses"."customer_id"

2. Get all orders and their line items (orders, quantity and product).
SELECT *
FROM "orders"
JOIN "line_items"
ON "orders"."id" = "line_items"."order_id"

3. Which warehouses have cheetos?
SELECT *
FROM "warehouse"
JOIN "warehouse_product"
ON "warehouse"."id" = "warehouse_product"."warehouse_id"
WHERE "warehouse_product"."product_id" = 5
--Delta has cheetos 

4. Which warehouses have diet pepsi?
SELECT *
FROM "warehouse"
JOIN "warehouse_product"
ON "warehouse"."id" = "warehouse_product"."warehouse_id"
WHERE "warehouse_product"."product_id" = 6
--Alpha delta and gamma

5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "addresses"."customer_id", count("orders".*)
FROM "orders"
JOIN "addresses"
ON "orders"."address_id" = "addresses"."id"
GROUP BY "addresses"."customer_id"

6. How many customers do we have?
SELECT count(*) FROM "customers"
--4

7. How many products do we carry?
SELECT count(*) FROM "products"
---7

8. What is the total available on-hand quantity of diet pepsi?
SELECT sum("warehouse_product"."product_id")
FROM "warehouse_product"
WHERE "warehouse_product"."product_id" = 6


CREATE TABLE "person" (
	"id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(25)
)

INSERT INTO "person" ("first_name")
VALUES ('Chris'), ('Jess'), ('Ahmed'), ('Danny'), ('Anwar'), ('Ian'), ('Greg'), ('Phaydara');

CREATE TABLE "hobby" (
	"id" SERIAL PRIMARY KEY,
	"description" VARCHAR(100)
);

INSERT INTO "hobby" ("description")
VALUES ('rock climbing'), ('soccer'), ('sewing'), ('music');

CREATE TABLE "person_hobby" (
	"id" SERIAL PRIMARY KEY, --optional on junction tables
	"person_id" INT REFERENCES "person",
	"hobby_id" INT REFERENCES "hobby",
	"skill" INT
);

INSERT INTO "person_hobby" ("person_id", "hobby_id", "skill")
VALUES (1, 1, 3),(1,2,1),(2,3,5),(2,3,5),(2,2,1),(3,2,5),(3,1,1),
(4, 2, 4), (4,1,2), (5,2,3),(5,1,3)

SELECT "p"."first_name", "h"."description","ph"."skill"
FROM "person" as "p"
JOIN "person_hobby" as "ph" on "p"."id" = "ph"."person_id"
JOIN "hobby" as "h" on "h"."id" = "ph"."hobby_id";



SELECT "h"."description", AVG("ph"."skill"), COUNT("p"."id")
FROM "person" as "p"
JOIN "person_hobby" as "ph" on "p"."id" = "ph"."person_id"
JOIN "hobby" as "h" on "h"."id" = "ph"."hobby_id"
GROUP BY "h"."description";