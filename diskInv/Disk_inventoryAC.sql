/*****************************************************************/
/* Date		Programmer     Description                           */
/*                                                               */
/* 3/5/2021	 AC		Initial Deployment of disk_inventory.        */
/* 3/5/2021			Added another comment                        */
/* 3/11/2021 AC		Added insert statements                      */
/* 3/13/2021 AC     Added compilation album, Soundtrack genre, artist & DHA row */ 
/* 3/19/2021 AC     Added funk genre, 1999 album, reports.       */
/* 3/31/2021 AC     Added i,u,d procs for artist, borrower & disk */
/*****************************************************************/
--
--create db
use master;
go
DROP DATABASE IF EXISTS disk_inventoryAC;
go
CREATE DATABASE disk_inventoryAC;
go
use disk_inventoryAC;
go
-- create login, user & grant read permissions
IF SUSER_ID('diskUserAC') IS NULL  -- login can be created before db
	CREATE LOGIN diskUserAC 
	WITH PASSWORD = 'Pa$$w0rd',
	DEFAULT_DATABASE = disk_inventoryAC;
CREATE USER diskUserAC;				-- create after use statement
ALTER ROLE db_datareader
	ADD MEMBER diskUserAC;
go

--create lookup tables
CREATE TABLE artist_type
	(
	artist_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description				NVARCHAR(60) NOT NULL	-- char/varchar works
	);
CREATE TABLE disk_type
	(
	disk_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description				NVARCHAR(60) NOT NULL
	);
CREATE TABLE genre
	(
	genre_id				INT NOT NULL PRIMARY KEY IDENTITY,
	description				NVARCHAR(60) NOT NULL
	);
CREATE TABLE status
	(
	status_id				INT NOT NULL PRIMARY KEY IDENTITY,
	description				NVARCHAR(60) NOT NULL
	);
-- create borrower, disk, artist
CREATE TABLE borrower
	(
	borrower_id				INT NOT NULL PRIMARY KEY IDENTITY,
	fname					NVARCHAR(60) NOT NULL,
	lname					NVARCHAR(60) NOT NULL,
	phone_num				VARCHAR(15) NOT NULL
	);
CREATE TABLE disk
	(
	disk_id					INT NOT NULL PRIMARY KEY IDENTITY,
	disk_name				NVARCHAR(60) NOT NULL,
	release_date			DATE NOT NULL,
	genre_id				INT NOT NULL REFERENCES genre(genre_id),
	status_id				INT NOT NULL REFERENCES status(status_id),
	disk_type_id			INT NOT NULL REFERENCES disk_type(disk_type_id)
	);
CREATE TABLE artist
	(
	artist_id			INT NOT NULL PRIMARY KEY IDENTITY,
	fname				NVARCHAR(60) NOT NULL,
	lname				NVARCHAR(60) NULL,
	artist_type_id		INT NOT NULL REFERENCES artist_type(artist_type_id)
	);
-- create relationship tables
CREATE TABLE disk_has_borrower
	(
	disk_has_borrower_id	INT NOT NULL PRIMARY KEY IDENTITY,
	borrowed_date			DATETIME2 NOT NULL,
	due_date				DATETIME2 NOT NULL DEFAULT (GETDATE() + 30),
	returned_date			DATETIME2 NULL,
	borrower_id				INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id					INT NOT NULL REFERENCES disk(disk_id)		
	);
CREATE TABLE disk_has_artist
	(
	disk_has_artist_id	INT NOT NULL PRIMARY KEY IDENTITY,
	disk_id				INT NOT NULL REFERENCES disk(disk_id),
	artist_id			INT NOT NULL REFERENCES artist(artist_id)
	UNIQUE (disk_id, artist_id)
	);

--Project 3
--Insert artist_types - See Ch 7 
INSERT INTO [dbo].[artist_type]
           ([description])
     VALUES
           ('Solo'),
		   ('Group')
GO

