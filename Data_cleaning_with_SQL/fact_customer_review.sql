SELECT *
FROM dbo.customer_reviews;

-- Query to clean white-space issues in the ReviewText column

SELECT
	ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	REPLACE(ReviewText, '  ', ' ') as ReviewText  -- cleaned ReviewText by replacing double spaces with single space to ensure text is more readable and standardised
FROM dbo.customer_reviews;