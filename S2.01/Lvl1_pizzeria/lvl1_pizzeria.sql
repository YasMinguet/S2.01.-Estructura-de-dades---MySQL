-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `provincia_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia_id`),
  INDEX `nombre` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidad` (
  `localidad_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia_provincia_id` INT NOT NULL,
  PRIMARY KEY (`localidad_id`, `provincia_provincia_id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_provincia_id` ASC) VISIBLE,
  INDEX `nombre` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`direcciones` (
  `direcciones_id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `localidad_localidad_id` INT NOT NULL,
  PRIMARY KEY (`direcciones_id`, `localidad_localidad_id`),
  INDEX `fk_direcciones_localidad1_idx` (`localidad_localidad_id` ASC) VISIBLE,
  INDEX `cp` (`codigo_postal` ASC) VISIBLE,
  CONSTRAINT `fk_direcciones_localidad1`
    FOREIGN KEY (`localidad_localidad_id`)
    REFERENCES `pizzeria`.`localidad` (`localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `clientes_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direcciones_direcciones_id` INT NOT NULL,
  PRIMARY KEY (`clientes_id`, `direcciones_direcciones_id`),
  INDEX `fk_clientes_direcciones_idx` (`direcciones_direcciones_id` ASC) VISIBLE,
  INDEX `nombre` (`nombre` ASC) INVISIBLE,
  INDEX `apellidos` (`apellidos` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_direcciones`
    FOREIGN KEY (`direcciones_direcciones_id`)
    REFERENCES `pizzeria`.`direcciones` (`direcciones_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `empleados_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `tipo_trabajador` ENUM('cocinero', 'repartidor') NOT NULL,
  PRIMARY KEY (`empleados_id`),
  INDEX `NIF` (`NIF` ASC) INVISIBLE,
  INDEX `tipo` (`tipo_trabajador` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `tienda_id` INT NOT NULL AUTO_INCREMENT,
  `empleados_empleados_id` INT NOT NULL,
  PRIMARY KEY (`tienda_id`, `empleados_empleados_id`),
  INDEX `fk_tienda_empleados1_idx` (`empleados_empleados_id` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_empleados1`
    FOREIGN KEY (`empleados_empleados_id`)
    REFERENCES `pizzeria`.`empleados` (`empleados_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`detalles_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`detalles_producto` (
  `detalles_producto_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`detalles_producto_id`),
  INDEX `nombre` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria_pizza` (
  `categoria_pizza_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoria_pizza_id`),
  INDEX `nombre` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `productos_id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('bebidas', 'hamburguesas', 'pizza') NOT NULL,
  `detalles_producto_detalles_producto_id` INT NOT NULL,
  `categoria_pizza_categoria_pizza_id` INT NOT NULL,
  PRIMARY KEY (`productos_id`, `detalles_producto_detalles_producto_id`, `categoria_pizza_categoria_pizza_id`),
  INDEX `tipo` (`tipo` ASC) VISIBLE,
  INDEX `fk_productos_detalles_producto1_idx` (`detalles_producto_detalles_producto_id` ASC) VISIBLE,
  INDEX `fk_productos_categoria_pizza1_idx` (`categoria_pizza_categoria_pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_detalles_producto1`
    FOREIGN KEY (`detalles_producto_detalles_producto_id`)
    REFERENCES `pizzeria`.`detalles_producto` (`detalles_producto_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productos_categoria_pizza1`
    FOREIGN KEY (`categoria_pizza_categoria_pizza_id`)
    REFERENCES `pizzeria`.`categoria_pizza` (`categoria_pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`detalle_pedido` (
  `detalle_pedido_id` INT NOT NULL AUTO_INCREMENT,
  `cantidad_bebidas` INT NOT NULL,
  `cantidad_hamburguesas` INT NOT NULL,
  `cantidad_pizzas` INT NOT NULL,
  `precio_total` DECIMAL NOT NULL,
  `productos_productos_id` INT NOT NULL,
  PRIMARY KEY (`detalle_pedido_id`, `productos_productos_id`),
  INDEX `fk_detalle_pedido_productos1_idx` (`productos_productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_pedido_productos1`
    FOREIGN KEY (`productos_productos_id`)
    REFERENCES `pizzeria`.`productos` (`productos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `pedidos_id` INT NOT NULL AUTO_INCREMENT,
  `registro_pedido` DATETIME NOT NULL,
  `recogida_local` ENUM('S', 'N') NOT NULL,
  `envio_domicilio` ENUM('S', 'N') NOT NULL,
  `tienda_tienda_id` INT NOT NULL,
  `clientes_clientes_id` INT NOT NULL,
  `detalle_pedido_detalle_pedido_id` INT NOT NULL,
  PRIMARY KEY (`pedidos_id`, `tienda_tienda_id`, `clientes_clientes_id`, `detalle_pedido_detalle_pedido_id`),
  INDEX `fk_pedidos_tienda1_idx` (`tienda_tienda_id` ASC) VISIBLE,
  INDEX `fk_pedidos_clientes1_idx` (`clientes_clientes_id` ASC) VISIBLE,
  INDEX `fk_pedidos_detalle_pedido1_idx` (`detalle_pedido_detalle_pedido_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_tienda1`
    FOREIGN KEY (`tienda_tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`tienda_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_clientes_id`)
    REFERENCES `pizzeria`.`clientes` (`clientes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_detalle_pedido1`
    FOREIGN KEY (`detalle_pedido_detalle_pedido_id`)
    REFERENCES `pizzeria`.`detalle_pedido` (`detalle_pedido_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
