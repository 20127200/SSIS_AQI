create database AQI_NDS
go
use AQI_NDS
go


drop table [nds_AQI]
drop table [nds_county]
drop table [nds_state]


CREATE TABLE [nds_state] (
	[state_code_sk] int identity (1,1),
	[state_code_nk] numeric(20,0),
	[state_id] varchar(50),
	[state_name] varchar(50),
	[created_date] datetime,
    [updated_date] datetime,
	[source_id] int,
	constraint nds_state_pk primary key ([state_code_sk])
)

CREATE TABLE [nds_county] (
	[county_fips_sk] int identity (1,1),
    [state_code_sk] int,
	[county_fips_nk] varchar(50),
	[county_name] varchar(50),
	[county_name_full] varchar(50),
	[county_name_ascii] varchar(50),
	[county_code] numeric(20,0),
	[lat] varchar(50),
	[ing] varchar(50),
	[population] bigint,
	[created_date] datetime,
	[updated_date] datetime,
	[source_id] int,
	constraint nds_county_pk primary key ([county_fips_sk]),
	constraint nds_county_state_fk foreign key ([state_code_sk]) references [nds_state]([state_code_sk])
)

CREATE TABLE [nds_AQI] (
	[AQI_sk] int identity (1,1),
	[state_code_sk] int,
	[county_fips_sk] int,
	[AQI] numeric(20,0),
	[category] varchar(50),
    [defining_parameter] varchar(50),
    [defining_site] varchar(50),
    [number_of_sites_reporting] numeric(20,0),
    [created_date] datetime,
    [updated_date] datetime,
    [source_id] int,
	constraint nds_AQI_pk primary key ([AQI_sk]),
	constraint nds_AQI_county foreign key ([county_fips_sk]) references [nds_county]([county_fips_sk]),
	constraint nds_AQI_state foreign key ([state_code_sk]) references [nds_state]([state_code_sk])
)



select* from nds_state
where state_name = 'Virginia'

select* from nds_county

select count(*) from nds_county