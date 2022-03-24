-- Showing the average amount of products purchased by each marital status

SELECT
a.marital_status,
ROUND((a.fruits + a.meat + a.wine + a.fish + a.sweet + a.gold),2) AS avg_amount_purchased
FROM
	(SELECT
		marital_status,
		AVG(mntfruits) AS fruits,
		AVG(mntmeatproducts) AS meat,
		AVG(mntwines) AS wine,
		AVG(mntfishproducts) AS fish,
		AVG(mntsweetproducts) AS sweet,
		AVG(mntgoldprods) AS gold
		 
	FROM marketing_data
	GROUP BY 1) AS a
GROUP BY 1
ORDER BY 2 DESC;

-- Showing the average amount of products purchased education level

SELECT
a.education,
ROUND((a.fruits + a.meat + a.wine + a.fish + a.sweet + a.gold),2) AS avg_amount_purchased
FROM
	(SELECT
		education,
		AVG(mntfruits) AS fruits,
		AVG(mntmeatproducts) AS meat,
		AVG(mntwines) AS wine,
		AVG(mntfishproducts) AS fish,
		AVG(mntsweetproducts) AS sweet,
		AVG(mntgoldprods) AS gold
		 
	FROM marketing_data
	GROUP BY 1) AS a
GROUP BY 1
ORDER BY 2 DESC;


-- Comparing the average income with the average amount of products purchased by education sector for each year


SELECT 
	YEAR(m.dt_customer) AS yr,
	m.education,
    ROUND(AVG(m.income),2) AS avg_income,
    ROUND(tm.avg_amount_purchased,2) AS avg_amount_purchased
	-- ROUND((tm.avg_amount_purchased* 100 )/AVG(m.income),2)  AS avg_to_total_amount_percent
FROM marketing_data m
	JOIN 
	(SELECT
	a.education,
			(a.fruits + a.meat + a.wine + a.fish + a.sweet + a.gold) AS avg_amount_purchased
			FROM
			(SELECT
				education,
				AVG(mntfruits) AS fruits,
				AVG(mntmeatproducts) AS meat,
				AVG(mntwines) AS wine,
				AVG(mntfishproducts) AS fish,
				AVG(mntsweetproducts) AS sweet,
				AVG(mntgoldprods) AS gold
				 
			FROM marketing_data
			GROUP BY 1) AS a
		GROUP BY 1
		ORDER BY 2 DESC) tm ON tm.education = m.education
GROUP BY 1,2
ORDER BY 1 DESC,3 DESC, 4 DESC ;


-- Comparing the average income with the average amount of products purchased by marital status for each year

SELECT 
	YEAR(m.dt_customer) AS yr,
	m.marital_status,
    ROUND(AVG(m.income),2) AS avg_income,
    ROUND(tm.avg_amount_purchased,2) AS avg_amount_purchased
	-- ROUND((tm.avg_amount_purchased* 100 )/AVG(m.income),2)  AS avg_to_total_amount_percent
FROM marketing_data m
	JOIN 
	(SELECT
	a.marital_status,
			(a.fruits + a.meat + a.wine + a.fish + a.sweet + a.gold) AS avg_amount_purchased
			FROM
			(SELECT
				marital_status,
				AVG(mntfruits) AS fruits,
				AVG(mntmeatproducts) AS meat,
				AVG(mntwines) AS wine,
				AVG(mntfishproducts) AS fish,
				AVG(mntsweetproducts) AS sweet,
				AVG(mntgoldprods) AS gold
				 
			FROM marketing_data
			GROUP BY 1) AS a
		GROUP BY 1
		ORDER BY 2 DESC) tm ON tm.marital_status = m.marital_status
GROUP BY 1,2
ORDER BY 1 DESC,5 DESC;


-- comparing the education sector and marital status to find the relationship in the purchases through web

SELECT
	Marital_Status,
    SUM(CASE WHEN education = 'Graduation' THEN NumWebPurchases ELSE NULL END) AS graduation,
    SUM(CASE WHEN education = 'phD' THEN NumWebPurchases ELSE NULL END) AS PhD,
	SUM(CASE WHEN education = '2n Cycle' THEN NumWebPurchases ELSE NULL END) AS 2n_Cycle,
	SUM(CASE WHEN education = 'Master' THEN NumWebPurchases ELSE NULL END) AS Master,
	SUM(CASE WHEN education = 'Basic' THEN NumWebPurchases ELSE NULL END) AS Basic
    
   -- COUNT(numwebpurchases)
FROM marketing_data
GROUP BY 1;
-- ORDER BY 2 DESC;
-- counting the number of customers by the number of teens in their home
SELECT 
	 teenhome,
     SUM(numwebpurchases) AS teen_counts
