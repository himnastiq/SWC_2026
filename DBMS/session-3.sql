CREATE TABLE UnitsSold (
    Product_id INT,
    Purchase_date DATE,
    Units INT
);

-- Insert Data
INSERT INTO UnitsSold VALUES
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);

CREATE TABLE prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    PRIMARY KEY (product_id, start_date, end_date)
);

INSERT INTO prices (product_id, start_date, end_date, price) VALUES
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);
   

SELECT  p.product_id,round(
sum(p.price*u.units)*1.00/sum(u.units),2) as Average_price
FROM prices AS P
LEFT JOIN UnitsSold AS U
ON P.product_id=U.product_id AND U.Purchase_date 
between p.start_date and p.end_date
group by p.product_id
---------------------------------------------------------------------------------

CREATE TABLE employee (
    empid INT,
    ename VARCHAR(50),
    salary INT,
    managerid INT
);
INSERT INTO employee (empid, ename, salary, managerid) VALUES
(1, 'AMAN', 50000, NULL),
(2, 'SHREYA', 40000, 1),
(3, 'PIYUSH', 70000, 1),
(4, 'NEHA', 55000, NULL),
(5, 'NITIKA', 65000, 4),
(6, 'MANISH', 50000, 4);

SELECT e.empid,
       e.ename
FROM employee e
JOIN employee m
  ON e.managerid = m.empid
WHERE e.empid < m.empid;