Create Database db_library

use db_library

/***** tbl_publisher VALUES *****/
create table tbl_publisher (
	pub_name varchar(50) PRIMARY KEY NOT NULL,
	pub_address varchar(50) NOT NULL, 
	pub_phone varchar(50) NOT Null
	);

INSERT INTO tbl_publisher
	(pub_name, pub_address, pub_phone)
	VALUES
	('Pikachu Publishing', '2518 SW Brock Ave, Portland, Or', '503-779-4485'),
	('Bulbasaur Books', '8421 NE Misty St, New York, New York', '442-578-6321'),
	('Squirtle Scribes', '001 NW Ash Court, Seattle, Wa', '405-215-2283')
	;
Select * from tbl_publisher


/***** tbl_library_branch VALUES *****/
create table tbl_library_branch (
	branch_id INT PRIMARY KEY NOT NULL IDENTITY (256,1),
	branch_name varchar(50), 
	branch_address varchar(50)
	);

INSERT INTO tbl_library_branch
	(branch_name, branch_address)
	VALUES
	('Central Public Library', '41 NW Elite Four Terrace, Lavender Town, ME'),
	('Sharpstown Private Book Gallery', '82 SW Rocket Row, Celadon City, CA'),
	('Fuchsia City Municipal Library', '35 Meowth Lane, Bismarck, ND'),
	('Saffron City University Library', '63 Onyx Court, Houston, TX')
	;
Select * from tbl_library_branch



/***** tbl_borrower VALUES *****/
create table tbl_borrower (
	card_num INT PRIMARY KEY NOT NULL IDENTITY (919,1),
	card_name varchar(50),
	card_address varchar(50),
	card_phone varchar(50)
	);

INSERT INTO tbl_borrower
	(card_name, card_address, card_phone)
	VALUES
	('Mira Morrison', '5642 NW Bank Lane, Miami, FL', '654-321-7534'),
	('Ela Scene', '6425 SW Hereford Ave, Orlando, FL', '321-541-5431'),
	('Thomas Thermite', '8754 NE Skyscraper Ave, Austin, TX', '987-918-2167'),
	('Dokhebi Vibe', '3218 SW Yacht Street, Denver, CO', '751-764-5168'),
	('Janna Frost', '8465 NE Theme Park Loop, San Fransico, CA', '624-637-6521'),
	('D.K. Blackbeard', '6543 NW Kanal Way, Boise, ID', '531-887-1597'),
	('Pierre Kapkan', '1856 SE Chalet View, Sioux Falls, SD', '813-113-0284'),
	('Ric Kastle', '2541 N Favela Drive, Las Vegas, NV', '453-025-4120')
	;

Insert into tbl_borrower
	(card_name, card_address, card_phone)
	VALUES
	('Jack Al-Sneak', '218 NW Tower Heights, Beaverton, OR', '125-654-3518')
	;
Select * from tbl_borrower


/***** tbl_book VALUES *****/
create table tbl_book (
	book_id INT PRIMARY KEY NOT NULL IDENTITY (348,1),
	book_title varchar(50) NOT NULL, 
	pub_name varchar(50) FOREIGN KEY REFERENCES tbl_publisher(pub_name) ON UPDATE CASCADE ON DELETE CASCADE, 
	);

