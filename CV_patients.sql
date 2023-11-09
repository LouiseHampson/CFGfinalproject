CREATE DATABASE CVPatients;
USE CVPatients;

CREATE TABLE patient_info (
	patient_id INT NOT NULL AUTO_INCREMENT, #set as primary key, see line 14 for adding the constraint
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	DOB YEAR NOT NULL,
	age INT NOT NULL,
    gender VARCHAR(7) NOT NULL,
	height_m DECIMAL(3,2),
	weight_kg INT,
    smoker BOOLEAN, #1 = true, Smoker, 0= nonsmoker (not true)
	CONSTRAINT pk_patinet_id PRIMARY KEY (patient_id)     #made a spelling mistake here on the name of the primary key but as its just the name which I won't refer to, i'll leave it. I could drop the table and regenerate if needed
);

ALTER TABLE patient_info AUTO_INCREMENT=1000; #To make the patient_id start on a different number than 1.


INSERT INTO patient_info (first_name, last_name, DOB, age, gender, height_m, weight_kg, smoker) #don't need to add patient_id as it will autogenerate
VALUES
('Jane', 'Doe', 1969, 53, 'F', 1.63, 78, 1),
('John', 'Smith', 1962, 60, 'M', 1.77, 87, 1),
('Fred', 'White', 1945, 77, 'M', 1.9, 89, 1),
('Jack', 'Black', 1941, 81, 'M', 1.84, 90, 0),
('Mary', 'Jones', 1953, 69, 'F', 1.72, 86, 0),
('Susan','Muffin', 1950, 72, 'F', 1.76, 90, 1),
('Daniel', 'Hamilton', 1950,72, 'M', 1.71, 88, 1),
('Abraham',	'Saiyed', 1946,	76,	'M', 1.87, 104,	1),
('Lisa', 'Faz', 1961, 61, 'F', 1.6, 71, 0),
('Simon', 'Little', 1963, 59, 'M', 1.89, 89, 1),
('Ben', 'Hawkens', 1952, 70, 'M', 1.85,	91,	0),
('Jade','Jones', 1945, 77, 'F', 1.79, 92, 1),
('Sadie', 'Golden',	1941, 81, 'F', 1.78, 85, 1),
('Jessica', 'Fuller', 1964,	58,	'F', 1.68, 80, 0),
('Matthew', 'Jefferies', 1967, 55, 'M',1.69, 93,1),
('Marie', 'Brood', 1973, 49, 'F', 1.66,	89,	0),
('Thomas', 'Joiner', 1967, 55, 'M', 1.7, 99, 1),
('Nicholas', 'Porter', 1968, 54, 'M', 1.83,	100,0),
('James', 'Hall', 1969,	53,	'M', 1.85, 101,	1),
('Adrian', 'Thomas', 1955, 67, 'M', 1.8, 88, 1),
('Adam', 'Murphy', 1972, 50, 'M', 1.85, 97,	0),
('Samuel', 'Pascoe', 1980, 42, 'M', 1.78, 115, 1);

Select * from patient_info;#To check that everything has been entered OK and the patient_id has been created with the auto increment.
DESC patient_info; #To check table is set up properly

#Forgot to add BMI to the table :( - go back to add the column and UPDATE the data (couldn't find out how to do it as one long list of insert so I updated it row by row
ALTER TABLE patient_info
ADD COLUMN BMI DECIMAL (4,2) AFTER weight_kg;
#Add in BMI date using where clause:
UPDATE patient_info SET BMI = 29.36 where patient_id = 1000;
UPDATE patient_info SET BMI = 27.77 where patient_id = 1001;
UPDATE patient_info SET BMI = 27.15 where patient_id = 1002;
UPDATE patient_info SET BMI = 26.58 where patient_id = 1003;
UPDATE patient_info SET BMI = 29.07 where patient_id = 1004;
UPDATE patient_info SET BMI = 29.05 where patient_id = 1005;
UPDATE patient_info SET BMI = 30.09 where patient_id = 1006;
UPDATE patient_info SET BMI = 29.74 where patient_id = 1007;
UPDATE patient_info SET BMI = 27.73 where patient_id = 1008;
UPDATE patient_info SET BMI = 24.92 where patient_id = 1009;
UPDATE patient_info SET BMI = 26.59 where patient_id = 1010;
UPDATE patient_info SET BMI = 28.71 where patient_id = 1011;
UPDATE patient_info SET BMI = 26.83 where patient_id = 1012;
UPDATE patient_info SET BMI = 28.34 where patient_id = 1013;
UPDATE patient_info SET BMI = 32.56 where patient_id = 1014;
UPDATE patient_info SET BMI = 32.30 where patient_id = 1015;
UPDATE patient_info SET BMI = 34.26 where patient_id = 1016;
UPDATE patient_info SET BMI = 29.86 where patient_id = 1017;
UPDATE patient_info SET BMI = 29.51 where patient_id = 1018;
UPDATE patient_info SET BMI = 27.16 where patient_id = 1019;
UPDATE patient_info SET BMI = 28.34 where patient_id = 1020;
UPDATE patient_info SET BMI = 36.30 where patient_id = 1021;

