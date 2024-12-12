USE data_scientist_project;

-- 1. Calculates the total number of minutes of video watched by each student in a specific year
SELECT 
    student_id,
    -- Convert total seconds watched to minutes and round to 2 decimal places
    ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched
FROM
    student_video_watched
WHERE
	-- !!! Change to 2021 or 2022 depending on the year considered !!!
    YEAR(date_watched) = 2021
-- Grouping results by each student to get aggregate minutes watched
GROUP BY student_id;

-- 2. This query retrieves subscription details from the student_purchases table and calculates the subscription duration (date_end) based on the subscription type (plan_id)
SELECT 
  purchase_id, 
  student_id, 
  plan_id, 
  date_purchased AS date_start, 
  CASE  -- Start of CASE statement to handle different subscription plan durations
	  WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)  -- If 'plan_id' is 0 (monthly subscription), then add one month to 'date_purchased' to calculate 'date_end'
	  WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)  -- If 'plan_id' is 1 (quarterly subscription), then add three months to 'date_purchased' to calculate 'date_end'
	  WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH)  -- If 'plan_id' is 2 (annual subscription), then add twelve months to 'date_purchased' to calculate 'date_end'
	  WHEN plan_id = 3 THEN CURDATE()  -- If 'plan_id' is 3 (lifetime subscription), then 'date_end' is the current date
  END AS date_end,  -- End of CASE statement. The resulting column is aliased as 'date_end'
  date_refunded 
FROM 
  student_purchases;

-- 3. Calculate the effective end date of student subscription plans,
SELECT 
    purchase_id,
    student_id,
    plan_id,
    date_start,
    IF(date_refunded IS NULL,  -- IF-ELSE construct to check if 'date_refunded' is NULL
        date_end,  -- If 'date_refunded' is NULL, then take 'date_end' as 'date_end'
        date_refunded) AS date_end  -- If 'date_refunded' is not NULL, then take 'date_refunded' as 'date_end'
FROM
    (  -- Subquery begins
        SELECT 
            purchase_id,
            student_id,
            plan_id,
            date_purchased AS date_start,
            CASE  -- Start of CASE statement to handle different subscription plan durations
                WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)  -- If 'plan_id' is 0 (monthly subscription), then add one month to 'date_purchased' to calculate 'date_end'
                WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)  -- If 'plan_id' is 1 (quarterly subscription), then add three months to 'date_purchased' to calculate 'date_end'
                WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH)  -- If 'plan_id' is 2 (annual subscription), then add twelve months to 'date_purchased' to calculate 'date_end'
                WHEN plan_id = 3 THEN CURDATE()  -- If 'plan_id' is 3 (lifetime subscription), then 'date_end' is the current date
            END AS date_end,  -- End of CASE statement. The resulting column is aliased as 'date_end'
            date_refunded
    FROM
        student_purchases
    ) a;  -- Subquery ends and the result is aliased as 'a'

-- 4. This query provides a comprehensive summary of student engagement by combining two key metrics
SELECT 
    a.student_id,
    -- Calculate minutes watched; use 0 if seconds_watched is NULL (not present in the student_video_watched table)
    IF(w.seconds_watched IS NULL,
        0,
        ROUND(SUM(seconds_watched) / 60, 2)) AS minutes_watched,
    a.certificates_issued
FROM
    (
    -- Sub-query to get the number of certificates issued per student.
    SELECT 
        student_id, 
        COUNT(certificate_id) AS certificates_issued
    FROM
        student_certificates
    GROUP BY student_id) a
        LEFT JOIN -- Join on the student_id column, ensuring all students from 'a' are included.
    student_video_watched w ON a.student_id = w.student_id
GROUP BY student_id;

-- 5.  creates a database view named purchases_info to summarize student subscription details. It includes data about subscription start and end dates and adds flags to indicate whether a subscription was active during specific quarters (Q2 2021 and Q2 2022).
CREATE VIEW purchases_info AS
SELECT
	*,
    -- Flag to indicate if the subscription was active during Q2 2021
    CASE 
		WHEN date_end < '2021-04-01' THEN 0 
		WHEN date_start > '2021-06-30' THEN 0 
		ELSE 1 
	END AS paid_q2_2021,
    -- Flag to indicate if the subscription was active during Q2 2022
	CASE 
		WHEN date_end < '2022-04-01' THEN 0 
		WHEN date_start > '2022-06-30' THEN 0 
		ELSE 1 
	END AS paid_q2_2022
FROM
(  -- Subquery begins
	SELECT 
		purchase_id,
		student_id,
		plan_id,
		date_start,
		IF(date_refunded IS NULL,  -- IF-ELSE construct to check if 'date_refunded' is NULL
			date_end,  -- If 'date_refunded' is NULL, then take 'date_end' as 'date_end'
			date_refunded) AS date_end  -- If 'date_refunded' is not NULL, then take 'date_refunded' as 'date_end'
	FROM
		(  -- Subquery begins
			SELECT 
				purchase_id,
				student_id,
				plan_id,
				date_purchased AS date_start,
				CASE  -- Start of CASE statement to handle different subscription plan durations
					WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)  -- If 'plan_id' is 0 (monthly subscription), then add one month to 'date_purchased' to calculate 'date_end'
					WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)  -- If 'plan_id' is 1 (quarterly subscription), then add three months to 'date_purchased' to calculate 'date_end'
					WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH)  -- If 'plan_id' is 2 (annual subscription), then add twelve months to 'date_purchased' to calculate 'date_end'
					WHEN plan_id = 3 THEN CURDATE()  -- If 'plan_id' is 3 (lifetime subscription), then 'date_end' is the current date
				END AS date_end,  -- End of CASE statement. The resulting column is aliased as 'date_end'
				date_refunded
		FROM
			student_purchases
		) a   -- Subquery ends and the result is aliased as 'a'
) b;   -- Subquery ends and the result is aliased as 'b'