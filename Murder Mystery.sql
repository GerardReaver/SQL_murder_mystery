#  A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you shoehow lost it. 
#  1. You vaguely remember that the crime was a 'MURDER' that occurred sometime on 'Jan.15.2018' and that it took place in 'SQL City'. 
# We will start by retrieving the corrresponding crime scene report from the police departments database.
  
-- QUERY #1  find the crime scene report layout
SELECT 
  *
FROM
  crime_scene_report
-- This was necessary to find out the format for the 'date' column because its type says INT and not DATE.

#  2. we see now that the Date attribute is formated like 20180115 in year-month-day format. 
-- Query #2 find the exact crime scene report for that murder
SELECT
  *
FROM
  crime_scene_report
WHERE
  date = 20180115 AND
  type = 'murder' AND
  city = 'SQL City'

#  3. We now have a description of the crime scene today and this is what is reads. 
#  Security gootage shows that there were 2 witnessess. The First witness lives at the last house on 'Northwestern Dr'. The second witness, named Annabel, lives somewhere on 'Franklin Ave'.
-- Query #3 Find the first witnesses
SELECT
  *,
  MAX(address_number)
FROM
  person
WHERE
  address_street_name = 'Northwestern Dr'
  
# 4. This allowed us to find Witness #1. 
  
WITNESS #1. 
id = 14887
name = 'Morty Schapiro'
license_id = 118009
address_number = 4919
address_street_name = 'Northwestern Dr'
ssn = 111564949

-- Query #4 Find the other witness
SELECT
	*
FROM
	person
WHERE
	name LIKE '%Annabel%' AND
	address_street_name = 'Franklin Ave'

# 5. This allowed us to find Witness #2. 

WITNESS #2. 
id = 16371
name = 'Annabel Miller'
license_id = 490173
address_number = 103
address_street_name = 'Franklin Ave'
ssn = 318771143

# 6. Now that we have both witnessess from the crime scene we can see what they said in their interviews now that we have their person id. 
-- Query #5 Finding the first witness interview
SELECT
  *
FROM
  interview
WHERE
  person_id = 14887
  
# 7. This is the reading of the transcript from the interview of Witness #1.
      I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. 
      The man got into a car with a plate that included "H42W" 

-- Query #6 Finding the second witness interview
SELECT
  *
FROM
  interview
WHERE
  person_id = 16371

# 8. This is the reading of the transcript from the interview of Witness #2.
    I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th. (date = 20180109)

-- Query #7 Finding the suspects who fit the description of being at the gym at that date from witness 2. 
SELECT
	m.*
FROM
	get_fit_now_member AS m
JOIN
	get_fit_now_check_in AS c
ON
	m.id = c.membership_id
WHERE
	c.check_in_date = 20180109 AND
	m.membership_status = 'gold' AND
	m.id LIKE '48Z%'

# 9. This brought us down to two suspects with this information at this date. 

SUSPECT #1. 
membership_id = '48Z7A'
person_id = 28819
name = 'Joe Germuska'
membership_start_date = 20160305
membership_status = 'gold'

SUSPECT #2. 
membership_id = '48Z55'
person_id = 67318
name = 'Jeremy Bowers'
membership_start_date = 20160101
membership_status = 'gold'

# 10. This allows me to check which one of these two people have a license plate against this person_id

-- Query #8
SELECT
	dl.*
FROM
	drivers_license AS dl
JOIN
	person AS p
ON
	p.license_id = dl.id
WHERE
	p.id = 67318 AND
	dl.plate_number LIKE '%H42W%'

# 11. This query was ran with both person_id but this was the result that actually came back to someone who had the correct license plate. 
-----------------------------------------------------------------------------------------------------------------
WE HAVE FOUND THE MURDERER AND SOLVED THE CASE FOR THE DETECTIVES IN SQL CITY
