-- MySQL Workbench Synchronization
-- Generated: 2022-03-24 21:22
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Kain

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `pizzeria`.`clientes` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
ADD INDEX `fk_clientes_direcciones1_idx` (`direcciones_tienda_tienda_id` ASC, `direcciones_localidad_localidad_id` ASC, `direcciones_localidad_provincia_provincia_id` ASC) VISIBLE,
ADD INDEX `fk_clientes_localidad1_idx` (`localidad_localidad_id1` ASC, `localidad_provincia_provincia_id` ASC) VISIBLE,
ADD INDEX `fk_clientes_provincia1_idx` (`provincia_provincia_id1` ASC, `provincia_direcciones_tienda_tienda_id` ASC, `provincia_direcciones_localidad_localidad_id` ASC, `provincia_direcciones_localidad_provincia_provincia_id` ASC) VISIBLE,
DROP INDEX `fk_clientes_provincia1_idx` ,
DROP INDEX `fk_clientes_localidad1_idx` ,
DROP INDEX `fk_clientes_direcciones1_idx` ;
;

ALTER TABLE `pizzeria`.`localidad` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
ADD INDEX `fk_localidad_provincia1_idx` (`provincia_provincia_id` ASC) VISIBLE,
DROP INDEX `fk_localidad_provincia1_idx` ;
;