select * from patient_info;


#Cholesterol levels are a big risk factor for cardiovascular disease, so have a separate table with this data
CREATE table cholesterol (
	patient_id INT NOT NULL, #set as foreign key as it is the same patient_id as in patient_info table 
	LDL_c INT, 
	HDL_c INT, 
	total_c INT,
	statins BOOLEAN, #1 = YES/True
    CONSTRAINT FK_patient_id FOREIGN KEY (patient_id)
    REFERENCES patient_info(patient_id)
    );

INSERT into cholesterol (patient_id, LDL_c, HDL_c, total_c, statins)
VALUES 
(1000,	161,	42,	240,	1),
(1001,	159,	50,	255,	1),
(1002,	152,	54,	255,	0),
(1003,	152,	39,	269,	1),
(1004,	150,	43,	230,	0),
(1005,	155,	51,	260,	0),
(1006,	164,	40,	241,	1),
(1007,	165,	37,	231,	1),
(1008,	163,	49,	270,	1),
(1009,	162,	58,	244,	1),
(1010,	159,	42,	248,	1),
(1011,	157,	46,	248,	0),
(1012,	160,	55,	241,	1),
(1013,	159,	42,	244,	1),
(1014,	170,	31,	259,	1),
(1015,	160,	53,	266,	1),
(1016,	154,	46,	267,	1),
(1017,	152,	40,	237,	0),
(1018,	159,	45,	239,	0),
(1019,	155,	47,	260,	0),
(1020,	158,	41,	270,	1),
(1021,	178,	34,	266,	1)
;

SELECT * from cholesterol
WHERE statins = 1;
DROP table cholesterol;

#What other conditions do these patients have? 
#If they have other conditions such as diabetes, etc, they are at increased risk having heart attack. 
CREATE table comorbidities (
	patient_id INT NOT NULL, #label as foreign key constraint
	diabetes BOOLEAN, 
	autoimmune_disease VARCHAR(50),
	renal BOOLEAN,
    CONSTRAINT FK_patient_id2 FOREIGN KEY (patient_id)
    REFERENCES patient_info(patient_id)
);

INSERT into comorbidities (patient_id, diabetes, autoimmune_disease, renal)
VALUES
(1000,	1,	'RA',	1),
(1001,	0,	NULL,	0),
(1002,	0,	NULL,	0),
(1003,	1,	'RA',	1),
(1004,	1,	'RA',	1),
(1005,	1,	NULL,	0),
(1006,	0,	NULL,	0),
(1007,	1,	'Lupus',	0),
(1008,	1,	NULL,	1),
(1009,	0,	NULL,	0),
(1010,	1,	NULL,	0),
(1011,	0,	'sjogrens',	1),
(1012,	0,	'lupus',	1),
(1013,	0,	NULL,	0),
(1014,	0,	'RA',	0),
(1015,	0,	'RA',	0),
(1016,	1,	NULL,	1),
(1017,	0,	NULL,	1),
(1018,	1,	NULL,	1),
(1019,	0,	'Lupus',	0),
(1020,	0,	NULL,	0),
(1021,	1,	NULL,	1);

SELECT * from comorbidities;

#What event did they have? Have they had multiple events? 
CREATE table cardio_events #events on it own seemed to be keyword so I named this cardio_events instead
(patient_id INT NOT NULL, #label as foreign key constraint
cvevent VARCHAR(20),
CONSTRAINT FK_patient_id3 FOREIGN KEY (patient_id)
REFERENCES patient_info(patient_id)
);


