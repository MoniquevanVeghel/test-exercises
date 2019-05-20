-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema exercise3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema exercise3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `exercise3` ;
USE `exercise3` ;

-- -----------------------------------------------------
-- Table `exercise3`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise3`.`Specialist` (
  `idSpecialist` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`idSpecialist`),
  UNIQUE INDEX `idSpecialist_UNIQUE` (`idSpecialist` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise3`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise3`.`Medical` (
  `idMedical` INT NOT NULL,
  `Overtime_rate` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`idMedical`),
  UNIQUE INDEX `idMedical_UNIQUE` (`idMedical` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise3`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise3`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `App_date` DATE NOT NULL,
  `App_time` TIME NOT NULL,
  PRIMARY KEY (`idAppointment`),
  UNIQUE INDEX `idAppointment_UNIQUE` (`idAppointment` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise3`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise3`.`Doctor` (
  `idDoctor` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  `Adress` VARCHAR(200) NULL,
  `phone_number` INT(10) NULL,
  `Salary` INT NULL,
  `idSpecialist` INT NOT NULL,
  `idMedical` INT NOT NULL,
  `idAppointment` INT NOT NULL,
  PRIMARY KEY (`idDoctor`),
  UNIQUE INDEX `idDoctor_UNIQUE` (`idDoctor` ASC) VISIBLE,
  INDEX `fk_Specialist_idx` (`idSpecialist` ASC) VISIBLE,
  INDEX `fk_Medical_idx` (`idMedical` ASC) VISIBLE,
  INDEX `fk_Appointment_idx` (`idAppointment` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist`
    FOREIGN KEY (`idSpecialist`)
    REFERENCES `exercise3`.`Specialist` (`idSpecialist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medical`
    FOREIGN KEY (`idMedical`)
    REFERENCES `exercise3`.`Medical` (`idMedical`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment`
    FOREIGN KEY (`idAppointment`)
    REFERENCES `exercise3`.`Appointment` (`idAppointment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise3`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise3`.`Patient` (
  `idPatient` INT NOT NULL,
  `PatientName` VARCHAR(45) NOT NULL,
  `PatientAdress` VARCHAR(200) NULL,
  `Patient_Phone_number` INT(10) NULL,
  `Patient_Date_of_Birth` DATE NOT NULL,
  `idAppointment` INT NULL,
  PRIMARY KEY (`idPatient`),
  UNIQUE INDEX `idPatient_UNIQUE` (`idPatient` ASC) VISIBLE,
  INDEX `fk_pat_appointment_idx` (`idAppointment` ASC) VISIBLE,
  CONSTRAINT `fk_pat_appointment`
    FOREIGN KEY (`idAppointment`)
    REFERENCES `exercise3`.`Appointment` (`idAppointment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise3`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise3`.`Payment` (
  `idPayment` INT NOT NULL,
  `Details` TEXT(100) NOT NULL,
  `Method` VARCHAR(45) NOT NULL,
  `idPatient` INT NOT NULL,
  PRIMARY KEY (`idPayment`),
  UNIQUE INDEX `idPayment_UNIQUE` (`idPayment` ASC) VISIBLE,
  INDEX `fk_Payment_idx` (`idPatient` ASC) VISIBLE,
  CONSTRAINT `fk_Payment`
    FOREIGN KEY (`idPatient`)
    REFERENCES `exercise3`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise3`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise3`.`Bill` (
  `idBill` INT NOT NULL,
  `Total` DECIMAL(2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`idBill`),
  UNIQUE INDEX `idBill_UNIQUE` (`idBill` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise3`.`Bill_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise3`.`Bill_Payment` (
  `idBill_Payment` INT NOT NULL,
  `idBill` INT NOT NULL,
  `idPayment` INT NOT NULL,
  PRIMARY KEY (`idBill_Payment`),
  UNIQUE INDEX `idBill_Payment_UNIQUE` (`idBill_Payment` ASC) VISIBLE,
  INDEX `fk_Bill_Payment_1_idx` (`idBill` ASC) VISIBLE,
  INDEX `fk_Bill_Payment_2_idx` (`idPayment` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Payment_1`
    FOREIGN KEY (`idBill`)
    REFERENCES `exercise3`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_Payment_2`
    FOREIGN KEY (`idPayment`)
    REFERENCES `exercise3`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
