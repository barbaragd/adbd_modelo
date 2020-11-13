-- MySQL Script generated by MySQL Workbench
-- vie 13 nov 2020 15:30:27
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb_catastro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb_catastro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb_catastro` DEFAULT CHARACTER SET utf8 ;
USE `mydb_catastro` ;

-- -----------------------------------------------------
-- Table `mydb_catastro`.`zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_catastro`.`zona` (
  `nombre` VARCHAR(45) NOT NULL,
  `área` VARCHAR(45) NULL,
  `concejal` VARCHAR(45) NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_catastro`.`calle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_catastro`.`calle` (
  `nombre` VARCHAR(45) NOT NULL,
  `longitud` INT NULL,
  `tipo` VARCHAR(15) NOT NULL,
  `cantidad_carriles` INT NULL,
  `zona` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombre`),
  -- INDEX `zona_idx` (`zona` ASC) VISIBLE,
  CONSTRAINT `zona`
    FOREIGN KEY (`zona`)
    REFERENCES `mydb_catastro`.`zona` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_catastro`.`vivienda_unifamiliar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_catastro`.`vivienda_unifamiliar` (
  `número` INT NOT NULL,
  `año_construccion` VARCHAR(45) NULL,
  `superficie` INT NULL,
  `número_habitaciones` INT NOT NULL,
  `eficiencia_energetica` VARCHAR(5) NULL,
  `calle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`número`, `calle`),
  -- INDEX `calle_idx` (`calle` ASC) VISIBLE,
  CONSTRAINT `calle_vivienda`
    FOREIGN KEY (`calle`)
    REFERENCES `mydb_catastro`.`calle` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_catastro`.`bloque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_catastro`.`bloque` (
  `número` INT NOT NULL,
  `año_construccion` VARCHAR(10) NULL,
  `superficie` INT NULL,
  `calle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`número`, `calle`),
  -- INDEX `calle_idx` (`calle` ASC) VISIBLE,
  CONSTRAINT `calle_bloque`
    FOREIGN KEY (`calle`)
    REFERENCES `mydb_catastro`.`calle` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_catastro`.`piso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_catastro`.`piso` (
  `letra` VARCHAR(2) NOT NULL,
  `planta` VARCHAR(45) NOT NULL,
  `superficie` INT NULL,
  `número_habitaciones` INT NOT NULL,
  `eficiencia_energetica` VARCHAR(5) NULL,
  `bloque_número` INT NOT NULL,
  `bloque_calle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`letra`, `planta`, `bloque_calle`, `bloque_número`),
  -- INDEX `fk_piso_bloque1_idx` (`bloque_número` ASC, `bloque_calle` ASC) VISIBLE,
  CONSTRAINT `fk_piso_bloque1`
    FOREIGN KEY (`bloque_número` , `bloque_calle`)
    REFERENCES `mydb_catastro`.`bloque` (`número` , `calle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_catastro`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_catastro`.`persona` (
  `DNI` VARCHAR(9) NOT NULL,
  `fecha_nacimiento` VARCHAR(10) NOT NULL,
  `nivel_estudios` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `cabeza_familia` VARCHAR(45) NOT NULL,
  `piso_numero` INT NOT NULL,
  `piso_calle` VARCHAR(45) NOT NULL,
  `vivienda_unifamiliar_número` INT NOT NULL,
  `vivienda_unifamiliar_calle` VARCHAR(45) NOT NULL,
  `piso_letra` VARCHAR(2) NOT NULL,
  `piso_planta` VARCHAR(45) NOT NULL,
  `piso_bloque_calle` VARCHAR(45) NOT NULL,
  `piso_bloque_número` INT NOT NULL,
  PRIMARY KEY (`DNI`),
  -- INDEX `fk_persona_vivienda_unifamiliar1_idx` (`vivienda_unifamiliar_número` ASC, `vivienda_unifamiliar_calle` ASC) VISIBLE,
  -- INDEX `fk_persona_piso1_idx` (`piso_letra` ASC, `piso_planta` ASC, `piso_bloque_calle` ASC, `piso_bloque_número` ASC) VISIBLE,
  CONSTRAINT `fk_persona_vivienda_unifamiliar1`
    FOREIGN KEY (`vivienda_unifamiliar_número` , `vivienda_unifamiliar_calle`)
    REFERENCES `mydb_catastro`.`vivienda_unifamiliar` (`número` , `calle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_piso1`
    FOREIGN KEY (`piso_letra` , `piso_planta` , `piso_bloque_calle` , `piso_bloque_número`)
    REFERENCES `mydb_catastro`.`piso` (`letra` , `planta` , `bloque_calle` , `bloque_número`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
