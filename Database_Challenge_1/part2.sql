/*
For the library management system, I have created following entities: Book, Author, Genre, BookAuthor, Copies, Borrower, Borrow, Hold, Waitlist
Reason for creating the extra tables were to handle standard cases where members were borrowing a book, putting a hold, creating a waitlist, tracking different copies of the same book etc
Below are the reuseable scripts to generate the table schema for the entities

*/


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Genre]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Genre] (
        GenreID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(255) NOT NULL
    );
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Book]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Book] (
        BookID INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(255) NOT NULL,
        ISBN NVARCHAR(13) NOT NULL,
        Publisher NVARCHAR(255) NOT NULL,
        PublicationYear INT NOT NULL,
        GenreID INT NOT NULL,
        FOREIGN KEY (GenreID) REFERENCES [dbo].[Genre](GenreID),
		CopyCount INT NOT NULL
    );
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Author]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Author] (
        AuthorID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(255),
        Bio NVARCHAR(MAX)
    );
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Borrower]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Borrower] (
        BorrowerID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(255),
        Address NVARCHAR(255),
        PhoneNumber NVARCHAR(15)
    );
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Copies]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Copies] (
        CopyID INT IDENTITY(1,1) PRIMARY KEY,
        BookID INT,
        Status NVARCHAR(50),
        FOREIGN KEY (BookID) REFERENCES [dbo].[Book](BookID)
    );
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BookAuthor]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[BookAuthor] (
        BookID INT,
        AuthorID INT,
        PRIMARY KEY (BookID, AuthorID),
        FOREIGN KEY (BookID) REFERENCES [dbo].[Book](BookID),
        FOREIGN KEY (AuthorID) REFERENCES [dbo].[Author](AuthorID)
    );
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Borrow]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Borrow] (
        BorrowID INT IDENTITY(1,1) PRIMARY KEY,
        BorrowerID INT,
        CopyID INT,
        BorrowDate DATE,
        ReturnDate DATE,
		DueDate DATE,
        FOREIGN KEY (BorrowerID) REFERENCES [dbo].[Borrower](BorrowerID),
        FOREIGN KEY (CopyID) REFERENCES [dbo].[Copies](CopyID)
    );
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hold]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Hold] (
        HoldID INT IDENTITY(1,1) PRIMARY KEY,
        BorrowerID INT,
        CopyID INT,
        HoldDate DATE,
        FOREIGN KEY (BorrowerID) REFERENCES [dbo].[Borrower](BorrowerID),
        FOREIGN KEY (CopyID) REFERENCES [dbo].[Copies](CopyID)
    );
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Waitlist]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Waitlist] (
        WaitlistID INT IDENTITY(1,1) PRIMARY KEY,
        BorrowerID INT,
        BookID INT,
        RequestDate DATE,
        FOREIGN KEY (BorrowerID) REFERENCES [dbo].[Borrower](BorrowerID),
        FOREIGN KEY (BookID) REFERENCES [dbo].[Book](BookID)
    );
END
