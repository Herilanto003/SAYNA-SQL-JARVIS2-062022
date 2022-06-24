-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema jarvis_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema jarvis_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jarvis_project` DEFAULT CHARACTER SET utf8 ;
USE `jarvis_project` ;

-- -----------------------------------------------------
-- Table `jarvis_project`.`Utilisateurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Utilisateurs` (
  `id_u` INT NOT NULL,
  `nom_u` VARCHAR(45) NULL,
  `prenom_u` VARCHAR(255) NULL,
  `date_nais` DATE NULL,
  `sexe_u` VARCHAR(25) NULL,
  `email` VARCHAR(255) NULL,
  `mdp` VARCHAR(255) NULL,
  PRIMARY KEY (`id_u`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis_project`.`Membre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Membre` (
  `id_m` INT NOT NULL,
  `lien_parente` VARCHAR(45) NULL,
  `Utilisateurs_id_u` INT NOT NULL,
  PRIMARY KEY (`id_m`, `Utilisateurs_id_u`),
  INDEX `fk_Membre_Utilisateurs1_idx` (`Utilisateurs_id_u` ASC),
  CONSTRAINT `fk_Membre_Utilisateurs1`
    FOREIGN KEY (`Utilisateurs_id_u`)
    REFERENCES `jarvis_project`.`Utilisateurs` (`id_u`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis_project`.`Co-proprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Co-proprietaire` (
  `id_co_pro` INT NOT NULL,
  `Utilisateurs_id_u` INT NOT NULL,
  PRIMARY KEY (`id_co_pro`, `Utilisateurs_id_u`),
  INDEX `fk_Co-proprietaire_Utilisateurs1_idx` (`Utilisateurs_id_u` ASC),
  CONSTRAINT `fk_Co-proprietaire_Utilisateurs1`
    FOREIGN KEY (`Utilisateurs_id_u`)
    REFERENCES `jarvis_project`.`Utilisateurs` (`id_u`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis_project`.`Proprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Proprietaire` (
  `id_pro` INT NOT NULL,
  `Utilisateurs_id_u` INT NOT NULL,
  PRIMARY KEY (`id_pro`, `Utilisateurs_id_u`),
  INDEX `fk_Proprietaire_Utilisateurs1_idx` (`Utilisateurs_id_u` ASC),
  CONSTRAINT `fk_Proprietaire_Utilisateurs1`
    FOREIGN KEY (`Utilisateurs_id_u`)
    REFERENCES `jarvis_project`.`Utilisateurs` (`id_u`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis_project`.`Domicile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Domicile` (
  `id_dom` INT NOT NULL,
  `annee_construction` DATE NULL,
  `superficie` FLOAT NULL,
  `Proprietaire_id_pro` INT NOT NULL,
  `Proprietaire_Utilisateurs_id_u` INT NOT NULL,
  PRIMARY KEY (`id_dom`),
  INDEX `fk_Domicile_Proprietaire1_idx` (`Proprietaire_id_pro` ASC, `Proprietaire_Utilisateurs_id_u` ASC),
  CONSTRAINT `fk_Domicile_Proprietaire1`
    FOREIGN KEY (`Proprietaire_id_pro` , `Proprietaire_Utilisateurs_id_u`)
    REFERENCES `jarvis_project`.`Proprietaire` (`id_pro` , `Utilisateurs_id_u`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis_project`.`Piece`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Piece` (
  `id_piece` INT NOT NULL,
  `nom_piece` VARCHAR(255) NULL,
  `Domicile_id_dom` INT NOT NULL,
  PRIMARY KEY (`id_piece`),
  INDEX `fk_Piece_Domicile1_idx` (`Domicile_id_dom` ASC),
  CONSTRAINT `fk_Piece_Domicile1`
    FOREIGN KEY (`Domicile_id_dom`)
    REFERENCES `jarvis_project`.`Domicile` (`id_dom`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis_project`.`Appareils`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Appareils` (
  `id_appareil` INT NOT NULL,
  `nom_appareil` VARCHAR(45) NULL,
  `type_appareil` VARCHAR(45) NULL,
  `Piece_id_piece` INT NOT NULL,
  PRIMARY KEY (`id_appareil`, `Piece_id_piece`),
  INDEX `fk_Appareils_Piece1_idx` (`Piece_id_piece` ASC),
  CONSTRAINT `fk_Appareils_Piece1`
    FOREIGN KEY (`Piece_id_piece`)
    REFERENCES `jarvis_project`.`Piece` (`id_piece`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis_project`.`Contenir`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Contenir` (
  `Domicile_id_dom` INT NOT NULL,
  `Utilisateurs_id_u` INT NOT NULL,
  PRIMARY KEY (`Domicile_id_dom`, `Utilisateurs_id_u`),
  INDEX `fk_Domicile_has_Utilisateurs_Utilisateurs1_idx` (`Utilisateurs_id_u` ASC),
  INDEX `fk_Domicile_has_Utilisateurs_Domicile_idx` (`Domicile_id_dom` ASC),
  CONSTRAINT `fk_Domicile_has_Utilisateurs_Domicile`
    FOREIGN KEY (`Domicile_id_dom`)
    REFERENCES `jarvis_project`.`Domicile` (`id_dom`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Domicile_has_Utilisateurs_Utilisateurs1`
    FOREIGN KEY (`Utilisateurs_id_u`)
    REFERENCES `jarvis_project`.`Utilisateurs` (`id_u`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis_project`.`Inviter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis_project`.`Inviter` (
  `Utilisateurs_id_u` INT NOT NULL,
  `Proprietaire_id_pro` INT NOT NULL,
  PRIMARY KEY (`Utilisateurs_id_u`, `Proprietaire_id_pro`),
  INDEX `fk_Utilisateurs_has_Proprietaire_Proprietaire1_idx` (`Proprietaire_id_pro` ASC),
  INDEX `fk_Utilisateurs_has_Proprietaire_Utilisateurs1_idx` (`Utilisateurs_id_u` ASC),
  CONSTRAINT `fk_Utilisateurs_has_Proprietaire_Utilisateurs1`
    FOREIGN KEY (`Utilisateurs_id_u`)
    REFERENCES `jarvis_project`.`Utilisateurs` (`id_u`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Utilisateurs_has_Proprietaire_Proprietaire1`
    FOREIGN KEY (`Proprietaire_id_pro`)
    REFERENCES `jarvis_project`.`Proprietaire` (`id_pro`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
