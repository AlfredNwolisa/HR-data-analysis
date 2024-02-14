---create a join--
SELECT * from Absenteeism a
LEFT JOIN compensation c
ON a.ID = c.ID
LEFT JOIN Reasons r
on a.Reason_for_absence = r.Number

--Find the healthiest employee for the bonus
SELECT * from Absenteeism
WHERE Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index < 25
AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) from Absenteeism)

-- Compensation rate incerese for non-smokers/ budget 983,221, .68 incerese / hr
SELECT COUNT(*) as non_smokers FROM Absenteeism
WHERE Social_smoker = 0

SELECT a.ID, r.Reason, a.Month_of_absence, a.Body_mass_index,
CASE WHEN a.Body_mass_index <18.5 THEN 'Underweight'
     WHEN a.Body_mass_index  BETWEEN 18.5 and 24.9  THEN 'Healthy weight'
     WHEN a.Body_mass_index BETWEEN 25 AND 30  THEN 'Overweight'
     WHEN a.Body_mass_index > 30  THEN 'Obese'
     ELSE 'Uknown' END as BMI_category,
CASE WHEN a.Month_of_absence IN (12,1,2) THEN 'Winter' 
    WHEN a.Month_of_absence IN (3,4,5)THEN 'Spring' 
    WHEN a.Month_of_absence IN (6,7,8) THEN 'Summer' 
    WHEN a.Month_of_absence IN (9,10,11) THEN 'Fall' 
    ELSE 'Unkown' END as Season_Names ,
a.Month_of_absence,
a.Day_of_the_week,
a.Absenteeism_time_in_hours 
    from Absenteeism a
LEFT JOIN compensation c
ON a.ID = c.ID
LEFT JOIN Reasons r
on a.Reason_for_absence = r.Number