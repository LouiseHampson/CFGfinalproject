USE CVpatients;

#Analysis:

#1. Basic characteristics of patients:
select * from patient_info;

select AVG(AGE), AVG(BMI), AVG(weight_kg) from patient_info;

Select COUNT(*) from patient_info WHERE gender = 'F';
#There are 8 females in the data

Select COUNT(*) from patient_info WHERE gender = 'M';
#There are 14 Males in the data
Select COUNT(*) from patient_info; #just to check maths is correct
#There are 22 patients in total


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

#How many patients are smokers? (Smoking is a risk factor for cardiovascular disease)
Select COUNT(*) from patient_info where smoker = 1;
#There are 14 patients who smoke

#Which patients have a BMI over 30
SELECT patient_id, first_name, last_name, weight_kg, BMI, age, gender 
FROM patient_info
	WHERE BMI > 30;
       
select AVG(BMI) from patient_info;
#average BMI in this population is 29.19    
    
#Who are the patients that have a BMI above the average BMI in this group (Using SUBQUERY): 
select patient_id, first_name, last_name, BMI, age
FROM patient_info
WHERE BMI > (SELECT AVG(BMI) from patient_info);    
    
    
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
	IF BMI >= 30 THEN 
		SET BMI_status = 'Obese'; 
	ELSEIF (BMI >= 26 AND BMI <=29) THEN
        SET BMI_status = 'Overweight';  
    ELSEIF (BMI >= 20 AND BMI <=25) THEN
        SET BMI_status = 'Normal';
	END IF;
    RETURN (BMI_status);

END//
DELIMITER ;

select patient_id, first_name, last_name, BMI, BMI_desc(BMI) AS BMIcategory
FROM patient_info;
#This creates the BMI_category 

#Show BMI categorisation by gender
select gender, BMI_desc(BMI) AS BMIcategory, COUNT(*) from patient_info
GROUP BY gender,BMIcategory 
ORDER BY gender;

#To just show those people that are obese, by gender
select gender, BMI_desc(BMI) AS BMIcategory, COUNT(*) from patient_info
GROUP BY gender, BMIcategory
HAVING BMIcategory = 'Obese';



#When patient data is used for research purposes, the names of patients are anonymised and kept hidden from researchers, eg for a 'blind' trial. 
# VIEW created to ommit patient firstname and lastname:
CREATE VIEW anon_patients
AS 
SELECT patient_id, DOB, age, gender, BMI, smoker FROM patient_info;

SELECT * FROM anon_patients;

#2.Cholesterol analysis:
#LDL cholesterol is "the bad cholesterol", levels correlate to risk of blocked arteries and therefore heart attacks.
#Created a function to assign LDL-c cholesterol levels to a category: "At risk', 'Dangerously high' or 'Healthy'
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
    IF LDL_c >= 160 
		THEN 
		SET LDL_risk = 'Dangerously high';
	ELSEIF LDL_c >=101 AND LDL_c <=159 
		THEN 
		SET LDL_risk = 'At risk';
	ELSEIF LDL_c <=100 
		THEN
        SET LDL_risk = 'Healthy';
	END IF;
    RETURN (LDL_risk);
    
END//
DELIMITER ;

SELECT patient_id, LDL_c, Cholesterol_risk(LDL_c)
FROM cholesterol;

#To show number of patients in each category (we know from initial analysis of patient characteristics there are 22 patients in total)
SELECT Cholesterol_risk(LDL_c) AS Category, COUNT(Cholesterol_risk(LDL_c)) AS Num_Patients
FROM cholesterol
GROUP BY Cholesterol_risk(LDL_c);


#Show the patients that are in the 'dangerously high' category for cholesterol levels. 
SELECT p.patient_id, p.first_name, p.last_name, c.LDL_c, Cholesterol_risk(LDL_c) AS Category FROM patient_info p
LEFT JOIN cholesterol c
ON p.patient_id = c.patient_id
WHERE Cholesterol_risk(LDL_c) = 'dangerously high'; 
#returns 9 rows/patients

