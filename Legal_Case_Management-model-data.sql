use lefti_lupuioan;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Organizations;
DROP TABLE IF EXISTS Organizations_Addresses;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS People_Addresses;
DROP TABLE IF EXISTS People_Roles;
DROP TABLE IF EXISTS People_at_Trial;
DROP TABLE IF EXISTS Cases_Trials;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE IF NOT EXISTS Addresses(
address_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
line_1_number_building INT NOT NULL,
line_2_number_street INT NOT NULL,
line_3_area_locality VARCHAR(50) NOT NULL,
city VARCHAR(50) NOT NULL,
zip_postcode INT NOT NULL,
state_province_county VARCHAR(100) NOT NULL,
country VARCHAR(50) NOT NULL,
other_address_details VARCHAR(200) DEFAULT 'No other details'
);

INSERT INTO `lefti_lupuioan`.`Addresses` (`line_1_number_building`, `line_2_number_street`, `line_3_area_locality`, `city`, `zip_postcode`,
			`state_province_county`, `country`)
VALUES
('54', '56', 'Lipovei', 'Timisoara', '350401', 'Timis', 'Romania'),
('13', '10', 'Aradului', 'Timisoara', '377420', 'Timis', 'Romania'),
('33', '43', 'Torontalului', 'Timisoara', '389003', 'Timis', 'Romania'),
('40', '43', 'Torontalului', 'Timisoara', '389003', 'Timis', 'Romania'),
('1', '20', 'Ghiroda', 'Timisoara', '300000', 'Timis', 'Romania'),
('78', '24', 'Dumbravita', 'Dumbravita', '500773', 'Timis', 'Romania'),
('90', '12', 'Dumbravita', 'Dumbravita', '734678', 'Timis', 'Romania'),
('37', '122', 'Cetatii', 'Timisoara', '787300', 'Timis', 'Romania'),
('33', '122', 'Cetatii', 'Timisoara', '787300', 'Timis', 'Romania');


CREATE TABLE IF NOT EXISTS Organizations(
organization_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
organization_type_code INT NOT NULL,
organization_name VARCHAR(100) NOT NULL,
other_organization_details VARCHAR(200) DEFAULT 'No other details'
);

INSERT INTO `lefti_lupuioan`.`Organizations` (`organization_type_code`, `organization_name`, `other_organization_details`)
VALUES 
('358000', 'Continental', 'Multinationala'),
('087123', 'Smartfit', 'Sala ded sport'),
('670012', 'Nokia', 'Multinationala'),
('900123', 'Netflix', 'Platforma de streaming'),
('300000', 'Tribunal', 'Institutie'),
('123456', 'Jumbo', 'Magazin de jucarii');

CREATE TABLE IF NOT EXISTS Organizations_Addresses(
organization_id INT NOT NULL,
address_id INT NOT NULL,
address_type_code INT NOT NULL,
date_address_from DATE NOT NULL,
date_address_to DATE,
PRIMARY KEY(organization_id, address_id, date_address_from),
FOREIGN KEY(organization_id) REFERENCES Organizations(organization_id),
FOREIGN KEY(address_id) REFERENCES Addresses(address_id)
);

INSERT INTO `lefti_lupuioan`.`Organizations_Addresses` (`organization_id`, `address_id`, `address_type_code`, `date_address_from`,
			`date_address_to`)
VALUES 
('1', '8', '787300', '1999-12-01',NULL),
('2', '7', '734678', '2014-06-13',NULL),
('3', '4', '389003', '1980-03-04',NULL),
('4', '9', '355552', '2004-08-20',NULL),
('5', '9', '300000', '1920-05-04',NULL),
('6', '6', '500773', '2001-11-11', '2028-01-02');

CREATE TABLE IF NOT EXISTS People(
person_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
organization_id INT NOT NULL,
first_name VARCHAR(20) NOT NULL,
middle_name VARCHAR(20) DEFAULT 'No middle name',
last_name VARCHAR(20) NOT NULL,
date_of_birth DATE NOT NULL,
gender VARCHAR(10) DEFAULT 'Unknown',
other_person_details VARCHAR(200) DEFAULT 'No other details',
FOREIGN KEY (organization_id) REFERENCES Organizations(organization_id)
);

INSERT INTO `lefti_lupuioan`.`People` (`organization_id`, `first_name`, `middle_name`, `last_name`, `date_of_birth`, `gender`,
			`other_person_details`) 
VALUES 
('2', 'Cristian', 'Ioan', 'Lupu', '1980-12-25', 'Masculin', 'Sef de echipa'),
('1', 'Petrica', 'Ion', 'Olog', '2000-1-12', 'Masculin',NULL),
('3', 'Ovidiu' ,DEFAULT , 'Costache', '1960-11-23', 'Masculin', 'CEO'),
('2', 'Codrina', 'Mihaela', 'Popescu', '1973-6-2', 'Feminin', 'Secretara'),
('2', 'Ana', DEFAULT, 'Maria', '1989-9-19', 'Feminin',NULL);