INSERT into cardio_events (patient_id, cvevent)
VALUES 
(1000,	'angina'),
(1002,	'Stroke'),
(1003,	'angina'), 	
(1003, 'Heart attack'),
(1004,	'TIA'),	
(1004, 'Stroke'),
(1005,	'TIA'),
(1006,	'Heart attack'),
(1007,	'Heart attack'),
(1007, 'stroke'),
(1008,	'TIA'),
(1008,	'Heart attack'),
(1009,	'Heart attack'),
(1009,	'Stroke'),
(1010,	'Heart attack'),
(1011,	'Stroke'),
(1012,	'Stroke'),
(1013,	'angina'),
(1013,	'heart attack'),
(1014,	'Heart attack'),
(1015,	'TIA'),
(1015,	'stroke'),
(1016,	'TIA'),
(1017,	'TIA'),
(1018,	'TIA'),
(1019,	'stroke'),
(1020,	'heart attack'),
(1021,	'heart attack'),
(1021,	'heart attack');


select * from cardio_events;

select * from cardio_events;
select patient_id, COUNT(*) from cardio_events
group by patient_id;


#Did the patient have to have surgery as a treatment?
CREATE table surgeries (
	patient_id INT NOT NULL, #label as foreign key constraint
    surgery_type VARCHAR(35),
    surgery_date DATE,
    CONSTRAINT FK_patient_id4 FOREIGN KEY (patient_id)
    REFERENCES patient_info(patient_id)
    );
    
INSERT INTO surgeries
(patient_id, surgery_type, surgery_date)
VALUES		
(1001, 'endarterectomy', '2019-09-21');
(1004,	'endarterectomy', '2021-07-13'),
(1005,	'endarterectomy', '2020-08-15'),	
(1008,	'CABG', '2022-01-03'),
(1009, 'endarterectomy', '2019-03-28'),
(1010,	'stent', '2022-05-05'),		
(1013,	'CABG', '2020-06-16'),
(1014,	'stent', '2020-11-23'),
(1015,	'endarterectomy', '2021-12-24'),
(1016,	'endarterectomy', '2019-09-11'),
(1019, 'endarterectomy', '2019-08-23'),
(1020,	'stent', '2018-10-01'),
(1021,	'CABG', '2022-11-05');

select * from surgeries;
    
#What drugs are these patients on? eg for blood pressure, blood thinning, etc 
CREATE table cardio_medications (
	patient_id INT NOT NULL, #label as foreign key constraint
	medication VARCHAR(20),
	CONSTRAINT FK_patient_id5 FOREIGN KEY (patient_id)
	REFERENCES patient_info(patient_id)
	);
    
INSERT into cardio_meds (patient_id, medication)
VALUES 
    (1000,	'nitroglycerin'),
	(1001,	'aspirin'),
    (1001, 'ACE inhibitor'),
	(1002,	'aspirin'),
	(1002,	'ACE inhibitor'),
	(1003,	'nitroglycerin'),
    (1003,	'beta blocker'),
	(1003,	'antiplatelet'),
	(1004,	'aspirin'),
	(1004,	'ACE inhibitor'),
	(1005,	'aspirin'),
	(1006,	'antiplatelet'),
    (1007,	'antiplatelet'),
	(1007,	'beta blocker'),
	(1008,	'aspirin'),
	(1008,	'ACE inhibitor'),
	(1009,	'ACE inhibitor'),
	(1009,	'aspirin'),
    (1010, 'antiplatelet'),
	(1010,	'beta blocker'),
	(1011,	'aspirin'),
	(1012,	'aspirin'),
	(1013,	'nitroglycerin'),
	(1013,	'beta blocker'),
	(1014,	'antiplatelet'),
	(1015,	'aspirin'),
	(1016,	'antiplatelet'),
	(1018,	'antiplatelet'),
	(1019,	'aspirin'),
	(1020,	'antiplatelet'),
	(1021,	'antiplatelet'),
	(1021,	'beta blocker');

select * from cardio_meds;