INSERT INTO tbl_book
	(book_title, pub_name)
	VALUES
	('Little Fires Everywhere', 'Pikachu Publishing'),
	('Into the Water', 'Bulbasaur Books'),
	('Before We Were Yours', 'Squirtle Scribes'),
	('Fantastic Beasts and Where to Find Them', 'Squirtle Scribes'),
	('Without Merit', 'Pikachu Publishing'),
	('Artemis', 'Squirtle Scribes'),
	('Sleeping Beauties', 'Bulbasaur Books'),
	('Talking as Fast as I Can', 'Bulbasaur Books'),
	('How to Be a Bawse', 'Pikachu Publishing'),
	('What Happened?', 'Squirtle Scribes'),
	('The Radium Girls', 'Squirtle Scribes'),
	('Astrophysics for People in a Hurry', 'Pikachu Publishing'),
	('The Pioneer Woman Cooks', 'Bulbasaur Books'),
	('Big Mushy Happy Lump', 'Bulbasaur Books'),
	('The Sun and Her Flowers', 'Squirtle Scribes'),
	('The Hate U Gave', 'Pikachu Publishing'),
	('A Court of Wings and Ruin', 'Bulbasaur Books'),
	('The Ship of the Dead', 'Pikachu Publishing'),
	('We Are All Wonders', 'Pikachu Publishing'),
	('The Shining', 'Bulbasaur Books'),
	('The Lost Tribe','Squirtle Scribes')
	;
Select * from tbl_book



/***** tbl_book_authors VALUES *****/
create table tbl_book_authors (
	auth_pk INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	book_id INT NOT NULL FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	auth_name varchar(50) NOT NULL, 
	);

INSERT INTO tbl_book_authors
	(book_id, auth_name)
	VALUES
	(348, 'Celeste Ng'),
	(349, 'Paula Hawkins'),
	(350, 'Lisa Wingate'),
	(351, 'J.K. Rowling'),
	(352, 'Colleen Hoover'),
	(353, 'Andy Weir'),
	(354, 'Stephen King'),
	(355, 'Lauren Graham'),
	(356, 'Lilly Singh'),
	(357, 'Hillary Rodham Clinton'),
	(358, 'Kate Moore'),
	(359, 'Neil deGrasse Tyson'),
	(360, 'Ree Drummond'),
	(361, 'Sarah Andersen'),
	(362, 'Rupi Kaur'),
	(363, 'Angie Thomas'),
	(364, 'Sarah J. Maas'),
	(365, 'Rick Riordan'),
	(366, 'R.J. Palacio'),
	(367, 'Stephen King'),
	(368, 'Matthew Caldwell')
	;
Select * from tbl_book_authors



/***** tbl_book_copies VALUES *****/
create table tbl_book_copies (
	copy_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	book_id INT NOT NULL FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE, 
	branch_id INT NOT NULL FOREIGN KEY REFERENCES tbl_library_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
	copy_num_books INT NOT NULL
	);

INSERT INTO tbl_book_copies
	(book_id, branch_id, copy_num_books)
	VALUES
	(354, 256, 6),
	(367, 256, 3),
	(348, 256, 4),
	(365, 256, 2),
	(359, 256, 3),
	(361, 256, 4),
	(352, 256, 7),
	(364, 256, 2),
	(368, 256, 6),
	(351, 256, 4), -- Central Library ^^
	(368, 257, 2),
	(349, 257, 6),
	(360, 257, 7),
	(366, 257, 6),
	(358, 257, 2),
	(362, 257, 4),
	(348, 257, 5),
	(353, 257, 3),
	(355, 257, 2),
	(356, 257, 8), -- Sharpstown ^^
	(348, 258, 4),
	(349, 258, 2),
	(350, 258, 4),
	(351, 258, 3),
	(352, 258, 5),
	(353, 258, 4),
	(354, 258, 7),
	(355, 258, 6),
	(356, 258, 5),
	(357, 258, 4), -- Fuschia Library ^^
	(358, 259, 2),
	(359, 259, 3),
	(360, 259, 5),
	(361, 259, 4),
	(362, 259, 6),
	(363, 259, 8),
	(364, 259, 4),
	(365, 259, 3),
	(366, 259, 5),
	(367, 259, 2) -- Saffron City ^^
	;
Select * from tbl_book_copies



/***** tbl_book_loans VALUES *****/
create table tbl_book_loans (
	loan_id INT PRIMARY KEY NOT NULL IDENTITY (420,1),
	book_id INT NOT NULL FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE, 
	branch_id INT NOT NULL FOREIGN KEY REFERENCES tbl_library_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
	card_num INT NOT NULL FOREIGN KEY REFERENCES tbl_borrower(card_num) ON UPDATE CASCADE ON DELETE CASCADE,
	date_out varchar(50), 
	date_due varchar(50)
	);

