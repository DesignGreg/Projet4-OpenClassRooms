-- MySQL Script generated by MySQL Workbench
-- Wed Nov 14 09:31:01 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projet4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projet4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projet4` DEFAULT CHARACTER SET utf8 ;
USE `projet4` ;

-- -----------------------------------------------------
-- Table `projet4`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projet4`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projet4`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projet4`.`Client` (
  `num_client` INT NOT NULL AUTO_INCREMENT,
  `prenom_client` VARCHAR(45) NOT NULL,
  `nom_client` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`num_client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projet4`.`Localisation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projet4`.`Localisation` (
  `localisation_id` INT NOT NULL AUTO_INCREMENT,
  `voie` VARCHAR(45) NOT NULL,
  `complement` VARCHAR(45) NOT NULL,
  `code_postal` VARCHAR(5) NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(10) NOT NULL,
  `coordonnees_sattelite` REAL NOT NULL,
  PRIMARY KEY (`localisation_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projet4`.`Livreur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projet4`.`Livreur` (
  `num_livreur` INT NOT NULL AUTO_INCREMENT,
  `nom_livreur` VARCHAR(45) NOT NULL,
  `num_plats_en_stock` INT NOT NULL,
  `statut` TINYINT(1) NOT NULL,
  `coordonnes_sattelite` REAL NOT NULL,
  PRIMARY KEY (`num_livreur`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projet4`.`commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projet4`.`commande` (
  `num_commande` INT NOT NULL AUTO_INCREMENT,
  `date_commande` DATE NOT NULL,
  `montant_commande` DECIMAL(3,2) NOT NULL,
  `num_client` INT NOT NULL,
  `localisation_id` INT NOT NULL,
  `num_livreur` INT NOT NULL,
  PRIMARY KEY (`num_commande`),
  INDEX `fk_commande_Client_idx` (`num_client` ASC) VISIBLE,
  INDEX `fk_commande_Localisation1_idx` (`localisation_id` ASC) VISIBLE,
  INDEX `fk_commande_Livreur1_idx` (`num_livreur` ASC) VISIBLE,
  CONSTRAINT `fk_commande_Client`
    FOREIGN KEY (`num_client`)
    REFERENCES `projet4`.`Client` (`num_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_Localisation1`
    FOREIGN KEY (`localisation_id`)
    REFERENCES `projet4`.`Localisation` (`localisation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_Livreur1`
    FOREIGN KEY (`num_livreur`)
    REFERENCES `projet4`.`Livreur` (`num_livreur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projet4`.`Plat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projet4`.`Plat` (
  `num_produit` INT NOT NULL AUTO_INCREMENT,
  `nom_produit` ENUM('1', '2') NOT NULL,
  `ingredients` VARCHAR(45) NOT NULL,
  `prix` DECIMAL(2,2) NOT NULL,
  `num_commande` INT NOT NULL,
  PRIMARY KEY (`num_produit`),
  INDEX `fk_Plat_commande1_idx` (`num_commande` ASC) VISIBLE,
  CONSTRAINT `fk_Plat_commande1`
    FOREIGN KEY (`num_commande`)
    REFERENCES `projet4`.`commande` (`num_commande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projet4`.`Dessert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projet4`.`Dessert` (
  `num_produit` INT NOT NULL AUTO_INCREMENT,
  `nom_produit` ENUM('1', '2') NOT NULL,
  `ingredients` VARCHAR(45) NOT NULL,
  `prix` DECIMAL(2,2) NOT NULL,
  `num_commande` INT NOT NULL,
  PRIMARY KEY (`num_produit`),
  INDEX `fk_Dessert_commande1_idx` (`num_commande` ASC) VISIBLE,
  CONSTRAINT `fk_Dessert_commande1`
    FOREIGN KEY (`num_commande`)
    REFERENCES `projet4`.`commande` (`num_commande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;