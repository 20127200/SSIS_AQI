create database AQI_Stage 
go
use AQI_Stage
go

create TABLE [Stage_AQI_State_2021] (
    [State Name] varchar(50),
    [county Name] varchar(50),
    [State Code] numeric(20,0),
    [County Code] numeric(20,0),
    [Date] datetime,
    [AQI] numeric(20,0),
    [Category] varchar(50),
    [Defining Parameter] varchar(50),
    [Defining Site] varchar(50),
    [Number of Sites Reporting] numeric(20,0),
    [Created] datetime,
    [Last Updated] datetime,
    [sourceID] int
)

create TABLE [Stage_AQI_State_2022] (
    [State Name] varchar(50),
    [county Name] varchar(50),
    [State Code] numeric(20,0),
    [County Code] numeric(20,0),
    [Date] datetime,
    [AQI] numeric(20,0),
    [Category] varchar(50),
    [Defining Parameter] varchar(50),
    [Defining Site] varchar(50),
    [Number of Sites Reporting] numeric(20,0),
    [Created] datetime,
    [Last Updated] datetime,
    [sourceID] int
)
create TABLE [Stage_AQI_State_2023] (
    [State Name] varchar(50),
    [county Name] varchar(50),
    [State Code] numeric(20,0),
    [County Code] numeric(20,0),
    [Date] datetime,
    [AQI] numeric(20,0),
    [Category] varchar(50),
    [Defining Parameter] varchar(50),
    [Defining Site] varchar(50),
    [Number of Sites Reporting] numeric(20,0),
    [Created] datetime,
    [Last Updated] datetime,
    [sourceID] int
)

CREATE TABLE [Stage_uscounties] (
    [county] varchar(50),
    [county_ascii] varchar(50),
    [county_full] varchar(50),
    [county_fips] varchar(50),
    [state_id] varchar(50),
    [state_name] varchar(50),
    [lat] varchar(50),
    [lng] varchar(50),
    [population] bigint,
	[sourceID] int
)

select count(*) as state_2021 from Stage_AQI_State_2021
select count(*) as state_2022 from Stage_AQI_State_2022
select count(*) as state_2023 from Stage_AQI_State_2023
select count(*) as uscounities from Stage_uscounties

select* from  [Stage_uscounties] where state_name = 'California'

select distinct(a.state_name) from [Stage_uscounties] a 
	--join [Stage_AQI_State_2021] b on a.state_name = b.[State Name]
	join [Stage_AQI_State_2022] c on a.state_name = c.[State Name]
	join [Stage_AQI_State_2023] d on a.state_name = d.[State Name]

select distinct([State Name]) from [Stage_AQI_State_2021] where [State Name] not in (
	select state_name from [Stage_uscounties]
)
select distinct([State Name]) from [Stage_AQI_State_2022] where [State Name] not in (
	select state_name from [Stage_uscounties]
)
select distinct([State Name]) from [Stage_AQI_State_2023] where [State Name] not in (
	select state_name from [Stage_uscounties]
)

select distinct(state_name) from [Stage_uscounties]
union
select distinct([State Name]) from [Stage_AQI_State_2021]
union
select distinct([State Name]) from [Stage_AQI_State_2022]
union
select distinct([State Name]) from [Stage_AQI_State_2023]

select distinct(county) from Stage_uscounties 
select distinct([county Name]) from Stage_AQI_State_2021
select distinct([county Name]) from Stage_AQI_State_2022
select distinct([county Name]) from Stage_AQI_State_2023

select distinct([county Name]) from [Stage_AQI_State_2021] where [county Name] not in (
	select distinct(county) from [Stage_uscounties]
)
select distinct([county Name]) from [Stage_AQI_State_2022] where [county Name] not in (
	select distinct(county) from [Stage_uscounties]
)
select distinct([county Name]) from [Stage_AQI_State_2023] where [county Name] not in (
	select distinct(county) from [Stage_uscounties]
)

select distinct(county), state_name, lng, lat from Stage_uscounties 

SELECT state_name, county, COUNT(*) AS count
FROM Stage_uscounties
GROUP BY state_name, county
ORDER BY state_name, count DESC;

SELECT state_name, county, COUNT(*) AS count
FROM Stage_uscounties
WHERE population > 0
GROUP BY state_name, county
ORDER BY state_name, count DESC;


select county_fips, county, state_name from Stage_uscounties group by county_fips, county, state_name order by county

select county_fips, county, state_name, lng, lat from Stage_uscounties where county = 'Baltimore'