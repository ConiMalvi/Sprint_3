CREATE USER 'Telovendo'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO 'Telovendo'@'localhost' WITH GRANT OPTION;


-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema telovendo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema telovendo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `telovendo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `telovendo` ;

-- -----------------------------------------------------
-- Table `telovendo`.`categoria_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`categoria_producto` (
  `ID_Categoria` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Categoria` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID_Categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendo`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Apellido` VARCHAR(50) NOT NULL,
  `Direccion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendo`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`producto` (
  `ID_Producto` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Producto` VARCHAR(50) NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  `Color` VARCHAR(20) NOT NULL,
  `stock` INT NULL DEFAULT NULL,
  `ID_Categoria` INT NOT NULL,
  PRIMARY KEY (`ID_Producto`),
  INDEX `ID_Categoria` (`ID_Categoria` ASC) VISIBLE,
  CONSTRAINT `producto_ibfk_1`
    FOREIGN KEY (`ID_Categoria`)
    REFERENCES `telovendo`.`categoria_producto` (`ID_Categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendo`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NULL DEFAULT NULL,
  `cliente_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_producto` (`id_producto` ASC) VISIBLE,
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `compra_ibfk_1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `telovendo`.`producto` (`ID_Producto`),
  CONSTRAINT `compra_ibfk_2`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `telovendo`.`cliente` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendo`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `n_representante` VARCHAR(50) NOT NULL,
  `Nombre_Corporativo` VARCHAR(50) NOT NULL,
  `telefono1` VARCHAR(15) NOT NULL,
  `contacto1` VARCHAR(50) NOT NULL,
  `telefono2` VARCHAR(15) NULL DEFAULT NULL,
  `contacto2` VARCHAR(50) NULL DEFAULT NULL,
  `email` VARCHAR(50) NOT NULL,
  `categoria` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendo`.`producto_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`producto_proveedor` (
  `ID_Producto` INT NOT NULL,
  `ID_Proveedor` INT NOT NULL,
  `stock` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Producto`, `ID_Proveedor`),
  INDEX `ID_Proveedor` (`ID_Proveedor` ASC) VISIBLE,
  CONSTRAINT `producto_proveedor_ibfk_1`
    FOREIGN KEY (`ID_Producto`)
    REFERENCES `telovendo`.`producto` (`ID_Producto`),
  CONSTRAINT `producto_proveedor_ibfk_2`
    FOREIGN KEY (`ID_Proveedor`)
    REFERENCES `telovendo`.`proveedor` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*Insertar registros de clientes*/
INSERT INTO cliente (nombre, apellido, direccion) 
VALUES 
('Juan', 'Perez', 'av gaviota 123'),
('María', 'González', 'calle 5 de mayo 456'),
('Luis', 'Ramírez', 'calle juarez 789'),
('Ana', 'Sánchez', 'av del bosque 234'),
('Pedro', 'Martínez', 'calle amapolas 567')
;

/* Ingreso de registros de categorias */
insert into categoria_producto (nombre_categoria)
values
('Smartphones'),
('Consolas'),
('Drones'),
('Smartwatch'),
('Audio'),
('TV'),
('Computacion'),
('Linea Blanca'),
('fotografia'),
('smarthome');


/*Insertar productos a la base de datos*/
INSERT INTO producto (nombre_producto, precio, color, stock, id_categoria)
VALUES 
('Samsung Galaxy S21', 800, 'Negro', 50, 1),
('PlayStation 5', 1100, 'Azul', 25, 2),
('BUG2', 500, 'Blanco', 10, 3),
('apple watch series 7', 300, 'Rojo y azul', 15, 4),
('DJI Mavic Air 2', 4000, 'Gris', 5, 3),
('Apple Watch Series 7', 500, 'Oro', 30, 4),
('Bose QuietComfort 35', 600, 'Negro', 20, 5),
('LG OLED CX', 1200, 'Negro', 8, 6),
('MacBook Pro M1', 1600, 'Plata', 12, 7),
('Canon EOS R5', 5300, 'Negro', 2, 9),
('Alexa', 1000, 'Gris', 8, 10);

-- Insertar registros a tabla proveedores.

INSERT INTO proveedor ( n_representante, nombre_corporativo, telefono1, contacto1, telefono2, contacto2, email, categoria)
VALUES 
('Juan Perez', 'Comercializadora ABC', '555-1234', 'Sofia Martinez', '555-4321', 'Luisa Ramirez', 'juanperez@comabc.com', 'Tecnologia Smart'),
('Maria Rodriguez', 'Distribuidora XYZ', '555-5678', 'Josefina Garcia', '555-8765', 'Ricardo Hernandez', 'mariarodriguez@distxyz.com', 'Entretención'),
('Pedro Gomez', 'Mayorista 123', '555-9012', 'Laura Sanchez', '555-2109', 'Roberto Torres', 'pedrogomez@mayor123.com', 'Imagen Digital'),
('Luis Hernandez', 'Importadora LMN', '555-3456', 'Ana Flores', '555-6543', 'Daniel Ortiz', 'luishernandez@importlmn.com', 'Hogar'),
('Ana Ramirez', 'Exportadora OPQ', '555-7890', 'Javier Garcia', '555-0987', 'Carmen Torres', 'anaramirez@exportopq.com', 'Computación');


-- insertar registro a tabla relacional entre producto y proveedor ademas del stock--

insert into producto_proveedor (id_producto, id_proveedor, stock)
values 	(1,1,30),
		(1,2,20),
        (2,2,25),
        (3,3,10),
        (4,1,15),
        (5,3,5),
        (6,1,30),
        (7,4,20),
        (8,1,10),
        (8,2,5),
        (8,3,10),
        (9,5,12),
        (10,3,8);
        
        
/* Cuál es la categoría de productos que más se repite: */

SELECT c.nombre_categoria, COUNT(*) AS cantidad
FROM producto p
INNER JOIN categoria_producto c ON c.id_categoria = p.id_categoria
GROUP BY c.nombre_categoria
ORDER BY cantidad DESC
LIMIT 1;

-- Cuáles son los productos con mayor stock (5 productos):

SELECT nombre_producto, stock
FROM producto
ORDER BY stock DESC
LIMIT 5;

-- Qué color de producto es más común en nuestra tienda:

SELECT color, COUNT(*) AS cantidad
FROM Producto
GROUP BY color
ORDER BY cantidad DESC
LIMIT 1;



-- Cual o cuales son los proveedores con menor stock de producto--
SELECT p.nombre_corporativo, SUM(pp.stock) AS total_stock
FROM producto_proveedor pp
INNER JOIN proveedor p ON pp.id_proveedor = p.id
GROUP BY p.nombre_corporativo
order by total_stock asc
limit 1;

-- creacion de tabla compras que registra las compras realizadas por un cliente.
create table compra(
id int primary key auto_increment,
id_producto int,
cliente_id int,
foreign key (id_producto) REFERENCES producto (ID_Producto),
foreign key (cliente_id) references  cliente (id));

-- insertamos registros de compra en la tabla

insert into compra (id_producto, cliente_id)
Values 	(1,1),
		(1,2),
        (2,3),
        (3,4),
        (5,5);
        
       

/*  Cambien la categoría de productos más popular por ‘Electrónica y computación’:

 Esta consulta lo que realiza es contar las ventas de un producto, en la que a traves de los
 inner podemos obtener a que categoria pertecene dicho producto para asi contarlo y declarlo como popular.
	*/
SELECT  c.id_categoria, c.nombre_categoria AS categoria, count(*) as ventas
FROM compra co
INNER JOIN producto p ON co.id_producto = p.id_producto
INNER JOIN categoria_producto c ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nombre_categoria
order by ventas desc
LIMIT 1; 

-- Como devuelve que la categoria mas vendida es Smartphone, la cual tiene id 4 realizamos un update para modificar nombre de la categoría.
update categoria_producto set nombre_categoria = 'Electronica y computación' where id_categoria = 4;

/*
Otra funcionalidad que se puede agregar para actualizar stock total del producto es realizar un trigger,
 para que asi cada vez que en la tabla producto_proveedor, haya una modificacion, este se ejecute y realice la acción.
 
 
*/



