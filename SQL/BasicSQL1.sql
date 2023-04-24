/* SCHEMA SQL */
drop table if exists STATION;
create table STATION (
	ID int not null primary key auto_increment,
  	CITY varchar(21),
  	STATE varchar(21),
  	LAT_N BIGINT,
  	LONG_W BIGINT
);

insert into STATION (CITY, STATE, LAT_N, LONG_W) values 
('California', 'USA', 162819290, 109282911),
('Los Angeles', 'USA', 132813420, 103947923),
('Osaka', 'JPN', 103292032, 102938177);


/* QUERY SQL */
select * from STATION;
select CITY, STATE from STATION;
select * from STATION where ID % 2 = 0;
select * from STATION where ID % 2 = 1;
select distinct CITY from STATION; 

/*Count the number of state entries regardless of duplication (with duplicate entries) */
select count(STATE) from STATION;

/*Count the number of state entries with regard to duplication (without duplicate entries)*/
select count(distinct STATE) from STATION;

/*Count the total of duplication of the state entries */
select count(STATE) - count(distinct STATE) from STATION;

/*Query the city with (shortest length) in (alphabetical order) limit 1*/
select CITY, LENGTH(CITY) from STATION order by LENGTH(CITY), CITY limit 1;

/*Query the city names starting with vowels a/i/u/e/o */
select distinct CITY from STATION where CITY like 'A%' or CITY like 'E%' or CITY like 'I%' or CITY like 'O%' or CITY like 'U%';

/*Query the city names that is not starting with aiueo */
select distinct CITY from STATION where CITY not like 'A%' and CITY not like 'E%' and CITY not like 'I%' and CITY not like 'O%' and CITY not like 'U%'; 