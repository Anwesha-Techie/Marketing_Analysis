SELECT *
FROM dbo.customer_journey;

-- verifies and identifies duplicate record entries

WITH DuplicateRecords AS(
	SELECT 
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		ROW_NUMBER() OVER (
				PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action, Duration
				ORDER BY JourneyID) AS row_num
	FROM dbo.customer_journey
)
SELECT *
FROM DuplicateRecords
WHERE row_num > 1
ORDER BY JourneyID;

-- final cleaned and standardised data

SELECT
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE(Duration, Avg_Duration) AS Duration -- replaces null value with avg_duration of that particular date
FROM
	(
		SELECT 
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		UPPER(Stage) AS Stage,
		Action,
		Duration,
		ROUND(AVG(Duration) OVER (PARTITION BY VisitDate),2) AS Avg_Duration, -- calculates avg_duration for each date
		ROW_NUMBER() OVER (
				PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action, Duration
				ORDER BY JourneyID) AS row_num  -- assigns a row number within this partition to identify duplicates
		FROM dbo.customer_journey
	) AS Subquery
WHERE row_num = 1
ORDER BY JourneyID;
