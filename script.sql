USE [master]
GO
/****** Object:  Database [EmployeeRecords]    Script Date: 11/11/2021 7:22:42 PM ******/
CREATE DATABASE [EmployeeRecords]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeRecords', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\EmployeeRecords.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EmployeeRecords_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\EmployeeRecords_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EmployeeRecords] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeRecords].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeRecords] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeRecords] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeRecords] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeRecords] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeRecords] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeRecords] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeeRecords] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeRecords] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeRecords] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeRecords] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeRecords] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeRecords] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeRecords] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeRecords] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeRecords] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeeRecords] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeRecords] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeRecords] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeRecords] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeRecords] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeRecords] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeRecords] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeRecords] SET RECOVERY FULL 
GO
ALTER DATABASE [EmployeeRecords] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeRecords] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeRecords] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeRecords] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeRecords] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EmployeeRecords] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmployeeRecords', N'ON'
GO
USE [EmployeeRecords]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 11/11/2021 7:22:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[spEmployee_CRUD]    Script Date: 11/11/2021 7:22:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spEmployee_CRUD]
      @Action VARCHAR(20)
      ,@Id INT = NULL
      ,@FirstName NVARCHAR(50) = NULL
      ,@MiddleName NVARCHAR(50) = NULL
	  ,@LastName NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
 
    --SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT Id, FirstName, MiddleName, LastName
            FROM Employee
      END

	--SELECT BY ID
    IF @Action = 'SELECTBYID'
      BEGIN
            SELECT Id, FirstName, MiddleName, LastName
            FROM Employee
			WHERE Id = @Id
      END
 
    --INSERT
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO Employee(FirstName, MiddleName, LastName)
            VALUES (@FirstName, @MiddleName, @LastName)
 
            SET @Id = SCOPE_IDENTITY()
            SELECT @Id, @FirstName, @MiddleName, @LastName
      END
 
    --UPDATE
    IF @Action = 'UPDATE'
      BEGIN
            UPDATE Employee
            SET FirstName = @FirstName, MiddleName = @MiddleName, LastName = @LastName
            WHERE Id = @Id
 
            SELECT @Id, @FirstName, @MiddleName, @LastName
            FROM Employee
            WHERE Id = @Id
      END
 
    --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM Employee
            WHERE Id = @Id
 
            SELECT @Id, @FirstName, @MiddleName, @LastName
      END
END

GO
USE [master]
GO
ALTER DATABASE [EmployeeRecords] SET  READ_WRITE 
GO
