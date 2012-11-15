SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `rooseti` ;
CREATE SCHEMA IF NOT EXISTS `rooseti` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
SHOW WARNINGS;
USE `rooseti` ;

-- -----------------------------------------------------
-- Table `rooseti`.`USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`USER` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`USER` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `last_name` VARCHAR(100) NOT NULL ,
  `first_name` VARCHAR(100) NOT NULL ,
  `middle_name` VARCHAR(45) NULL ,
  `email` VARCHAR(150) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooseti`.`APPLICATION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`APPLICATION` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`APPLICATION` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NOT NULL ,
  `description` VARCHAR(2000) NULL ,
  `screenshot` TINYBLOB NULL ,
  `owner_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `id_idx` (`owner_id` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `app_owner_id`
    FOREIGN KEY (`owner_id` )
    REFERENCES `rooseti`.`USER` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooseti`.`LIFECYCLE_PHASE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`LIFECYCLE_PHASE` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`LIFECYCLE_PHASE` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  `display_order` INT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooseti`.`RELEASE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`RELEASE` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`RELEASE` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(2000) NULL ,
  `display_order` INT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooseti`.`SERVER_TYPE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`SERVER_TYPE` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`SERVER_TYPE` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(2000) NULL ,
  `display_order` INT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooseti`.`SERVICE_TYPE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`SERVICE_TYPE` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`SERVICE_TYPE` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(2000) NULL ,
  `display_order` INT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooseti`.`SERVICE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`SERVICE` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`SERVICE` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `instance_name` VARCHAR(255) NOT NULL ,
  `service_type_id` INT UNSIGNED NOT NULL ,
  `port` VARCHAR(50) NOT NULL ,
  `notes` VARCHAR(2000) NULL ,
  `display_order` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `id_idx` (`service_type_id` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `svc_service_type_id`
    FOREIGN KEY (`service_type_id` )
    REFERENCES `rooseti`.`SERVICE_TYPE` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooseti`.`SERVER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`SERVER` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`SERVER` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `ip_address` VARCHAR(45) NOT NULL ,
  `description` VARCHAR(2000) NULL ,
  `display_order` INT NULL ,
  `server_type` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `id_idx` (`server_type` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `srvr_server_type_id`
    FOREIGN KEY (`server_type` )
    REFERENCES `rooseti`.`SERVER_TYPE` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooseti`.`RESERVATION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooseti`.`RESERVATION` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `rooseti`.`RESERVATION` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `reservation_tag` VARCHAR(100) NOT NULL ,
  `requester_id` INT UNSIGNED NULL ,
  `comments` VARCHAR(2000) NULL ,
  `application_id` INT UNSIGNED NOT NULL ,
  `release_id` INT UNSIGNED NOT NULL ,
  `lifecycle_phase_id` INT UNSIGNED NOT NULL ,
  `server_id` INT UNSIGNED NOT NULL ,
  `service_id` INT UNSIGNED NOT NULL ,
  `start_datetime` DATETIME NOT NULL ,
  `end_datetime` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `id_idx` (`application_id` ASC) ,
  INDEX `id_idx1` (`requester_id` ASC) ,
  INDEX `id_idx2` (`release_id` ASC) ,
  INDEX `id_idx3` (`lifecycle_phase_id` ASC) ,
  INDEX `id_idx4` (`server_id` ASC) ,
  INDEX `id_idx5` (`service_id` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `res_application_id`
    FOREIGN KEY (`application_id` )
    REFERENCES `rooseti`.`APPLICATION` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `res_user_id`
    FOREIGN KEY (`requester_id` )
    REFERENCES `rooseti`.`USER` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `res_release_id`
    FOREIGN KEY (`release_id` )
    REFERENCES `rooseti`.`RELEASE` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `res_lifecycle_phase_id`
    FOREIGN KEY (`lifecycle_phase_id` )
    REFERENCES `rooseti`.`LIFECYCLE_PHASE` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `res_server_id`
    FOREIGN KEY (`server_id` )
    REFERENCES `rooseti`.`SERVER` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `res_service_id`
    FOREIGN KEY (`service_id` )
    REFERENCES `rooseti`.`SERVICE` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