INSERT INTO tbl_book_loans
	(book_id, branch_id, card_num, date_out, date_due)
	VALUES
	(367, 256, 919, '3/24/18', '4/14/18'),
	(365, 256, 919, '3/24/18', '4/14/18'),
	(368, 256, 919, '3/24/18', '4/14/18'),
	(348, 256, 925, '3/29/18', '4/17/18'),
	(367, 256, 925, '3/29/18', '4/17/18'),
	(361, 256, 925, '3/24/18', '4/14/18'),
	(351, 256, 925, '3/24/18', '4/14/18'),
	(359, 256, 923, '3/24/18', '4/14/18'),
	(354, 256, 923, '3/29/18', '4/17/18'),
	(359, 256, 923, '3/24/18', '4/14/18'),
	(348, 256, 923, '3/24/18', '4/14/18'),
	(364, 256, 919, '3/29/18', '4/17/18'),
	(359, 256, 919, '3/31/18', '4/21/18'),
	(361, 256, 923, '3/24/18', '4/14/18'),
	(348, 256, 919, '3/31/18', '4/21/18'),
	(365, 256, 925, '3/31/18', '4/21/18'),
	(352, 256, 923, '3/29/18', '4/17/18'), -- Central Checkouts
	(356, 257, 920, '3/22/18', '4/11/18'),
	(348, 257, 920, '3/22/18', '4/11/18'),
	(349, 257, 920, '3/27/18', '4/15/18'),
	(368, 257, 924, '3/27/18', '4/15/18'),
	(366, 257, 924, '3/22/18', '4/11/18'),
	(360, 257, 924, '3/22/18', '4/11/18'),
	(355, 257, 926, '3/30/18', '4/21/18'),
	(349, 257, 926, '3/30/18', '4/21/18'),
	(368, 257, 926, '3/22/18', '4/11/18'),
	(358, 257, 920, '3/27/18', '4/15/18'),
	(358, 257, 924, '3/22/18', '4/11/18'),
	(348, 257, 924, '3/27/18', '4/15/18'), -- Sharpstown Checkouts
	(357, 258, 922, '4/1/18', '4/21/18'),
	(353, 258, 922, '4/1/18', '4/21/18'),
	(355, 258, 922, '4/7/18', '4/25/18'),
	(356, 258, 926, '4/7/18', '4/25/18'),
	(348, 258, 926, '4/1/18', '4/21/18'),
	(349, 258, 926, '4/1/18', '4/21/18'),
	(353, 258, 926, '4/7/18', '4/25/18'),
	(349, 258, 922, '4/7/18', '4/25/18'),
	(357, 258, 926, '4/1/18', '4/21/18'),
	(357, 258, 919, '4/7/18', '4/25/18'),
	(355, 258, 919, '4/1/18', '4/21/18'),
	(351, 258, 922, '4/1/18', '4/21/18'), --  Fuschia Checkouts
	(365, 259, 921, '3/17/18', '4/8/18'),
	(366, 259, 921, '3/17/18', '4/8/18'),
	(367, 259, 923, '3/25/18', '4/15/18'),
	(357, 259, 923, '3/17/18', '4/8/18'),
	(358, 259, 920, '3/25/18', '4/15/18'),
	(358, 259, 921, '3/25/18', '4/15/18'),
	(360, 259, 920, '3/17/18', '4/8/18'),
	(360, 259, 923, '3/17/18', '4/8/18'),
	(359, 259, 921, '3/25/18', '4/15/18') -- Saffron Checkouts
	;
Select * from tbl_book_loans

select * from tbl_book
Select * from tbl_borrower
Select * from tbl_book_copies
Select * From tbl_book_authors
Select * from tbl_library_branch
select * from tbl_publisher