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
-- Table `pizzeria`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `postalCode` TINYINT(5) NOT NULL,
  `locality` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `phone` TINYINT(9) NOT NULL,
  `addressID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `clientAddress_idx` (`addressID` ASC) VISIBLE,
  CONSTRAINT `clientAddress`
    FOREIGN KEY (`addressID`)
    REFERENCES `pizzeria`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzeria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `addressID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pizzeriaAddress_idx` (`addressID` ASC) VISIBLE,
  CONSTRAINT `pizzeriaAddress`
    FOREIGN KEY (`addressID`)
    REFERENCES `pizzeria`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `type` ENUM("Pizzaman", "Deliveryman") NOT NULL,
  `pizzeriaID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pizzeriaEmployee_idx` (`pizzeriaID` ASC) VISIBLE,
  CONSTRAINT `pizzeriaEmployee`
    FOREIGN KEY (`pizzeriaID`)
    REFERENCES `pizzeria`.`pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`delivery` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `deliveryManID` INT NOT NULL,
  `deliveryDate` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `employeeDeliveryman_idx` (`deliveryManID` ASC) VISIBLE,
  CONSTRAINT `employeeDeliveryman`
    FOREIGN KEY (`deliveryManID`)
    REFERENCES `pizzeria`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientOrder` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dateTime` DATETIME NOT NULL,
  `delivery` ENUM("Delivery", "Pickup") NOT NULL,
  `totalProducts` INT NOT NULL,
  `totalPrice` DECIMAL(4,4) NOT NULL,
  `clientID` INT NOT NULL,
  `pizzeriaID` INT NOT NULL,
  `deliveryID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `clientsOrder_idx` (`clientID` ASC) VISIBLE,
  INDEX `pizzeriaOrders_idx` (`pizzeriaID` ASC) VISIBLE,
  INDEX `deliveryOrder_idx` (`deliveryID` ASC) VISIBLE,
  CONSTRAINT `clientsOrder`
    FOREIGN KEY (`clientID`)
    REFERENCES `pizzeria`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pizzeriaOrders`
    FOREIGN KEY (`pizzeriaID`)
    REFERENCES `pizzeria`.`pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `deliveryOrder`
    FOREIGN KEY (`deliveryID`)
    REFERENCES `pizzeria`.`delivery` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `image` LONGBLOB NOT NULL,
  `price` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`burguer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`burguer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productID` INT NOT NULL,
  `clientOrderID` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `burguerProduct_idx` (`productID` ASC) VISIBLE,
  INDEX `orderBurguer_idx` (`clientOrderID` ASC) VISIBLE,
  CONSTRAINT `burguerProduct`
    FOREIGN KEY (`productID`)
    REFERENCES `pizzeria`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderBurguer`
    FOREIGN KEY (`clientOrderID`)
    REFERENCES `pizzeria`.`clientOrder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`drink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`drink` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productID` INT NOT NULL,
  `clientOrderID` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `drinkProduct_idx` (`productID` ASC) VISIBLE,
  INDEX `orderDrink_idx` (`clientOrderID` ASC) VISIBLE,
  CONSTRAINT `drinkProduct`
    FOREIGN KEY (`productID`)
    REFERENCES `pizzeria`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderDrink`
    FOREIGN KEY (`clientOrderID`)
    REFERENCES `pizzeria`.`clientOrder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoryID` INT NOT NULL,
  `productID` INT NOT NULL,
  `clientOrderID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pizzaCategories_idx` (`categoryID` ASC) VISIBLE,
  INDEX `pizzaProduct_idx` (`productID` ASC) VISIBLE,
  INDEX `pizzaOrder_idx` (`clientOrderID` ASC) VISIBLE,
  CONSTRAINT `pizzaCategories`
    FOREIGN KEY (`categoryID`)
    REFERENCES `pizzeria`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pizzaProduct`
    FOREIGN KEY (`productID`)
    REFERENCES `pizzeria`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pizzaOrder`
    FOREIGN KEY (`clientOrderID`)
    REFERENCES `pizzeria`.`clientOrder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
