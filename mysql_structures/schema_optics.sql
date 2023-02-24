-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optics` DEFAULT CHARACTER SET utf8 ;
USE `optics` ;

-- -----------------------------------------------------
-- Table `optics`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `number` TINYINT(3) NOT NULL,
  `floor` TINYINT(2) NOT NULL,
  `door` TINYINT(2) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postalCode` TINYINT(25) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`suppliers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` TINYINT(9) NOT NULL,
  `fax` TINYINT(10) NULL,
  `nif` VARCHAR(9) NOT NULL,
  `addressID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `suppliersAddresses_idx` (`addressID` ASC) VISIBLE,
  CONSTRAINT `suppliersAddresses`
    FOREIGN KEY (`addressID`)
    REFERENCES `optics`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` TINYINT(9) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `registrationDate` DATETIME NOT NULL,
  `addressID` INT NOT NULL,
  `referringClient` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `clientsAddresses_idx` (`addressID` ASC) VISIBLE,
  INDEX `recommendClient_idx` (`referringClient` ASC) VISIBLE,
  CONSTRAINT `clientsAddresses`
    FOREIGN KEY (`addressID`)
    REFERENCES `optics`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `recommendClient`
    FOREIGN KEY (`referringClient`)
    REFERENCES `optics`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`employees` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`brands` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `supplierID` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `brandsSuppliers_idx` (`supplierID` ASC) VISIBLE,
  CONSTRAINT `brandsSuppliers`
    FOREIGN KEY (`supplierID`)
    REFERENCES `optics`.`suppliers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`glasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brandID` INT NOT NULL,
  `leftLensGraduation` DECIMAL(2,2) NOT NULL,
  `rightLensGraduation` DECIMAL(2,2) NOT NULL,
  `glassFrame` ENUM("floating", "plastic", "metallic") NOT NULL,
  `leftColor` VARCHAR(45) NOT NULL,
  `rightColor` VARCHAR(20) NOT NULL,
  `price` TINYINT(6) NOT NULL,
  `employeeID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `employeeSeller_idx` (`employeeID` ASC) VISIBLE,
  INDEX `brandGlasses_idx` (`brandID` ASC) VISIBLE,
  CONSTRAINT `employeeSeller`
    FOREIGN KEY (`employeeID`)
    REFERENCES `optics`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `brandGlasses`
    FOREIGN KEY (`brandID`)
    REFERENCES `optics`.`brands` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `clientID` INT NOT NULL,
  `saleDate` DATETIME NOT NULL,
  `totalPrice` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `clientOrders_idx` (`clientID` ASC) VISIBLE,
  CONSTRAINT `clientOrders`
    FOREIGN KEY (`clientID`)
    REFERENCES `optics`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`detailOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`detailOrder` (
  `id` INT NOT NULL,
  `orderID` INT NOT NULL,
  `glassesID` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `detailGlasses_idx` (`glassesID` ASC) VISIBLE,
  INDEX `detailOrder_idx` (`orderID` ASC) VISIBLE,
  CONSTRAINT `detailGlasses`
    FOREIGN KEY (`glassesID`)
    REFERENCES `optics`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `detailOrder`
    FOREIGN KEY (`orderID`)
    REFERENCES `optics`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
