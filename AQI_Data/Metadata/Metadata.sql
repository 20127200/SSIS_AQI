screate database Metadata
go

use Metadata
go

-- drop table data_flow

 create table data_flow ( 
 id int not null identity(1,1),
 name  varchar(20) not null, 
 LSET  datetime, 
 CET   datetime, 
 constraint pk_data_flow
 primary key (id)
 )
 go

 truncate table data_flow
 insert into data_flow (name, LSET, CET) values ('10_state_AQI_2021','2007-12-01 03:00:00', null)
 insert into data_flow (name, LSET, CET) values ('10_state_AQI_2022','2007-12-01 03:00:00', null)
 insert into data_flow (name, LSET, CET) values ('10_state_AQI_2023','2007-12-01 03:00:00', null)
 insert into data_flow (name, LSET, CET) values ('uscounties','2007-12-01 03:00:00', null)

 select * from data_flow 

