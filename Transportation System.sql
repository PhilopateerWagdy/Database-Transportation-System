create database new_trans_system

CREATE TABLE Admin
(
  AdminID INT identity NOT NULL,
  AdminName VARCHAR(30) NOT NULL,
  PRIMARY KEY (AdminID)
);

CREATE TABLE User_
(
  UserID INT identity NOT NULL,
  address VARCHAR(50) NOT NULL,
  phone INT NOT NULL,
  name VARCHAR(30) NOT NULL,
  AdminID INT NOT NULL,
  PRIMARY KEY (UserID),
  FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);

CREATE TABLE Driver
(
  DriverID INT identity NOT NULL,
  phone INT NOT NULL,
  name VARCHAR(30) NOT NULL,
  address VARCHAR(50) NOT NULL,
  PRIMARY KEY (DriverID)
);

CREATE TABLE Ride_Payment
(
  PaymentType VARCHAR(30) NOT NULL,
  PaymentNo INT NOT NULL,
  AdminID INT,
  PRIMARY KEY (PaymentNo),
  FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);

CREATE TABLE Vehicle_type
(
  TypeNo INT identity NOT NULL,
  type VARCHAR(30) NOT NULL,
  PRIMARY KEY (TypeNo)
);

CREATE TABLE Promocode
(
  code VARCHAR(5) NOT NULL,
  PRIMARY KEY (code)
);

CREATE TABLE Ride_history
(
  day varchar(30) NOT NULL,
  EndTime Datetime NOT NULL,
  StartTime Datetime NOT NULL,
  DriverID INT,
  UserID INT,
  startingStreet VARCHAR(50) NOT NULL,
  destStreet varchar(50) NOT NULL,	  
  city VARCHAR(50) NOT NULL, 
  PRIMARY KEY (day, DriverID, UserID),
  FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
  FOREIGN KEY (UserID) REFERENCES User_(UserID)
);

CREATE TABLE Ride_rating
(
  rate FLOAT NOT NULL,
  feedback VARCHAR(50) NOT NULL,
  UserID INT,
  DriverID INT,
  PRIMARY KEY (rate, UserID, DriverID),
  FOREIGN KEY (UserID) REFERENCES User_(UserID),
  FOREIGN KEY (DriverID) REFERENCES Driver(DriverID)
);

CREATE TABLE Vehicle
(
  LicenseNo INT NOT NULL,
  model VARCHAR(20) NOT NULL,
  make VARCHAR(20) NOT NULL,
  DriverID INT NOT NULL,
  TypeNo INT,
  PRIMARY KEY (LicenseNo, DriverID, TypeNo),
  FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
  FOREIGN KEY (TypeNo) REFERENCES Vehicle_type(TypeNo)
);

CREATE TABLE enter_Promocode
(
  UserID INT NOT NULL,
  code VARCHAR(5) NOT NULL,
  PRIMARY KEY (UserID, code),
  FOREIGN KEY (UserID) REFERENCES User_(UserID),
  FOREIGN KEY (code) REFERENCES Promocode(code)
);

CREATE TABLE transfer_user
(
  DriverID INT NOT NULL,
  UserID INT NOT NULL,
  PRIMARY KEY (DriverID, UserID),
  FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
  FOREIGN KEY (UserID) REFERENCES User_(UserID)
);

CREATE TABLE show_vehicle
(
  UserID INT NOT NULL,
  TypeNo INT NOT NULL,
  PRIMARY KEY (UserID, TypeNo),
  FOREIGN KEY (UserID) REFERENCES User_(UserID),
  FOREIGN KEY (TypeNo) REFERENCES Vehicle_type(TypeNo)
);

CREATE TABLE Vehicle_color
(
  color VARCHAR(30) NOT NULL,
  LicenseNo INT NOT NULL,
  DriverID INT NOT NULL,
  TypeNo INT NOT NULL,
  PRIMARY KEY (color, LicenseNo, DriverID, TypeNo),
  FOREIGN KEY (LicenseNo, DriverID, TypeNo) REFERENCES Vehicle(LicenseNo, DriverID, TypeNo)
);

CREATE TABLE Trip_details
(
  RideFees FLOAT NOT NULL,
  PaymentNo INT,
  DriverID INT,
  UserID INT,
  LicenseNo INT,
  TypeNo INT,
  startingStreet VARCHAR(50) NOT NULL,
  destStreet varchar(50) NOT NULL,	  
  city VARCHAR(50) NOT NULL,
  StartTime DateTime NOT NULL,
  EndTime Datetime NOT NULL,
  PRIMARY KEY (StartTime, PaymentNo, DriverID, UserID, LicenseNo, TypeNo),
  FOREIGN KEY (PaymentNo) REFERENCES Ride_Payment(PaymentNo),
  FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
  FOREIGN KEY (UserID) REFERENCES User_(UserID),
  FOREIGN KEY (LicenseNo, DriverID, TypeNo) REFERENCES Vehicle(LicenseNo, DriverID, TypeNo)
);

/* ***************************************************************************************************************  */

SET IDENTITY_INSERT [dbo].[Admin] ON
GO

INSERT INTO [dbo].[Admin] ( [AdminID], [AdminName])
VALUES ( 1, 'Assem')
GO

SET IDENTITY_INSERT [dbo].[Admin] OFF
GO

