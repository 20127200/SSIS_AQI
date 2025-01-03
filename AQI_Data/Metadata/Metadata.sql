screate database Metadata
go

use Metadata
go

-- drop table nds_data_flow

 create table data_flow ( 
 id int not null identity(1,1),
 name  varchar(20) not null, 
 LSET  datetime, 
 CET   datetime, 
 constraint pk_data_flow
 primary key (id)
 )
 
 create table nds_data_flow ( 
 id int not null identity(1,1),
 table_name  varchar(20) not null, 
 LSET  datetime, 
 CET   datetime, 
 constraint pk_nds_data_flow
 primary key (id)
 )
 
 go

 select * from data_flow 
 truncate table data_flow
 insert into data_flow (name, LSET, CET) values ('10_state_AQI_2021','2007-12-01 03:00:00', null)
 insert into data_flow (name, LSET, CET) values ('10_state_AQI_2022','2007-12-01 03:00:00', null)
 insert into data_flow (name, LSET, CET) values ('10_state_AQI_2023','2007-12-01 03:00:00', null)
 insert into data_flow (name, LSET, CET) values ('uscounties','2007-12-01 03:00:00', null)

 select * from nds_data_flow 
 truncate table nds_data_flow
 insert into nds_data_flow (table_name, LSET, CET) values ('nds_source','2007-12-01 03:00:00', null)
 insert into nds_data_flow (table_name, LSET, CET) values ('nds_state','2007-12-01 03:00:00', null)
 insert into nds_data_flow (table_name, LSET, CET) values ('nds_county','2007-12-01 03:00:00', null)
 insert into nds_data_flow (table_name, LSET, CET) values ('nds_aqi','2007-12-01 03:00:00', null)
 insert into nds_data_flow (table_name, LSET, CET) values ('nds_category','2007-12-01 03:00:00', null)