#Drugs for other conditions - eg diabetes, autoimmune diseases.
CREATE table other_meds (   #Multiple entries if the patient has >1 drug here, no entry if no drugs
	patient_id INT NOT NULL, #label as foreign key constraint
	medication VARCHAR(20),
    CONSTRAINT FK_patient_id6 FOREIGN KEY (patient_id)
	REFERENCES patient_info(patient_id)
    );
    
INSERT INTO other_meds (patient_id, medication)
VALUES
(1000,	'metformin'),
(1000,	'remicade'),
(1003,	'metformin'),
(1004,	'metformin'),
(1005,	'pioglitazone'),
(1007,	'metformin'),
(1008,	'pioglitazone'),
(1010,	'pioglitazone'),
(1011,	'humira'),
(1012,	'dexamethasone'),
(1012,	'remicade'),
(1014,	'remicade'),
(1015,	'humira'),
(1016,	'pioglitazone'),
(1018,	'metformin'),
(1021,	'metformin');  
    
#TO DO:
#analyses - joins - look at joining patients AND surgeries, events and surgeries, BMI with cholesterol? Smoker status with events
#autoimmune disease with events 

# functions for BMI, and total: HDL cholesterol ratios
#SPROC/ PROCEDURES? what can i do for this????
#IF statements - eg if LDL is above X then HIGH, if below Y then LOW
#CREATE VIEWS for patient anonymisation, 
# AVG BMI, 
#youngest patient with heart attack, oldest patient with heart attack, COUNT heart attacks, strokes, etc
#COUNT patients with co mordbidities
#COUNT male/females with events, on drugs, etc
-------------------
------------------
# Put analyses in separate file for scripts with annotation
#Decide what to show in tableau
#Work on tableau
#rerun EER diagram to incorporate VIEWS
#CREATE TRIGGER and or EVENT**
#Make another VIEW - patients with CV events? patients with high cholesterol and events?
#SUBQUERY
#Go through checklist and ensure everything is done
#Back up and test this
#Submission
#TOCREATE PROCEDURE
-------------------
#Analysis:


#1. Basic characteristics of patients:
Select COUNT(*) from patient_info WHERE gender = 'F';
#There are 8 females in the data

Select COUNT(*) from patient_info WHERE gender = 'M';
#There are 14 Males in the data
Select COUNT(*) from patient_info; #just to check maths is correct)
#There are 22 patients in total

Select COUNT(*) from patient_info where smoker = 1;
#There are 14 patients who smoke

SELECT MIN(DOB) from patient_info;
#The oldest patient was born in 1941
SELECT MAX(DOB) from patient_info;
#Youngest patient ws born in 1940
SELECT AVG(age) from patient_info;
#Average age is 63.22 years

#AVG age of women, and avg age men in this data set?
SELECT AVG(age) from patient_info
WHERE gender = 'F';
#AVG age of women is 65 years
SELECT AVG(age) from patient_info
WHERE gender = 'M';
#AVG age of women is 62 years

#Cholesterol analysis
#Using logical operators, assign labels to LDL-c levels to say "At risk', 'Dangerously high' or 'Healthy'
DROP FUNCTION IF EXISTS Cholesterol_risk (
LDL_c INT
)
DELIMITER //
CREATE function Cholesterol_risk (
LDL_c INT
)
RETURNS VARCHAR(20)
DETERMINISTIC 
BEGIN
	DECLARE LDL_risk VARCHAR(25);
    IF LDL_c >= 160 #add in cholesterol limits here to complete function
		THEN 
		SET LDL_risk = 'Dangerously high';
	ELSEIF LDL_c >=101 AND LDL_c <=159 #add in cholesterol limits here to complete function
		THEN 
		SET LDL_risk = 'At risk';
	ELSEIF LDL_c <=100 #add in cholesterol limits here to complete function
		THEN
        SET LDL_risk = 'Healthy';
	END IF;
    RETURN (LDL_risk);
    
END//
DELIMITER ;

#TEST if it works:
SELECT patient_id, LDL_c, Cholesterol_risk(LDL_c)
FROM cholesterol;
#Show patient names, LDL_c levels and cholesterol risk category
SELECT p.patient_id, p.first_name, p.last_name, c.LDL_c, Cholesterol_risk(LDL_c) FROM patient_info p
LEFT JOIN cholesterol c
ON p.patient_id = c.patient_id
WHERE Cholesterol_risk(LDL_c) = 'dangerously high'; #to show those patients most at risk from cardiovascular event, based on cholesterol levels
#returns 9 rows/patients


