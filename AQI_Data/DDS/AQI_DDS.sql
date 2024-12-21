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
	[state_code_sk] int,
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
	constraint fact_aqi_state_fk foreign key ([state_code_sk]) references [dim_state]([state_code_sk]),
	constraint fact_aqi_category_fk foreign key ([category_sk]) references [dim_category]([category_sk]),
	constraint fact_aqi_date_fk foreign key ([date_sk]) references [dim_date]([date_sk])
)

select* from dim_date