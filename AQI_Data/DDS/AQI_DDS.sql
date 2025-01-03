create database AQI_DDS
go
use AQI_DDS
go

CREATE TABLE [dim_state] (
	[state_code_sk] int identity (1,1),
	[state_code_nk] numeric(20,0),
	[state_id] varchar(50),
	[state_name] varchar(50),
	[created_date] datetime,
    [updated_date] datetime,
	constraint nds_state_pk primary key ([state_code_sk]),
)

CREATE TABLE [dim_date](
	[date_sk] int identity(1,1),
	[date_full] date,
	[day] int,
	[month] int,
	[quarter] int,
	[year] int,
	[created_date] datetime,
	[updated_date] datetime,
	constraint dim_date_pk primary key ([date_sk])
)	


CREATE TABLE [dim_county] (
	[county_fips_sk] int identity (1,1),
	[state_code_sk] int,
	[county_fips_nk] varchar(50),
	[county_name] varchar(50),
	[county_name_full] varchar(50),
	[county_name_ascii] varchar(50),
	[county_code] numeric(20,0),
	[lat] varchar(50),
	[lng] varchar(50),
	[created_date] datetime,
	[updated_date] datetime,
	constraint nds_county_pk primary key ([county_fips_sk]),
	constraint dim_county_state_fk foreign key ([state_code_sk]) references [dim_state]([state_code_sk]),
)

CREATE TABLE [dim_category] (
	[category_sk] int identity (1,1),
	[category_name] varchar(50),
    [created_date] datetime,
    [updated_date] datetime,
	constraint nds_category_pk primary key ([category_sk]),
)

CREATE TABLE [fact_aqi] (
	[aqi_sk] int identity (1,1),
	[date_sk] int,
	[county_fips_sk] int,
	[category_sk] int,
	[aqi] numeric(20,0),
	[defining_parameter] varchar(50),
	[defining_site] varchar(50),
    [number_of_sites_reporting] numeric(20,0),
    [created_date] datetime,
    [updated_date] datetime,
	constraint fact_aqi_pk primary key ([aqi_sk]),
	constraint fact_aqi_county_fk foreign key ([county_fips_sk]) references [dim_county]([county_fips_sk]),
	constraint fact_aqi_category_fk foreign key ([category_sk]) references [dim_category]([category_sk]),
	constraint fact_aqi_date_fk foreign key ([date_sk]) references [dim_date]([date_sk])
)

select * from fact_aqi a 
join dim_county b on a.county_fips_sk = b.county_fips_sk 
join dim_date c on a.date_sk = c.date_sk
join dim_state d on d.state_code_sk = b.state_code_sk 
where county_name = 'Sumter'and c.year = 2023 and state_name = 'Alabama'

select * from fact_aqi a 
join dim_county b on a.county_fips_sk = b.county_fips_sk 
join dim_date c on a.date_sk = c.date_sk
join dim_state d on d.state_code_sk = b.state_code_sk 
where b.county_fips_sk = 767 and c.date_sk = 292 
and d.state_code_sk = 2


select* from dim_county where state_code_sk = 1
select * from dim_date

select * from fact_aqi

SELECT year, quarter, month, COUNT(*)
FROM dim_date
GROUP BY year, quarter, month
HAVING COUNT(*) > 1;

TRUNCATE TABLE fact_aqi

SELECT 
    s.state_name AS State,
    MIN(f.aqi) AS Min_AQI,
    MAX(f.aqi) AS Max_AQI
FROM 
    fact_aqi f
JOIN 
    dim_county c ON f.county_fips_sk = c.county_fips_sk
JOIN 
    dim_state s ON c.state_code_sk = s.state_code_sk
GROUP BY 
    s.state_name
ORDER BY 
    s.state_name;

SELECT 
    s.state_name AS State,
    SUM(f.aqi) AS Total_AQI
FROM 
    fact_aqi f
JOIN 
    dim_county c ON f.county_fips_sk = c.county_fips_sk
JOIN 
    dim_state s ON c.state_code_sk = s.state_code_sk
GROUP BY 
    s.state_name