#Create a Stored Function to assign BMI in categories (eg Normal, Overweight, Obese)

DROP FUNCTION IF EXISTS BMI_desc;
DELIMITER //
CREATE function BMI_desc (
	BMI INT
    )
RETURNS VARCHAR(20)
DETERMINISTIC 
BEGIN
	DECLARE BMI_status VARCHAR(20);
	IF BMI > 30.00 THEN 
		SET BMI_status = 'Obese'; 
	ELSEIF (BMI >= 26 AND BMI <=29.99) THEN
        SET BMI_status = 'Overweight';  
    ELSEIF (BMI >= 20 AND BMI <=25) THEN
        SET BMI_status = 'Normal';
	END IF;
    RETURN (BMI_status);

END//
DELIMITER ;


select patient_id, first_name, last_name, BMI, BMI_desc(BMI) AS BMI_category
FROM patient_info;
#Produces table expected but there are some NULL values in there, and not quite sure why, as there are no NULL BMI values
select patient_id, BMI from patient_info; #shows that all rows are populated with values for BMI


#Cardio_events analysis
#Create join to show patients who have had a heart attack
SELECT first_name, last_name, event_1, event_2 from patient_info
LEFT JOIN cardio_events
ON patient_info.patient_id = cardio_events.patient_id
WHERE cardio_events.event_1  = 'heart attack' OR cardio_events.event_2 = 'heart attack';


#Which patients have had a heart attack AND a stroke
SELECT first_name, last_name, event_1, event_2 from patient_info
LEFT JOIN cardio_events
ON patient_info.patient_id = cardio_events.patient_id
WHERE cardio_events.event_1  = 'heart attack' AND cardio_events.event_2  = 'stroke';

#names of patients who have angina
SELECT first_name, last_name, event_1, event_2 from patient_info
LEFT JOIN cardio_events
ON patient_info.patient_id = cardio_events.patient_id
WHERE cardio_events.event_1  = 'angina' OR cardio_events.event_2  = 'angina';

#How many patients suffer from Angina
SELECT COUNT(*) from patient_info
LEFT JOIN cardio_events
ON patient_info.patient_id = cardio_events.patient_id
WHERE cardio_events.event_1  = 'angina' OR cardio_events.event_2  = 'angina';


#Patients who have had a cardiovascular event AND also have an autoimmune disease (co-morbidity), and what is the co-morbidity
SELECT p.first_name, p.last_name, c.event_1, c.event_2, m.autoimmune_disease from patient_info p
INNER JOIN comorbidities m
ON p.patient_id = m.patient_id
LEFT JOIN cardio_events c
ON p.patient_id = c.patient_id
WHERE m.autoimmune_disease IS NOT NULL;

#Shows which patients have had surgery as treatment:
select p.first_name, p.last_name, s.surgery_type FROM patient_info p
LEFT JOIN surgeries s
ON p.patient_id = s.patient_id
WHERE surgery_type IS NOT NULL; #those patients not had surgery are excluded from these results


#Create a VIEW
#Data for clinical trials or analysis for research are often anonymised and the patient names are removed.
#Create a view without the patient names

CREATE VIEW anon_patients 
AS 
SELECT patient_id, DOB, age, gender, BMI, smoker
FROM patient_info;

select * from anon_patients;

select * from surgeries;


#Stored procedures




DROP FUNCTION SurgeryReview; IF EXISTS;
DELIMITER // 
CREATE FUNCTION SurgeryReview(
	patient_id INT 
)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE review_required VARCHAR(10);
		IF timestampdiff(MONTH, surgery_date(), current_date()) > 12
			THEN SET review_required = 'YES';
		ELSEIF  timestampdiff(MONTH, surgery_date(), current_date()) < 12
			THEN SET review_required = 'NO';
    END IF;
    RETURN (review_required);
END //
DELIMITER ; 


#SUBQUERY: 
select patient_id, BMI, age
FROM patient_info
WHERE BMI > (SELECT AVG(BMI) from patient_info);

SELECT patient_id, weight_kg, BMI, age, gender 
FROM patient_info
WHERE BMI > (SELECT AVG(BMI) > 30 from patient_info);