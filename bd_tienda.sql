-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tiendabd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tiendabd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tiendabd` DEFAULT CHARACTER SET utf8 ;
USE `tiendabd` ;

-- -----------------------------------------------------
-- Table `tiendabd`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendabd`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(60) NOT NULL,
  `apellido` VARCHAR(60) NOT NULL,
  `direccion` CHAR(40) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendabd`.`telefonos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendabd`.`telefonos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` CHAR(12) NOT NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_telefonos_clientes_idx` (`clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_telefonos_clientes`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `tiendabd`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendabd`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendabd`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(80) NOT NULL,
  `direccion` CHAR(80) NOT NULL,
  `telefono` CHAR(40) NOT NULL,
  `correo` CHAR(120) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendabd`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendabd`.`ventas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(80) NOT NULL,
  `fecha` DATE NOT NULL,
  `subtotal` DECIMAL NOT NULL,
  `iva` DECIMAL NOT NULL,
  `descuento` DECIMAL NOT NULL,
  `total` DECIMAL NOT NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ventas_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `tiendabd`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendabd`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendabd`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(80) NOT NULL,
  `preciocompra` DECIMAL NOT NULL,
  `prcioventa` DECIMAL NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendabd`.`ventas_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendabd`.`ventas_has_productos` (
  `ventas_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`ventas_id`, `productos_id`),
  INDEX `fk_ventas_has_productos_productos1_idx` (`productos_id` ASC) VISIBLE,
  INDEX `fk_ventas_has_productos_ventas1_idx` (`ventas_id` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_has_productos_ventas1`
    FOREIGN KEY (`ventas_id`)
    REFERENCES `tiendabd`.`ventas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_has_productos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `tiendabd`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendabd`.`proveedor_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendabd`.`proveedor_has_productos` (
  `proveedor_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`proveedor_id`, `productos_id`),
  INDEX `fk_proveedor_has_productos_productos1_idx` (`productos_id` ASC) VISIBLE,
  INDEX `fk_proveedor_has_productos_proveedor1_idx` (`proveedor_id` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_has_productos_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `tiendabd`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_has_productos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `tiendabd`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
