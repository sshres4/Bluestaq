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
    IF NOT EXISTS (SELECT 1 FROM dbo.Genre WHERE Name = @GenreName)
    BEGIN
        INSERT INTO dbo.Genre (Name)
        VALUES (@GenreName);
    END

    -- Get GenreID
    SELECT @GenreID = GenreID FROM dbo.Genre WHERE Name = @GenreName;

    -- Check if the book already exists
    IF EXISTS (SELECT 1 FROM dbo.Book WHERE ISBN = @ISBN)
    BEGIN
        -- Get the existing BookID
        SELECT @BookID = BookID FROM dbo.Book WHERE ISBN = @ISBN;

        -- Update the CopyCount
        UPDATE dbo.Book
        SET CopyCount = CopyCount + @CopyCount
        WHERE BookID = @BookID;

        -- Insert additional copies into Copies table
        DECLARE @i INT = 1;
        WHILE @i <= @CopyCount
        BEGIN
            INSERT INTO dbo.Copies (BookID, Status)
            VALUES (@BookID, 'Available');
            SET @i = @i + 1;
        END
    END
    ELSE
    BEGIN
        -- Insert into Book table
        INSERT INTO dbo.Book (Title, ISBN, Publisher, PublicationYear, GenreID, CopyCount)
        VALUES (@Title, @ISBN, @Publisher, @PublicationYear, @GenreID, @CopyCount);

        -- Get the newly inserted BookID
        SELECT @BookID = SCOPE_IDENTITY();

        -- Insert into Copies table
        DECLARE @i2 INT = 1;
        WHILE @i2 <= @CopyCount
        BEGIN
            INSERT INTO dbo.Copies (BookID, Status)
            VALUES (@BookID, 'Available');
            SET @i2 = @i2 + 1;
        END

        -- Check if Author exists, if not insert it
        IF NOT EXISTS (SELECT 1 FROM dbo.Author WHERE Name = @AuthorName)
        BEGIN
            INSERT INTO dbo.Author (Name)
            VALUES (@AuthorName);
        END

        -- Get AuthorID
        SELECT @AuthorID = AuthorID FROM dbo.Author WHERE Name = @AuthorName;

        -- Insert into BookAuthor table
        INSERT INTO dbo.BookAuthor (BookID, AuthorID)
        VALUES (@BookID, @AuthorID);
    END
END