SELECT p.patient_id, p.first_name, p.last_name, c.LDL_c, Cholesterol_risk(LDL_c) AS Category FROM patient_info p
LEFT JOIN cholesterol c
ON p.patient_id = c.patient_id
WHERE Cholesterol_risk(LDL_c) = 'at risk'; 

#SHow how many people are in the 'dangerously high' and the 'at risk' categories:
SELECT category, COUNT(*) FROM 
	(
	SELECT p.patient_id, p.first_name, p.last_name, c.LDL_c, Cholesterol_risk(LDL_c) AS Category FROM patient_info p
	LEFT JOIN cholesterol c
	ON p.patient_id = c.patient_id
    ) AS category
    GROUP BY category
    ;

#Which patients have the highest LDL cholesterol?
SELECT p. first_name, p. last_name, c. LDL_c from patient_info p
INNER JOIN cholesterol c
ON p.patient_id = c.patient_id
ORDER BY LDL_c DESC
LIMIT 5;

#Does statin medication correlate to LDL cholesterol levels? 
select patient_id, LDL_c, Cholesterol_risk(LDL_c), statins from cholesterol
WHERE statins = 1
ORDER BY Cholesterol_risk(LDL_c); 
#all patients who have 'dangerously high' cholesterol levels are taking statins, and some who are 'at risk'

select patient_id, LDL_c, Cholesterol_risk(LDL_c), statins from cholesterol
WHERE statins = 0
ORDER BY Cholesterol_risk(LDL_c); 
#some patients who are 'at risk' are not on statins


#3. CV Events analysis

#Which patients have had heart attacks? 
select p.patient_id, first_name, last_name, cvevent from patient_info p
RIGHT JOIN cardio_events e
ON e.patient_id = p.patient_id
WHERE cvevent = 'heart attack';

#Do males or females have more heart attacks?
select p.patient_id, first_name, last_name, p.gender, e.cvevent from patient_info p
RIGHT JOIN cardio_events e
ON e.patient_id = p.patient_id
WHERE cvevent = 'heart attack';

select gender, COUNT(*), e.cvevent from patient_info p
RIGHT JOIN cardio_events e
ON e.patient_id = p.patient_id
WHERE cvevent = 'heart attack'
GROUP BY gender
	HAVING gender = 'M'; #Can use HAVING to only find out the data for how many men have had heart attack
#In this population, males have had more heart attacks than females

#How many women in the group have had strokes?
select gender, COUNT(*), e.cvevent from patient_info p
RIGHT JOIN cardio_events e
ON e.patient_id = p.patient_id
WHERE cvevent = 'stroke'
GROUP BY gender
	HAVING gender = 'F'; 
#There are 4 women who have had strokes

select gender, COUNT(*), e.cvevent from patient_info p
RIGHT JOIN cardio_events e
ON e.patient_id = p.patient_id
WHERE cvevent = 'TIA'
GROUP BY gender;
	

#Number of each event category: (TIA = trans ischemic attack)
select cvevent, COUNT(cvevent) from cardio_events
GROUP BY cvevent
ORDER BY COUNT(cvevent) DESC; #To show event with largest count first


#Which patients have had more than one CV event?
select patient_id, COUNT(cvevent) AS num_events from cardio_events
GROUP BY patient_id;

#What drugs are these patients on?
select p.patient_id, p.first_name, p.last_name, m.medication from patient_info p
LEFT JOIN cardio_medications m
ON p.patient_id = m.patient_id;

#4. Other diseases anlaysis
#What other diseases do these patients have? 
select p.patient_id, p.first_name, p.last_name, diabetes, autoimmune_disease, renal from patient_info p
LEFT JOIN comorbidities co
ON p.patient_id = co.patient_id;


#Which patients have RA (rheumatoid arthritis)?
select p.patient_id, p.first_name, p.last_name, diabetes, autoimmune_disease, renal from patient_info p
LEFT JOIN comorbidities co
ON p.patient_id = co.patient_id
WHERE autoimmune_disease  = 'RA';
    
#Which patients have diabetes? 
select p.patient_id, p.first_name, p.last_name, diabetes from patient_info p
LEFT JOIN comorbidities co
ON p.patient_id = co.patient_id
WHERE diabetes  = 1;