ORDER BY 
    s.state_name;

-- Tìm giá trị min và max của AQI cho từng bang (State) trong mỗi quý (Quarter) của từng năm
SELECT 
    s.state_name AS State,
    d.year AS Year,
    d.quarter AS Quarter,
    MAX(f.aqi) AS Max_AQI,
    MIN(f.aqi) AS Min_AQI
FROM 
    fact_aqi f
INNER JOIN 
    dim_date d ON f.date_sk = d.date_sk
INNER JOIN 
    dim_county c ON f.county_fips_sk = c.county_fips_sk
INNER JOIN 
    dim_state s ON c.state_code_sk = s.state_code_sk
GROUP BY 
    s.state_name, d.year, d.quarter
ORDER BY 
    s.state_name, d.year, d.quarter;


SELECT 
    s.state_name AS State,
    d.year AS Year,
    d.quarter AS Quarter,
    SUM(f.aqi) AS Sum_AQI
FROM 
    fact_aqi f
INNER JOIN 
    dim_date d ON f.date_sk = d.date_sk
INNER JOIN 
    dim_county c ON f.county_fips_sk = c.county_fips_sk
INNER JOIN 
    dim_state s ON c.state_code_sk = s.state_code_sk
GROUP BY 
    s.state_name, d.year, d.quarter
ORDER BY 
    s.state_name, d.year, d.quarter;


SELECT 
    ds.state_name AS State,
    dc.county_name AS County,
    COUNT(DISTINCT dd.date_full) AS Number_of_Unhealthy_Days,
    AVG(fa.aqi) AS Average_AQI
FROM fact_aqi fa
JOIN dim_date dd ON fa.date_sk = dd.date_sk
JOIN dim_county dc ON fa.county_fips_sk = dc.county_fips_sk
JOIN dim_state ds ON dc.state_code_sk = ds.state_code_sk
JOIN dim_category dcat ON fa.category_sk = dcat.category_sk
WHERE dcat.category_name IN ('Very Unhealthy', 'Hazardous') -- Filter for the desired categories
GROUP BY ds.state_name, dc.county_name
ORDER BY ds.state_name, dc.county_name;

SELECT 
    dc.county_name AS County_Name,
    ds.state_name AS State_Name,
    dcat.category_name AS Category_Name
FROM fact_aqi fa
JOIN dim_county dc ON fa.county_fips_sk = dc.county_fips_sk
JOIN dim_state ds ON dc.state_code_sk = ds.state_code_sk
JOIN dim_category dcat ON fa.category_sk = dcat.category_sk
WHERE ds.state_name = 'Idaho'
  AND dc.county_name = 'Ada';

SELECT 
    fa.*,
    ds.state_name AS State_Name,
    dc.county_name AS County_Name,
    dc.county_name_full AS County_Name_Full,
    dc.county_code AS County_Code,
    dcat.category_name AS Category_Name,
    dd.date_full AS Date_Full,
    dd.year AS Year,
    dd.month AS Month,
    dd.day AS Day
FROM fact_aqi fa
JOIN dim_date dd ON fa.date_sk = dd.date_sk
JOIN dim_county dc ON fa.county_fips_sk = dc.county_fips_sk
JOIN dim_state ds ON dc.state_code_sk = ds.state_code_sk
JOIN dim_category dcat ON fa.category_sk = dcat.category_sk
WHERE ds.state_name = 'Idaho'
  AND dc.county_name = 'Ada'
  AND dcat.category_name = 'Unhealthy';


SELECT 
    dd.date_full AS date,
    fa.aqi AS AQI,
    dc.county_name AS county,
    ds.state_name AS state
FROM 
    fact_aqi fa
JOIN 
    dim_date dd ON fa.date_sk = dd.date_sk
JOIN 
    dim_county dc ON fa.county_fips_sk = dc.county_fips_sk
JOIN 
    dim_state ds ON dc.state_code_sk = ds.state_code_sk
WHERE 
    dd.year >= 2021 -- Lọc dữ liệu từ năm 2021 trở đi
ORDER BY 
    dd.date_full;



