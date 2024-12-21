create database AQI_NDS
go
use AQI_NDS
go

create table [nds_source] (
	[source_sk] int identity (1,1),
	[source_id] int,
	[created_date] datetime,
    [updated_date] datetime,
	constraint nds_source_pk primary key ([source_sk])
)

CREATE TABLE [nds_state] (
	[state_code_sk] int identity (1,1),
	[state_code_nk] numeric(20,0),
	[source_sk] int,
	[state_id] varchar(50),
	[state_name] varchar(50),
	[created_date] datetime,
    [updated_date] datetime,
	constraint nds_state_pk primary key ([state_code_sk]),
	constraint nds_state_source_fk foreign key ([source_sk]) references [nds_source]([source_sk])
)

CREATE TABLE [nds_county] (
	[county_fips_sk] int identity (1,1),
    [state_code_sk] int,
	[source_sk] int,
	[county_fips_nk] varchar(50),
	[county_name] varchar(50),
	[county_name_full] varchar(50),
	[county_name_ascii] varchar(50),
	[county_code] numeric(20,0),
	[lat] varchar(50),
	[lng] varchar(50),
	[population] bigint,
	[created_date] datetime,
	[updated_date] datetime,
	constraint nds_county_pk primary key ([county_fips_sk]),
	constraint nds_county_state_fk foreign key ([state_code_sk]) references [nds_state]([state_code_sk]),
	constraint nds_county_source_fk foreign key ([source_sk]) references [nds_source]([source_sk])
)

CREATE TABLE [nds_category] (
	[category_sk] int identity (1,1),
	[category_name] varchar(50),
	[source_sk] int,
    [created_date] datetime,
    [updated_date] datetime,
	constraint nds_category_pk primary key ([category_sk]),
	constraint nds_category_source_fk foreign key ([source_sk]) references [nds_source]([source_sk])
)

CREATE TABLE [nds_aqi] (
	[aqi_sk] int identity (1,1),
	[state_code_sk] int,
	[county_fips_sk] int,
	[category_sk] int,
	[source_sk] int,
	[aqi] numeric(20,0),
	[date] datetime,
	[defining_parameter] varchar(50),
	[defining_site] varchar(50),
    [number_of_sites_reporting] numeric(20,0),
    [created_date] datetime,
    [updated_date] datetime,
	constraint nds_aqi_pk primary key ([aqi_sk]),
	constraint nds_aqi_county_fk foreign key ([county_fips_sk]) references [nds_county]([county_fips_sk]),
	constraint nds_aqi_state_fk foreign key ([state_code_sk]) references [nds_state]([state_code_sk]),
	constraint nds_aqi_category_fk foreign key ([category_sk]) references [nds_category]([category_sk]),
	constraint nds_aqi_source_fk foreign key ([source_sk]) references [nds_source]([source_sk])
)



select* from nds_state
where state_name = 'Virginia'

select* from nds_state

select count(*) from nds_county

SELECT * FROM nds_county WHERE county_fips_sk = 33

truncate table nds_aqi

select min(date) from nds_aqi




