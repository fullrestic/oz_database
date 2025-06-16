/* use classicmodels; */

-- 모든 고객의 이름 조회
/* select customerName from customers; */

-- Classic Cars 제품 라인에 속하는 모든 제품의 정보 조회
/* select * from products where productLine = "Classic Cars"; */

-- 가장 최근 10개 주문 조회
/* select * from orders order by orderDate DESC limit 10; */

-- 100달러 이상 결제된 거래 조회
/* select * from payments where amount >= 100; */



-- 주문과 고객 정보 조합
-- customerName이 같은 데이터 뽑기
/*
SELECT o.orderNumber, c.customerName
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber;
*/

-- 제품과 제품 라인 결합
/*
SELECT p.productName, p.productLine, pl.textDescription
FROM products p
JOIN productlines pl ON p.productLine = pl.productLine;
*/

-- 직원과 상사 정보
/*
SELECT e1.employeeNumber, e1.firstName, e1.lastName, e2.firstName AS 'ManagerFirstName', e2.lastName AS 'ManagerLastName'
FROM employees e1
LEFT JOIN employees e2 ON e1.reportsTo = e2.employeeNumber;
*/

-- San Francisco 사무실의 직원 목록
/*
SELECT e.employeeNumber, e.lastName, e.firstName, e.extension, e.email, e.officeCode, e.reportsTo, e.jobTitle
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
WHERE o.city = 'San Francisco';
*/



-- 제품 라인별 제품 수
/*
SELECT productLine, COUNT(*) AS productCount
FROM products
GROUP BY productLine;
*/

-- 고객별 총 주문 금액 
-- 주문금액 많은 순 정렬
/*
SELECT customers.customerNumber, 
       customers.customerName, 
       SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS totalAmount
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY customers.customerNumber, customers.customerName
order by totalAmount desc;
*/

-- 가장 많이 팔린 제품
/*
SELECT productName, SUM(quantityOrdered) AS totalQuantity
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY productName
ORDER BY totalQuantity DESC
LIMIT 1;
*/

-- 매출이 가장 높은 사무실
/* 
SELECT o.city, SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM orders ord
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
JOIN customers c ON ord.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
GROUP BY o.city
ORDER BY totalSales DESC
LIMIT 1;
*/



-- 500달러 이상의 총 주문 금액을 기록한 주문 조회
/*
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS totalAmount
FROM orderdetails
GROUP BY orderNumber
HAVING totalAmount > 500;
*/

-- 평균 이상 결제 고객
/*
SELECT customerNumber, SUM(amount) AS totalPayment
FROM payments
GROUP BY customerNumber
HAVING totalPayment > (SELECT AVG(amount) FROM payments);
*/

-- 주문 없는 고객
/*
SELECT customerName
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);
*/

-- 최대 매출 고객
/*
SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalSpent
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
ORDER BY totalSpent DESC
LIMIT 1;
*/



-- 신규 고객 추가
/*
INSERT INTO customers (customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit, customerNumber)
VALUES ('New Customer', 'Lastname', 'Firstname', '123-456-7890', '123 Street', 'Suite 1', 'City', 'State', 'PostalCode', 'Country', 1002, 50000.00, 497);
*/

-- Classic Car 제품 라인의 모든 제품 가격 인상
/*
UPDATE products
SET buyPrice = buyPrice * 1.10
WHERE productLine = 'Classic Cars';
*/

-- 특정 고객의 이메일 주소 변경
-- 하지만 이 데이터베이스에는 이메일 정보가 없음..
/* 
update customers
set email = "update@gmail.com"
where customerNumber = 103;
*/

-- 특정 직원을 다른 사무실로 이동
update employees
set officeCode = '2'
where employeeNumber = 123;





