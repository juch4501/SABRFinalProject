create database test;
use test;

Drop table location;


CREATE TABLE  location
   (
   FirstName      varchar(100)   NOT NULL ,
   LastName varchar(200) NOT NULL,
   Address       varchar(100)   NOT NULL ,
   Latitude       int   NOT NULL ,
   Longitude       int   NOT NULL ,
   PRIMARY KEY (FirstName, LastName) 
   ) 
   CHARACTER SET utf8 COLLATE utf8_general_ci;
   
   Insert into location values ('Juan', 'Chavez', '2885 E Midway Blvd Denver, CO. 80234', 40, 50);
    Insert into location values ('Rob', 'Chavez', '2885 E Midway Blvd Denver, CO. 80234', 40, 50);
   
   Insert into location values ('Ro', 'Chavez', '28 Midway Blvd Denver, CO. 80234', 40, 50);
   Insert into location values ('Rb', 'Chavez', '2885 y Blvd Denver, CO. 80234', 40, 50);
   Insert into location values ('ob', 'Chavez', '5 E Midway Blvd Denver, CO. 80234', 40, 50);
   
   
   
   select * from location ;