#5. Medications
#CREATE VIEW TO SHOW ALL Co-morbidities AND ALL medications (join 3 tables together - patient_info, cardio_medications and other_meds)
CREATE VIEW all_patientmeds
AS
SELECT p.patient_id, p.first_name, p.last_name, m.medication AS cv_meds, o.medication AS other_meds FROM patient_info p
LEFT JOIN cardio_medications m
ON p.patient_id = m.patient_id
INNER JOIN other_meds o
ON p.patient_id = o.patient_id;

select * from all_patientmeds;


#Show all the patients who are taking aspirin
select * from all_patientmeds
	WHERE cv_meds = 'aspirin';

#How many patients take a certain CV medication and a different medication: eg: 'beta blocker' AND metformin
select COUNT(*) from all_patientmeds
	WHERE cv_meds = 'beta blocker' and other_meds = 'metformin';
#3 patients do


#Which patients have had surgery and what event did they have?
SELECT e.patient_id, e.cvevent, s.surgery_type FROM cardio_events e
LEFT JOIN surgeries s
ON e.patient_id = s.patient_id
WHERE s.surgery_type IS NOT NULL; #used this WHERE filter to ignore any patients who have NOT had surgery

#To show patients who have had an event BUT NOT had surgery
SELECT e.patient_id, e.cvevent, s.surgery_type FROM cardio_events e
LEFT JOIN surgeries s
ON e.patient_id = s.patient_id
WHERE s.surgery_type IS NULL;

#STORED PROCEDURE Provides information of patients who have had heart attacks, surgery and their cv-medications.
DROP PROCEDURE IF EXISTS MI_patients;
DELIMITER //
CREATE PROCEDURE MI_patients ()
BEGIN
SELECT p.patient_id, p.first_name, p.last_name, e.event_id, e.cvevent, s.surgery_type, s.surgery_date, m.medication FROM patient_info p
JOIN cardio_events e
ON 
p.patient_id = e.patient_id
JOIN surgeries s
ON 
p.patient_id = s.patient_id
JOIN cardio_medications m
ON p.patient_id = m.patient_id
WHERE e.cvevent = 'heart attack';
END //
DELIMITER ;

CALL MI_patients(); #Could create the same but for patients with stroke, or angina, TIA

#TRIGGER
#After trigger insert,
#when surgery_date is added into table surgeries, if the date of surgery was over 6 months before the current date, DATE now(), 
# then a reminder is inserted into 'Follow-up table' for "surgery follow up "
#Follow up table - contains patient_id, followup_id, status - created below


CREATE TABLE Follow_up (
followup_id INT NOT NULL AUTO_INCREMENT,
patient_id INT,
surgery_id INT,
followup_status VARCHAR (50),
CONSTRAINT PK_followup PRIMARY KEY (followup_id),
CONSTRAINT FK_surgery_id FOREIGN KEY (surgery_id)
REFERENCES surgeries(surgery_id),
CONSTRAINT FK_patient_idF FOREIGN KEY (patient_id)
REFERENCES patient_info(patient_id)
);

DROP trigger IF EXISTS Surgery_follow_up;

DELIMITER //
CREATE TRIGGER Surgery_follow_up
AFTER INSERT ON surgeries
FOR EACH ROW
BEGIN
	IF timestampdiff(MONTH, NEW.surgery_date, current_date()) > 6
    THEN
		INSERT INTO follow_up(patient_id, surgery_id, followup_status)
		VALUES (NEW.patient_id, NEW.surgery_id, 'Contact patient');
    END IF;
    END//
DELIMITER ;     

select * FROM follow_up;
select * from surgeries;

#Insert new data into surgeries table, then check follow-up table to see if trigger occurs
INSERT INTO surgeries(patient_id, surgery_id, surgery_type, surgery_date)
	VALUES
	(1002, 23, 'endarterectomy', '2022-03-31');
    
select * from follow_up;


# --- END ---
#There is a lot more potential analysis that could still be done with more time, eg looking at cholesterol levels and heart attack/stroke incidence, statin medication and heart attack incidence,etc. 
#I could have added surgeon or hospital details to increase complexity of the database