SET IDENTITY_INSERT [dbo].[User_] ON
GO

insert into [dbo].[User_] ( [UserID], [address],[phone],[name],[AdminID] )
values
(4,'Dokki',192312322,'Sherif',1),
(5,'Giza',1221323122,'Omar',1),
(6,'Masr el gdeeda',123123232,'Mostafa',1),
(7,'Madent nasr',123123233,'Ahmed',1),
(8,'Mokattam',12323213,'Abdelrahman',1),
(9,'Haram',12312242,'Alaa',1)
GO

SET IDENTITY_INSERT [dbo].[User_] OFF
GO

SET IDENTITY_INSERT [dbo].[Driver] ON
GO

insert into [dbo].[Driver] ( [DriverID], [phone],[name],[address] )
values
(1,123123123,'Mostafa','Ramsees'),
(2,1665754323,'Alaa','Haram'),
(3,192323123,'Fawaz','Shobra'),
(4,970069769,'Ibrahim','Abbas el akkad'),
(5,1345643234,'Aly','Makram ebeid'),
(6,18232323,'Ahmed','Medan el Mahkama')
GO

SET IDENTITY_INSERT [dbo].[Driver] OFF
GO



insert into Ride_Payment
values
('Cash',1,1),
('Visa',2,1),
('Master card',3,1)

insert into Ride_history
values
('Monday','2020-05-11 05:20:00.000','2020-05-11 05:10:00.000',1,5,'Giza','El Dokki','Giza')
,('Monday','2020-05-11 05:15:00.000','2020-05-11 04:00:00.000',2,8,'Makram','Mokatam','cairo')
,('Monday','2020-05-11 05:00:00.000','2020-05-11 04:20:00.000',3,7,'Ramsees','Giza','cairo')
,('Sunday','2020-05-10 09:20:00.000','2020-05-10 08:16:00.000',1,4,'ahmed fakhry','imtedad ramsees','cairo')
,('Tuesday','2020-05-12 09:00:00.000','2020-05-12 07:00:00.000',4,6,'Medan el mahkma','EL tagamoa','cairo')
,('Tuesday','2020-05-12 09:15:00.000','2020-05-12 08:15:00.000',5,4,'Haram','Giza','Giza');

insert into Ride_rating
values
(3,'good',8,2),
(4,'very good',4,1),
(4,'very good',4,5),
(4,'very good',6,4),
(4,'very good',7,3),
(5,'Excellent',5,1)

SET IDENTITY_INSERT [dbo].[Vehicle_type] ON
GO

insert into [dbo].[Vehicle_type] ( [TypeNo],[type] )
values
(1,'car'),
(2,'bus'),
(3,'scooter')
go

SET IDENTITY_INSERT [dbo].[Vehicle_type] OFF
GO

insert into Vehicle
values
(12345,2020,'Tesla',1,1),
(12543,2020,'Chevrolet',4,2),
(13452,2020,'Mercedes',3,2),
(14352,2020,'Peugeot',6,3),
(15324,2020,'BMW',5,3),
(54321,2020,'Range Rover',2,1)

insert into Vehicle_color
values
('Black',12345,1,1),
('Black',15324,5,3),
('Navy blue',54321,2,1),
('Navy red',13452,3,2),
('Silver',12543,4,2),
('white',14352,6,3)

insert into show_vehicle
values
(4,1),
(4,3),
(5,1),
(6,2),
(7,2),
(8,1)

insert into Trip_details
values
(35,1,1,4,12345,1,'ahmed fakhry','imtedad ramsees','cairo','2020-10-05 08:16:00.000','2020-10-05 09:20:00.000'),
(40,1,2,8,54321,1,'Makram','Mokatam','cairo','2020-11-05 04:00:00.000','2020-11-05 05:15:00.000'),
(35,3,3,7,13452,2,'Ramsees','Giza','cairo','2020-11-05 04:20:00.000','2020-11-05 05:00:00.000'),
(15,1,1,5,12345,1,'Giza','El Dokki','Giza','2020-11-05 05:10:00.000','2020-11-05 05:20:00.000'),
(60,2,4,6,12543,2,'Medan el mahkma','EL tagamoa','cairo','2020-12-05 07:00:00.000','2020-12-05 09:00:00.000'),
(30,1,5,4,15324,3,'Haram','Giza','Giza','2020-12-05 08:15:00.000','2020-12-05 09:15:00.000')

/* ***************************************************************************************************************  */

select *
from Admin

select *
from User_

select *
from Driver

select *
from Ride_history

select *
from Ride_rating

select *
from Trip_details

delete from Ride_history

/* a. What was the area that had the most/least ride requests last month?  */

select Ride_history.city , count(Ride_history.city) as 'Rides'
from Ride_history
where MONTH(Ride_history.StartTime) = MONTH(Ride_history.StartTime - 1)
group by city
order by 'Rides' desc

/* b. Who were the drivers with the maximum number of rides last month?  */

select top 1 Ride_history.DriverID , Driver.name , count(Ride_history.DriverID) as Number_of_rides
from Ride_history join Driver
on Ride_history.DriverID = Driver.DriverID
where MONTH(Ride_history.StartTime) = MONTH(Ride_history.StartTime - 1)
group by Ride_history.DriverID , Driver.name