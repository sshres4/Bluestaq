CREATE PROCEDURE InsertBook (
    @Title NVARCHAR(255),
    @ISBN NVARCHAR(13),
    @YearPublished INT,
    @Genre NVARCHAR(100))

AS
BEGIN
    SET NOCOUNT ON;

    -- Insert book into Books table
    INSERT INTO Books (Title, ISBN, YearPublished, Genre)
    VALUES (@Title, @ISBN, @YearPublished, @Genre);
END;