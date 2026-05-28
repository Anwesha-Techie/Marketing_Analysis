SELECT *
FROM dbo.engagement_data;

-- Query to clean and normalise the engagement_date table

SELECT
	EngagementID,
	ContentID,
	CampaignID,
	ProductID,
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType, -- replaces Socialmedia with Social Media and coverts ContentType column in upper case
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views, -- extracts view part from ViewsClicksCombined
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks, -- extracts click part form ViewsClicksCombined
	Likes,
	FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') as EngagementDate   -- converts EngagementDate to the dd.mm.yyyy format 
FROM 
	dbo.engagement_data
WHERE
	ContentType != 'Newsletter';
