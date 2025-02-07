CREATE PROCEDURE dbo.InsertBook
    @Title NVARCHAR(255),
    @ISBN NVARCHAR(255),
    @Publisher NVARCHAR(255),
    @PublicationYear INT,
    @GenreName NVARCHAR(255),
    @CopyCount INT,
    @AuthorName NVARCHAR(255) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @GenreID INT;
    DECLARE @BookID INT;
    DECLARE @AuthorID INT;

    -- Check if Genre exists, if not insert it
    IF NOT EXISTS (SELECT 1 FROM Genre WHERE Name = @GenreName)
    BEGIN
        INSERT INTO Genre (Name)
        VALUES (@GenreName);
    END

    -- Get GenreID
    SELECT @GenreID = GenreID FROM Genre WHERE Name = @GenreName;

    -- Insert into Book table
    INSERT INTO Book (Title, ISBN, Publisher, PublicationYear, GenreID, CopyCount)
    VALUES (@Title, @ISBN, @Publisher, @PublicationYear, @GenreID, @CopyCount);

    -- Get the newly inserted BookID
    SELECT @BookID = SCOPE_IDENTITY();

    -- Insert into Copies table
    DECLARE @i INT = 1;
    WHILE @i <= @CopyCount
    BEGIN
        INSERT INTO Copies (BookID, Status)
        VALUES (@BookID, 'Available');
        SET @i = @i + 1;
    END

    -- Check if Author exists, if not insert it
    IF NOT EXISTS (SELECT 1 FROM Author WHERE Name = @AuthorName)
    BEGIN
        INSERT INTO Author (Name)
        VALUES (@AuthorName);
    END

    -- Get AuthorID
    SELECT @AuthorID = AuthorID FROM Author WHERE Name = @AuthorName;

    -- Insert into BookAuthor table
    INSERT INTO BookAuthor (BookID, AuthorID)
    VALUES (@BookID, @AuthorID);
END