FROM MARKETing_data
GROUP BY 1;

-- The total number of purchases by country
SELECT
	country,
    SUM(mntwines + MntFruits + MntMeatProducts + mntfishproducts + mntsweetproducts + mntgoldprods) AS amount_products
FROM marketing_data
GROUP BY 1
ORDER BY 2 DESC;

-- THE NUMBER OF PURCHASES MADE BY EACH COUNTRY FILTER BY EACH CHANNEL
SELECT 
	country,
    SUM(CASE WHEN NumDealsPurchases IS NOT NULL THEN NumDealsPurchases ELSE NULL END) AS NumDealsPurchases,
    SUM(CASE WHEN NumWebPurchases IS NOT NULL THEN NumWebPurchases ELSE NULL END) AS NumWebPurchases,
    SUM(CASE WHEN NumCatalogPurchases IS NOT NULL THEN NumCatalogPurchases ELSE NULL END) AS NumCatalogPurchases,
    SUM(CASE WHEN NumStorePurchases IS NOT NULL THEN NumStorePurchases ELSE NULL END) AS NumStorePurchases
    -- SUM(CASE WHEN NumWebVisitsMonth IS NOT NULL THEN NumWebVisitsMonth ELSE NULL END) AS NumWebVisitsMonth
FROM marketing_data
GROUP BY 1
ORDER BY 2 DESC;


-- THE NUMBER OF PURCHASES BY EACH CHANNEL
SELECT
	SUM(NumDealsPurchases) AS NumDealsPurchases,
    SUM(NumWebPurchases) AS NumWebPurchases,
    SUM(NumCatalogPurchases) AS NumCatalogPurchases,
    SUM(NumStorePurchases) AS NumStorePurchases
FROM marketing_data;

-- THE SUCCESSFUL RATE OF EACH CAMPAIGN
SELECT
	COUNT(CASE WHEN AcceptedCmp1 = 1 THEN 1 ELSE NULL END) AS AcceptedCmp1,
    COUNT(CASE WHEN AcceptedCmp1 = 1 THEN 1 ELSE NULL END)/COUNT(DISTINCT ID) AS AcceptedCmp1_conv_rt,
    COUNT(CASE WHEN AcceptedCmp2 = 1 THEN 1 ELSE NULL END) AS AcceptedCmp2,
    COUNT(CASE WHEN AcceptedCmp2 = 1 THEN 1 ELSE NULL END)/COUNT(DISTINCT ID) AS AcceptedCmp2_conv_rt,
    COUNT(CASE WHEN AcceptedCmp3 = 1 THEN 1 ELSE NULL END) AS AcceptedCmp3,
    COUNT(CASE WHEN AcceptedCmp3 = 1 THEN 1 ELSE NULL END)/COUNT(DISTINCT ID) AS AcceptedCmp3_conv_rt,
    COUNT(CASE WHEN AcceptedCmp4 = 1 THEN 1 ELSE NULL END) AS AcceptedCmp4,
    COUNT(CASE WHEN AcceptedCmp4 = 1 THEN 1 ELSE NULL END)/COUNT(DISTINCT ID) AS AcceptedCmp4_conv_rt,
    COUNT(CASE WHEN AcceptedCmp5 = 1 THEN 1 ELSE NULL END) AS AcceptedCmp5,
    COUNT(CASE WHEN AcceptedCmp5 = 1 THEN 1 ELSE NULL END)/COUNT(DISTINCT ID) AS AcceptedCmp5_conv_rt
FROM marketing_data;


-- THE AMOUNT GENERATED BY EACH PRODUCTS
SELECT 
	SUM(MntWines) AS MntWines,
    SUM(MntMeatProducts) AS MntMeatProducts,
    SUM(MntFishProducts) AS MntFishProducts,
    SUM(MntSweetProducts) AS MntSweetProducts,
    SUM(MntGoldProds) AS MntGoldProds
FROM marketing_data;


-- WHAT AN AVERAGE CUSTOMER LOOKS LIKE 
SELECT
	ROUND(AVG(YEAR(NOW()) - year_birth)) AS average_age,
	ROUND(AVG(income),2) AS average_income,
    ROUND(AVG(mntwines),2) AS average_wine,
    ROUND(AVG(MntFruits),2) AS average_fruits,
    ROUND(AVG(MntMeatProducts),2) AS average_meat,
    ROUND(AVG(MntSweetProducts),2) AS average_sweet,
    ROUND(AVG(MntGoldProds),2) AS average_gold
FROM marketing_data;





