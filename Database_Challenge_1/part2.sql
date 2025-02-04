Create Table Books(
	BookID INT IDENTITY(1,1) PRIMARY KEY,
	Title NVarchar(255),
	ISBN NVarchar(13),
	YearPublished INT,
	Genre nvarchar(100)
);

Create Table Authors(
	AuthorID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVarchar(255),
	Bio NVarchar(1000)
);

Create Table Borrowers(
	BorrowerID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVarchar(255),
	Email NVarchar(255),
	PhoneNumber NVarchar(20),
	Address NVarchar(255)
);

Create Table Book_Authors(
	BookID INT,
	AuthorID INT,
	PRIMARY KEY (BookID, AuthorID),
	FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
	FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

Create Table Borrowed_Books(
	BorrowerID INT,
	BookID INT,
	BorrowDate Date,
	ReturnDate Date,
	PRIMARY KEY (BookID, BorrowerID, BorrowDate),
	FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
	FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID) ON DELETE CASCADE
);
