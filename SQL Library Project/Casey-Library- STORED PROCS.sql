

/** How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?  **/
Create Proc dbo.uspBranchCopies @Book nvarchar(50), @branch nvarchar(50)
AS
	Select
	a1.book_title as 'Title:', a4.auth_name as 'Author:', a3.branch_name as 'Library Branch:', a2.copy_num_books as 'Quantity Owned:' 
	FROM dbo.tbl_book a1
	Inner Join tbl_book_copies a2 ON a2.book_id = a1.book_id
	Inner Join tbl_library_branch a3 ON a3.branch_id = a2.branch_id
	Inner Join tbl_book_authors a4 ON a4.book_id = a1.book_id
	Where a1.book_title = ISNULL(@Book,book_title) AND a3.branch_name like '%' + (@branch)
	;

EXEC dbo.uspBranchCopies @book = 'The Lost Tribe', @branch = 'Sharpstown%'
GO


/** How many copies of the book titled "The Lost Tribe" are owned by each library branch? **/
Create PROC dbo.uspBookSearch @book nvarchar(50) = NULL 
AS
	Select
	a1.book_title as 'Title:', a4.auth_name as 'Author:', a3.branch_name as 'Library Branch:', a2.copy_num_books as 'Quantity Owned:' 
	FROM dbo.tbl_book a1
	Inner Join tbl_book_copies a2 ON a2.book_id = a1.book_id
	Inner Join tbl_library_branch a3 ON a3.branch_id = a2.branch_id
	Inner Join tbl_book_authors a4 ON a4.book_id = a1.book_id
	Where book_title = ISNULL(@Book,book_title)
	;

EXEC dbo.uspBookSearch @book = 'The Lost Tribe'
GO


/**  Retrieve the names of all borrowers who do not have any books checked out.  **/
Create PROC dbo.uspNoCheck
AS
	Select tbl_borrower.card_num as 'Member ID:', tbl_borrower.card_name as 'Member Name:', tbl_borrower.card_address as 'Member Address:' 
	FROM tbl_borrower 
	WHERE card_num NOT IN (Select card_num FROM tbl_book_loans)

EXEC dbo.uspNoCheck
GO


/**  For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the 
book title, the borrower's name, and the borrower's address.  **/

-- Due Dates In System: M/DD/YY (April 14, 17, 21, 11, 15, 25, 8) --

Create Proc dbo.uspBranchDue @dueDate nvarchar(50), @branch nvarchar(50)
AS
	Select
	a2.book_title as 'Title:', a3.auth_name as 'Author:', a5.branch_name as 'Library Branch:', a1.date_due as 'Due Date:', a4.card_num as 'Member ID:', a4.card_name as 'Member Name:', a4.card_address as 'Member Address:'
	From dbo.tbl_book_loans a1
	Inner Join tbl_book a2 ON a2.book_id = a1.book_id
	Inner Join tbl_book_authors a3 ON a3.book_id = a2.book_id
	Inner Join tbl_borrower a4 ON a4.card_num = a1.card_num
	Inner Join tbl_library_branch a5 ON a5.branch_id = a1.branch_id
	Where date_due = ISNULL(@dueDate,date_due) AND a5.branch_name like '%' + (@branch)

EXEC dbo.uspBranchDue @dueDate = '4/21/18', @branch = 'Sharpstown%'
GO

/**  For each library branch, retrieve the branch name and the total number of books loaned out from that branch. **/
Create Proc dbo.uspBranchLoan
AS
	Select
	a1.branch_name as 'Library Branch:', COUNT(card_num) AS 'Books Checked Out of Branch:'
	From dbo.tbl_library_branch a1
	Inner Join tbl_book_loans a2 ON a2.branch_id = a1.branch_id
	Inner Join tbl_book a3 ON a3.book_id = a2.book_id
	Inner Join tbl_book_authors a4 ON a4.book_id = a3.book_id
	WHERE card_num IS Not Null
	GROUP BY branch_name
	HAVING COUNT(branch_name) > 3
	;

EXEC dbo.uspBranchLoan
GO


/** Retrieve the names, addresses, and number of books checked out for 
all borrowers who have more than five books checked out. **/
Create Proc dbo.uspMemberCheck
AS
	Select
	COUNT(loan_id) AS 'Books Checked Out:', a5.card_name as 'Member Name:', a5.card_address
	From dbo.tbl_library_branch a1
	FULL OUTER JOIN tbl_book_loans a2 ON a2.branch_id = a1.branch_id
	FULL OUTER JOIN tbl_borrower a5 ON a5.card_num = a2.card_num
	WHERE loan_id IS Not Null
	GROUP BY card_name, card_address
	HAVING COUNT(card_name) > 5
	Order By Count(card_name) DESC
	;

EXEC dbo.uspMemberCheck
GO


/** For each book authored (or co-authored) by "Stephen King", retrieve the title and the number 
of copies owned by the library branch whose name is "Central".  **/
Create Proc dbo.uspKing
AS
	Select
	a1.book_title as 'Title:', a4.auth_name as 'Author:', a3.branch_name as 'Library Branch:', a2.copy_num_books as 'Quantity Owned:' 
	FROM dbo.tbl_book a1
	Inner Join tbl_book_copies a2 ON a2.book_id = a1.book_id
	Inner Join tbl_library_branch a3 ON a3.branch_id = a2.branch_id
	Inner Join tbl_book_authors a4 ON a4.book_id = a1.book_id
	Where a4.auth_name = 'Stephen King' AND a3.branch_name = 'Central Public Library'
	;

EXEC dbo.uspKing
GO




Drop Proc dbo.uspBranchLoan