ALTER TABLE `pizzeria`.`provincia` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
ADD INDEX `fk_provincia_direcciones1_idx` (`direcciones_tienda_tienda_id` ASC, `direcciones_localidad_localidad_id` ASC, `direcciones_localidad_provincia_provincia_id` ASC) VISIBLE,
DROP INDEX `fk_provincia_direcciones1_idx` ;
;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `pedidos_id` INT(11) NOT NULL AUTO_INCREMENT,
  `registro_pedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recogida_local` VARCHAR(1) NOT NULL COMMENT 'Posibles valores:\nS=Sí\nN=No',
  `envio_domicilio` VARCHAR(1) NOT NULL COMMENT 'Posibles valores:\nS=Sí\nN=No',
  `num_productos` VARCHAR(2) NOT NULL,
  `precio_total` DECIMAL NOT NULL,
  `clientes_clientes_id` INT(11) NOT NULL,
  `clientes_provincia_provincia_id` INT(11) NOT NULL,
  `clientes_localidad_localidad_id` INT(11) NOT NULL,
  `productos_productos_id` INT(11) NOT NULL,
  `productos_bebidas_bebidas_id` INT(11) NOT NULL,
  `tienda_tienda_id` INT(11) NOT NULL,
  `empleados_empleados_id` INT(11) NOT NULL,
  `registro_reparto` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`pedidos_id`, `clientes_clientes_id`, `clientes_provincia_provincia_id`, `clientes_localidad_localidad_id`, `productos_productos_id`, `productos_bebidas_bebidas_id`, `tienda_tienda_id`, `empleados_empleados_id`),
  INDEX `fk_pedidos_clientes1_idx` (`clientes_clientes_id` ASC, `clientes_provincia_provincia_id` ASC, `clientes_localidad_localidad_id` ASC) VISIBLE,
  INDEX `fk_pedidos_productos1_idx` (`productos_productos_id` ASC, `productos_bebidas_bebidas_id` ASC) VISIBLE,
  INDEX `fk_pedidos_tienda1_idx` (`tienda_tienda_id` ASC) VISIBLE,
  INDEX `fk_pedidos_empleados1_idx` (`empleados_empleados_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_clientes_id` , `clientes_provincia_provincia_id` , `clientes_localidad_localidad_id`)
    REFERENCES `pizzeria`.`clientes` (`clientes_id` , `provincia_provincia_id` , `localidad_localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_productos1`
    FOREIGN KEY (`productos_productos_id` , `productos_bebidas_bebidas_id`)
    REFERENCES `pizzeria`.`productos` (`productos_id` , `bebidas_bebidas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_tienda1`
    FOREIGN KEY (`tienda_tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`tienda_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_empleados1`
    FOREIGN KEY (`empleados_empleados_id`)
    REFERENCES `pizzeria`.`empleados` (`tipo_trabajador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `productos_id` INT(11) NOT NULL AUTO_INCREMENT,
  `bebidas_bebidas_id` INT(11) NOT NULL,
  `hamburguesas_haburguesa_id` INT(11) NOT NULL,
  `pizza_pizza_id` INT(11) NOT NULL,
  `pizza_categoria_pizza_categoria_pizza_id` INT(11) NOT NULL,
  PRIMARY KEY (`productos_id`, `bebidas_bebidas_id`, `hamburguesas_haburguesa_id`, `pizza_pizza_id`, `pizza_categoria_pizza_categoria_pizza_id`),
  INDEX `fk_productos_bebidas1_idx` (`bebidas_bebidas_id` ASC) VISIBLE,
  INDEX `fk_productos_hamburguesas1_idx` (`hamburguesas_haburguesa_id` ASC) VISIBLE,
  INDEX `fk_productos_pizza1_idx` (`pizza_pizza_id` ASC, `pizza_categoria_pizza_categoria_pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_bebidas1`
    FOREIGN KEY (`bebidas_bebidas_id`)
    REFERENCES `pizzeria`.`bebidas` (`bebidas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productos_hamburguesas1`
    FOREIGN KEY (`hamburguesas_haburguesa_id`)
    REFERENCES `pizzeria`.`hamburguesas` (`haburguesa_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productos_pizza1`
    FOREIGN KEY (`pizza_pizza_id` , `pizza_categoria_pizza_categoria_pizza_id`)
    REFERENCES `pizzeria`.`pizza` (`pizza_id` , `categoria_pizza_categoria_pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `pizza_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `precio` DECIMAL NOT NULL,
  `categoria_pizza_categoria_pizza_id` INT(11) NOT NULL,
  PRIMARY KEY (`pizza_id`, `categoria_pizza_categoria_pizza_id`),
  INDEX `fk_pizza_categoria_pizza1_idx` (`categoria_pizza_categoria_pizza_id` ASC) VISIBLE,
  INDEX `index_nombre` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_categoria_pizza1`
    FOREIGN KEY (`categoria_pizza_categoria_pizza_id`)
    REFERENCES `pizzeria`.`categoria_pizza` (`categoria_pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`bebidas` (
  `bebidas_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`bebidas_id`),
  INDEX `index_nombre` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesas` (
  `haburguesa_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`haburguesa_id`),
  INDEX `index_nom` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria_pizza` (
  `categoria_pizza_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoria_pizza_id`),
  INDEX `index` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `tienda_id` INT(11) NOT NULL AUTO_INCREMENT,
  `provincia_provincia_id` INT(11) NOT NULL,
  `provincia_direcciones_tienda_tienda_id` INT(11) NOT NULL,
  `provincia_direcciones_localidad_localidad_id` INT(11) NOT NULL,
  `provincia_direcciones_localidad_provincia_provincia_id` INT(11) NOT NULL,
  `localidad_localidad_id` INT(11) NOT NULL,
  `localidad_provincia_provincia_id` INT(11) NOT NULL,
  `empleados_empleados_id` INT(11) NOT NULL,
  PRIMARY KEY (`tienda_id`, `provincia_provincia_id`, `provincia_direcciones_tienda_tienda_id`, `provincia_direcciones_localidad_localidad_id`, `provincia_direcciones_localidad_provincia_provincia_id`, `localidad_localidad_id`, `localidad_provincia_provincia_id`, `empleados_empleados_id`),
  INDEX `fk_tienda_provincia1_idx` (`provincia_provincia_id` ASC, `provincia_direcciones_tienda_tienda_id` ASC, `provincia_direcciones_localidad_localidad_id` ASC, `provincia_direcciones_localidad_provincia_provincia_id` ASC) VISIBLE,
  INDEX `fk_tienda_localidad1_idx` (`localidad_localidad_id` ASC, `localidad_provincia_provincia_id` ASC) VISIBLE,
  INDEX `fk_tienda_empleados1_idx` (`empleados_empleados_id` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_provincia1`
    FOREIGN KEY (`provincia_provincia_id` , `provincia_direcciones_tienda_tienda_id` , `provincia_direcciones_localidad_localidad_id` , `provincia_direcciones_localidad_provincia_provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`provincia_id` , `direcciones_tienda_tienda_id` , `direcciones_localidad_localidad_id` , `direcciones_localidad_provincia_provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tienda_localidad1`
    FOREIGN KEY (`localidad_localidad_id` , `localidad_provincia_provincia_id`)
    REFERENCES `pizzeria`.`localidad` (`localidad_id` , `provincia_provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tienda_empleados1`
    FOREIGN KEY (`empleados_empleados_id`)
    REFERENCES `pizzeria`.`empleados` (`empleados_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `empleados_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `tipo_trabajador` INT(11) NOT NULL COMMENT 'Posibles valores:\nCocinero=1\nRepartidor=2',
  PRIMARY KEY (`empleados_id`),
  INDEX `index_nombre` (`nombre` ASC, `apellidos` ASC) INVISIBLE,
  INDEX `index_NIF` (`NIF` ASC) INVISIBLE,
  INDEX `index_tipoT` (`tipo_trabajador` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