INSERT INTO [dbo].[disk_type]
           ([description])
     VALUES
           ('CD'),
		   ('Vinyl'),
		   ('8Track'),
		   ('Cassette'),
		   ('DVD');
GO
INSERT INTO [dbo].[genre]
           ([description])
     VALUES
           ('Classic Rock'),
		   ('Country'),
		   ('Jazz'),
		   ('AltRock'),
		   ('Metal');
GO
INSERT INTO [dbo].[genre]
           ([description])
     VALUES
		   ('Soundtrack');
go
INSERT INTO [dbo].[genre]
           ([description])
     VALUES
           ('Funk');
--Inserts for status
INSERT status
VALUES ('Available');
INSERT status
VALUES ('On loan');
INSERT status
VALUES ('Damaged');
INSERT status
VALUES ('Missing');

-- Inserts for Disk table Part c.
-- 1. Insert at least 20 rows of data into the table using real-world disk names
--2. Update only 1 row using a where clause
--3. At least 1 disk has only 1 word in the name
--4. At least 1 disk has only 2 words in the name
--5. At least 1 disk has more than words in the name
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Crazy Train', '1/1/1995', 1, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('No More Tears', '11/21/1995', 1, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Red', '11/13/2008', 2, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Jagged Little Pill', '1/15/1995', 1, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Candy-O', '10/10/1991', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Hotel California', '11/1/1977', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('One of These Nights', '4/1/1975', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('The Long Run', '10/21/1979', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Hints, Allegations, and Things Left Unsaid', '1/21/1999', 4, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Blender', '1/29/2000', 4, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Dirt', '1/27/1992', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Unplugged', '5/23/1996', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Facelift', '8/22/1990', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Black Give Way to Blue', '11/21/2009', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Live', '11/11/2009', 4, 3, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Ten', '12/1/1991', 4, 4, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Vitalogy', '3/22/1994', 4, 3, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('No Code', '4/2/1996', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Backspacer', '5/21/2009', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Home', '1/19/1995', 1, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Twilight Soundtrack', '11/2/2008', 6, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('1999', '1/22/1982', 7, 2, 1);
-- Inserts for Borrower Part d. 
--1. Insert at least 20 rows of data into the table using real-world borrower names
INSERT borrower (fname, lname, phone_num)
VALUES ('Mickey', 'Mouse', '123-123-1234')
	  ,('Minnie', 'Mouse', '222-222-1234')
	  ,('Daisy', 'Duck', '333-123-4567')
	  ,('Daffy', 'Duck', '444-123-4567')
	  ,('Donald', 'Duck', '555-123-4567')
	  ,('Huey', 'Duck', '556-333-4567')
	  ,('Dewey', 'Duck', '577-222-4567')
	  ,('Louie', 'Duck', '255-133-5567')
	  ,('Elmer', 'Fudd', '355-323-3567')
	  ,('Buzz', 'Lightyear', '455-423-4447')
	  ,('Sheriff', 'Woody', '655-663-4566')
	  ,('Little Bo', 'Peep', '755-177-4777')
	  ,('Slinky', 'Dog', '885-188-4588')
	  ,('Mr. Potato', 'Head', '955-993-4997')
	  ,('Mr.', 'Spell', '550-120-4500')
	  ,('Race', 'Car', '511-111-4511')
	  ,('T', 'Rex', '522-122-4522')
	  ,('Mrs. Potato', 'Head', '533-133-4337')
	  ,('Sargeant', 'Soldier', '544-144-4544')
	  ,('Jessie', 'Cowgirl', '555-155-4555')
	  ;
--2. Delete only 1 row using a where clause
DELETE borrower
WHERE borrower_id = 20;

-- Inserts for Artist Part e
--1. Insert at least 20 rows of data into the table using real-world artist names
--2. At least 1 artist is known by 1 name and is a group
--3. At least 1 artist is known by 1 name and is an individual artist
--4. At least 1 artist has only 2 words in the name
--5. At least 1 artist has more than 2 words in the name
INSERT Artist
VALUES ('Ozzy', 'Osbourne', 1);
INSERT Artist
VALUES ('Shinedown', NULL, 2);
INSERT Artist
VALUES ('Prince', NULL, 1);
INSERT Artist
VALUES ('Five Finger Death Punch', NULL, 2);
INSERT Artist
VALUES ('Willie', 'Nelson', 1);
INSERT Artist
VALUES ('Taylor', 'Swift', 1);
INSERT Artist
VALUES ('Alanis', 'Morrisette', 1);
INSERT Artist
VALUES ('Chris', 'Daughtry', 1);
INSERT Artist
VALUES ('The Cars', NULL, 2);
INSERT Artist
VALUES ('Black Sabbath', NULL, 2);
INSERT Artist
VALUES ('The Eagles', NULL, 2);
INSERT Artist
VALUES ('Patsy', 'Cline', 1);
INSERT Artist
VALUES ('Pearl Jam', NULL, 2);
INSERT Artist
VALUES ('Collective Soul', NULL, 2);
INSERT Artist
VALUES ('Disturbed', NULL, 2);
INSERT Artist
VALUES ('Stone Temple Pilots', NULL, 2);
INSERT Artist
VALUES ('Breaking Benjamin', NULL, 2);
INSERT Artist
VALUES ('Seether', NULL, 2);
INSERT Artist
VALUES ('Rome In Flames', NULL, 2);
INSERT Artist
VALUES ('Temple of the Dog', NULL, 2);
INSERT Artist
VALUES ('Alice in Chains', NULL, 2);
INSERT Artist
VALUES ('Linkin Park', NULL, 2);

-- Inserts for DiskHasBorrower Part F
--1. Insert at least 20 rows of data into the table
--2. Insert at least 2 different disks
--3. Insert at least 2 different borrowers
--4. At least 1 disk has been borrowed by the same borrower 2 different times
--5. At least 1 disk in the disk table does not have a related row here
--6. At least 1 disk must have at least 2 different rows here
--7. At least 1 borrower in the borrower table does not have a related row here
--8. At least 1 borrower must have at least 2 different rows here

INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (2, 4, '1-2-2012', '2-2-2012', '2-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (3, 5, '11-12-2012', '12-12-2012','12-21-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (3, 6, '1-22-2012', '2-22-2012', '2-22-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (2, 7, '7-22-2012', '9-22-2012', '8-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (5, 2, '10-2-2012', '11-2-2012', '12-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (5, 7, '4-2-2012', '5-2-2012', '5-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (5, 8, '11-2-2012', '12-2-2012', '12-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (6, 3, '1-28-2012', '2-28-2012', '2-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (11, 14, '7-26-2016', '8-26-2016', NULL);
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (12, 15, '8-25-2016', '10-25-2016', '9-26-2016');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (13, 15, '9-24-2016', '11-24-2016', '9-26-2016');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (14, 11, '10-23-2016', '12-23-2016', '11-26-2016');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (15, 11, '11-22-2016', '12-22-2016', '12-2-2016');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (15, 12, '12-12-2016', '2-12-2017', NULL);
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (8, 8, '3-21-2012', '5-21-2012', '6-23-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (9, 4, '4-2-2012', '6-2-2012', '7-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (10, 9, '1-2-2013', '3-2-2013', '2-20-2013');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (4, 3, '2-2-2012', '4-2-2012', '2-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (5, 7, '1-2-2012', '3-2-2012', '2-20-2012');
INSERT INTO disk_has_borrower
	(disk_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (7, 4, '1-2-2012', '3-2-2012', NULL);

-- Inserts for DiskHasArtist Part G
--1. Insert at least 20 rows of data into the table
--2. At least 1 disk must have at least 2 different artist rows here
--3. At least 1 artist must have at least 2 different disk rows here
--4. Correct variation of disk & artist data similar to DiskHasBorrower
insert into disk_has_artist (disk_id, artist_id)
values
	(1,1)  
	,(2,1) 
	,(3,6) 
	,(4,7)  
	,(5,9)  
	,(6,11)  
	,(7,11)	
	,(8,11)	
	,(9,14)	
	,(10,14)	
	,(11,21)	
	,(12,21)	
	,(13,21)	
	,(14,21)	
	,(15,21)	
	,(16,13)	
	,(17,13) 	
	,(18,13)	
	,(19,13)	
	,(20,8);
go
insert into disk_has_artist (disk_id, artist_id)
values
	(21,22),
	(21,14);
go

insert into disk_has_artist (disk_id, artist_id)
values
	(22,3);
go

-- Part H
--Create a query to list the disks that are on loan and have not been returned. No join is required.
select borrower_id as Borrower_id, disk_id as Disk_id, convert(varchar, borrowed_date, 101) AS Borrowed_date, returned_date as Return_date
from disk_has_borrower
where returned_date IS NULL;
go

-----------------  Project 4 starts here
--3. Show the disks in your database and any associated Individual artists only. 
SELECT disk_name as 'Disk Name', CONVERT(VARCHAR, release_date, 101) as 'Release Date', fname as 'Artist First Name', ISNULL(lname, ' ') as 'Artist Last Name'
FROM disk
JOIN disk_has_artist ON disk.disk_id = disk_has_artist.disk_id
JOIN artist ON disk_has_artist.artist_id = artist.artist_id
WHERE artist_type_id = 1
ORDER BY lname, fname;
go
--4. Create a view called View_Individual_Artist that shows the artists’ names and not group names. Include the artist id in the view definition but do not display the id in your output.
CREATE VIEW View_Individual_Artist AS
	SELECT artist_id, fname, lname
	FROM artist
	WHERE artist_type_id = 1;
go
SELECT fname as 'First Name', ISNULL(lname, ' ' ) as 'Last Name' 
FROM View_Individual_Artist
ORDER BY lname, fname;
--5. Show the disks in your database and any associated Group artists only. 
SELECT disk_name as 'Disk Name', CONVERT(VARCHAR, release_date, 101) as 'Release Date', fname as 'Group Name'
FROM disk
JOIN disk_has_artist ON disk.disk_id = disk_has_artist.disk_id
JOIN artist ON disk_has_artist.artist_id = artist.artist_id
WHERE artist_type_id = 2
ORDER BY disk_name, fname;
--6. Re-write the previous query using the View_Individual_Artist view. Do not redefine the view. Consider using ‘NOT EXISTS’ or ‘NOT IN’ as the only restriction in the WHERE clause or a join. The output matches the output from the previous query.
--Sub-query NOT IN
SELECT disk_name as 'Disk Name', CONVERT(VARCHAR, release_date, 101) as 'Release Date', fname as 'Group Name'
FROM disk
JOIN disk_has_artist ON disk.disk_id = disk_has_artist.disk_id
JOIN artist ON disk_has_artist.artist_id = artist.artist_id
WHERE artist.artist_id NOT IN 
	(select artist_id from View_Individual_Artist)
ORDER BY disk_name, fname;
--Sub-query NOT EXISTS
SELECT disk_name as 'Disk Name', CONVERT(VARCHAR, release_date, 101) as 'Release Date', fname as 'Group Name'
FROM disk
JOIN disk_has_artist ON disk.disk_id = disk_has_artist.disk_id
JOIN artist ON disk_has_artist.artist_id = artist.artist_id
WHERE NOT EXISTS 
	(select artist_id from View_Individual_Artist
	where artist.artist_id = View_Individual_Artist.artist_id)
ORDER BY fname, disk_name;
--7. Show the borrowed disks and who borrowed them.
SELECT fname + ' ' + lname as Borrower, disk_name as 'Disk Name', 
	CAST(borrowed_date as date) as 'Borrowed Date', 
	--CAST(returned_date as date) as 'Returned Date'
	ISNULL(CAST(CAST(returned_date as date) AS VARCHAR), ' ') as 'Returned Date'
FROM borrower
JOIN disk_has_borrower ON borrower.borrower_id = disk_has_borrower.borrower_id
JOIN disk ON disk_has_borrower.disk_id = disk.disk_id
ORDER BY lname, fname, disk_name, borrowed_date;
--8. Show the number of times a disk has been borrowed.
SELECT disk.disk_id as 'DiskId', disk_name as 'Disk Name', 
	count(*) as 'Times Borrowed'
FROM disk
JOIN disk_has_borrower ON disk.disk_id = disk_has_borrower.disk_id
group by disk.disk_id, disk_name
ORDER BY disk_name;
--9. Show the disks outstanding or on-loan and who has each disk. 
SELECT disk_name as 'Disk Name', CAST(borrowed_date as date) as 'Borrowed', returned_date as Returned, fname as 'First Name', lname as 'Last Name', 
	REPLACE(phone_num, '-', '.') as 'Contact Number'
FROM disk
JOIN disk_has_borrower ON disk.disk_id = disk_has_borrower.disk_id
JOIN borrower ON borrower.borrower_id = disk_has_borrower.borrower_id
WHERE returned_date IS NULL
ORDER BY disk_name;

--      Project 5 
--2. Create Insert, Update, and Delete stored procedures for the artist table. Update procedure accepts input parameters for all columns. Insert accepts all columns as input parameters except for identity fields. Delete accepts a primary key value for delete. 

--3. Create Insert, Update, and Delete stored procedures for the borrower table. Update procedure accepts input parameters for all columns. Insert accepts all columns as input parameters except for identity fields. Delete accepts a primary key value for delete.

--4. Create Insert, Update, and Delete stored procedures for the disk table. Update procedure accepts input parameters for all columns. Insert accepts all columns as input parameters except for identity fields. Delete accepts a primary key value for delete.
DROP PROC IF EXISTS sp_ins_disk;
GO
CREATE PROC sp_ins_disk
	@disk_name nvarchar(60), @release_date date, @genre_id int, @status_id int, @disk_type_id int
AS
BEGIN TRY
	INSERT disk 
		(disk_name, release_date, genre_id, status_id, disk_type_id)
	VALUES 
		(@disk_name, @release_date, @genre_id, @status_id , @disk_type_id);
END TRY
BEGIN CATCH
	PRINT 'An error occured.';
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
go
GRANT EXECUTE ON sp_ins_disk to diskUserac;
go
EXEC sp_ins_disk 'Lightning Bolt', '2-2-2018', 1, 1, 1
go
EXEC sp_ins_disk NULL, '2-2-2018', 1, 1, 1
go
-- Drop & recreate sp_upd_disk
DROP PROC IF EXISTS sp_upd_disk;
GO
CREATE PROC sp_upd_disk
	@disk_id int, @disk_name nvarchar(60), @release_date date, @genre_id int, @status_id int, @disk_type_id int
AS
BEGIN TRY
	--Update the disk table using the input parameter
	UPDATE [dbo].[disk]
	   SET [disk_name] = @disk_name
		  ,[release_date] = @release_date
		  ,[genre_id] = @genre_id
		  ,[status_id] = @status_id
		  ,[disk_type_id] = @disk_type_id
	 WHERE disk_id = @disk_id;
END TRY
BEGIN CATCH
	PRINT 'An error occured.';
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_upd_disk to diskUserac;
go
EXEC sp_upd_disk 24, 'Lightning Bolt edited', '2-2-2018', 4, 3, 2
go
EXEC sp_upd_disk 24, NULL, '2-2-2018', 1, 1, 1
go
DROP PROC IF EXISTS sp_del_disk;
GO
CREATE PROC sp_del_disk @disk_id int
AS
BEGIN TRY
	DELETE FROM [dbo].[disk]
		  WHERE disk_id = @disk_id
END TRY
BEGIN CATCH
	PRINT 'An error occured.';
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_del_disk to diskUserac;
go
EXEC sp_del_disk 24
go
EXEC sp_del_disk 1  -- del disk that has been borrowed to throw error
go
