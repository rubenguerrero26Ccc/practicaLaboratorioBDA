CREATE DATABASE IF NOT EXISTS ventas_db;
CREATE USER IF NOT EXISTS 'sqoopuser'@'%' IDENTIFIED BY 'sqooppassword';
GRANT ALL PRIVILEGES ON ventas_db.* TO 'sqoopuser'@'%';
FLUSH PRIVILEGES;

USE ventas_db;

CREATE TABLE clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  ciudad VARCHAR(50)
);

CREATE TABLE pedidos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT,
  producto VARCHAR(50),
  importe DECIMAL(8,2),
  fecha DATE
);

SET SESSION cte_max_recursion_depth = 2000;

INSERT INTO clientes (nombre, ciudad)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 100)
SELECT CONCAT('Cliente', i),
       ELT(1 + i % 4, 'Madrid', 'Barcelona', 'Valencia', 'Sevilla')
FROM n;

INSERT INTO pedidos (cliente_id, producto, importe, fecha)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 1000)
SELECT (i % 100) + 1,
       CONCAT('Producto', i % 20),
       ROUND(RAND() * 500, 2),
       DATE_ADD('2025-01-01', INTERVAL i % 300 DAY)
FROM n;