CREATE TABLE IF NOT EXISTS People_Addresses(
person_id INT NOT NULL,
address_id INT NOT NULL,
date_address_from DATE NOT NULL,
address_type_code INT NOT NULL,
date_address_to DATE,
PRIMARY KEY(person_id, address_id, date_address_from),	
FOREIGN KEY (address_id) REFERENCES Addresses(address_id),
FOREIGN KEY (person_id) REFERENCES People(person_id)
);

INSERT INTO `lefti_lupuioan`.`People_Addresses` (`person_id`, `address_id`, `date_address_from`, `address_type_code`, `date_address_to`) 
VALUES 
('1', '1', '2000-1-20', '350401', NULL),
('2', '2', '2019-07-15', '377420', '2022-1-1'),
('3', '4', '1980-12-17', '389003', NULL),
('4', '1', '2000-1-20', '350401', NULL),
('5', '3', '1989-9-19', '389002', '1990-5-30');


CREATE TABLE IF NOT EXISTS People_Roles(
person_id INT NOT NULL,
role_code INT NOT NULL,
date_role_from VARCHAR(30) NOT NULL,
date_role_to VARCHAR(30) NOT NULL,
PRIMARY KEY(person_id, role_code),
FOREIGN KEY(person_id) REFERENCES People(person_id)
);

INSERT INTO `lefti_lupuioan`.`People_Roles` (`person_id`, `role_code`, `date_role_from`, `date_role_to`) 
VALUES 
('1', '13', 'Avocat', 'Martor'),
('2', '100', 'Martor', 'Martor'),
('3', '15', 'Judecator', 'Reclamant'),
('4', '24', 'Martor', 'Martor'),
('5', '31', 'Martor', 'Acuzat');


CREATE TABLE IF NOT EXISTS Cases_Trials(
case_trial_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
trial_outcome_code INT NOT NULL,
trial_status_code INT NOT NULL,
trial_address_id INT NOT NULL,
case_reference_number INT NOT NULL,
trial_location_name VARCHAR(200) NOT NULL,
trial_start_date DATE NOT NULL,
expected_duration TIMESTAMP NOT NULL,
trial_end_date DATE DEFAULT '0000-01-01',
other_trial_details VARCHAR(200) DEFAULT 'No other details',
FOREIGN KEY(trial_address_id) REFERENCES Addresses(address_id)
);

INSERT INTO `lefti_lupuioan`.`Cases_Trials` (`trial_outcome_code`, `trial_status_code`, `trial_address_id`, `case_reference_number`,
			`trial_location_name`, `trial_start_date`, `expected_duration`, `trial_end_date`, `other_trial_details`) 
VALUES 
('11', '1', '5', '109', 'Tribunalul Timis', '2013-4-21', '2014-8-2 10:30:00', '2014-8-2', 'Incheiat'),
('22', '2', '5', '333', 'Tribunalul Timis', '2015-2-21', '2016-1-10 10:30:00', '2019-3-29', 'Incheiat'),
('13', '2', '5', '1042', 'Tribunalul Timis', '2021-1-23', '2022-9-17 09:30:00', DEFAULT, 'Deschis'),
('84', '1', '5', '1832', 'Tribunalul Timis', '2021-12-3', '2022-11-20 10:45:30', DEFAULT, 'Deschis'),
('511', '2', '5', '200', 'Tribunalul Timis', '2014-8-21', '2014-9-15 10:15:00', '2014-10-13', 'Incheiat');



CREATE TABLE IF NOT EXISTS People_at_Trial(
trial_id INT NOT NULL,
person_id INT NOT NULL,
role_code INT NOT NULL,
appearance_nr INT NOT NULL,
appearance_start_datetime DATETIME NOT NULL,
appearance_end_datetime DATETIME NOT NULL,
other_details VARCHAR(200) DEFAULT 'No other details',
PRIMARY KEY(trial_id, person_id, role_code, appearance_nr),
FOREIGN KEY(person_id, role_code) REFERENCES People_Roles(person_id, role_code),
FOREIGN KEY(trial_id) REFERENCES Cases_Trials(case_trial_id)
);

INSERT INTO `lefti_lupuioan`.`People_at_Trial` (`trial_id`, `person_id`, `role_code`, `appearance_nr`, `appearance_start_datetime`, `appearance_end_datetime`, `other_details`) 
VALUES 
('2', '1', '13', '4', '2022-10-14 10:00:00', '2022-10-14 10:30:00', DEFAULT),
('1', '2', '100', '7', '2021-8-21 09:30:00', '2021-8-22 16:00:00', DEFAULT),
('1', '3', '15', '4', '2021-8-21 09:30:00', '2021-8-22 16:00:00', DEFAULT),
('2', '4', '24', '5', '2022-10-14 10:30:00', '2022-10-14 11:00:00', DEFAULT),
('1', '5', '31', '2', '2021-8-21 09:30:00', '2021-8-22 16:00:00', 'Nu are avocat');
