USE [master]
GO
/****** Object:  Database [PartsCatalog]    Script Date: 11/11/2015 9:22:09 AM ******/
CREATE DATABASE [PartsCatalog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PartsCatalog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER2012\MSSQL\DATA\PartsCatalog.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PartsCatalog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER2012\MSSQL\DATA\PartsCatalog_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PartsCatalog] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PartsCatalog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PartsCatalog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PartsCatalog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PartsCatalog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PartsCatalog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PartsCatalog] SET ARITHABORT OFF 
GO
ALTER DATABASE [PartsCatalog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PartsCatalog] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [PartsCatalog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PartsCatalog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PartsCatalog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PartsCatalog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PartsCatalog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PartsCatalog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PartsCatalog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PartsCatalog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PartsCatalog] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PartsCatalog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PartsCatalog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PartsCatalog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PartsCatalog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PartsCatalog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PartsCatalog] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [PartsCatalog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PartsCatalog] SET RECOVERY FULL 
GO
ALTER DATABASE [PartsCatalog] SET  MULTI_USER 
GO
ALTER DATABASE [PartsCatalog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PartsCatalog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PartsCatalog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PartsCatalog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PartsCatalog', N'ON'
GO
USE [PartsCatalog]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 11/11/2015 9:22:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Component]    Script Date: 11/11/2015 9:22:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Component](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComponentNumber] [nvarchar](max) NULL,
	[ComponentDescription] [nvarchar](max) NULL,
	[Material] [nvarchar](max) NULL,
	[UnitOfMeasure] [nvarchar](max) NULL,
	[Type] [int] NOT NULL,
	[ParentPartId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Component] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LaborSequences]    Script Date: 11/11/2015 9:22:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LaborSequences](
	[Id] [int] NOT NULL,
	[LaborSequenceNumber] [nvarchar](50) NULL,
	[LaborSequenceDesc] [nvarchar](max) NULL,
	[RunTime] [decimal](18, 0) NULL,
	[Burden] [decimal](18, 0) NULL,
	[LaborRate] [decimal](18, 0) NULL,
	[Facility] [varchar](50) NULL,
	[Machine] [varchar](50) NULL,
	[ParentPartId] [int] NOT NULL,
 CONSTRAINT [PK_LaborSequences] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Parts]    Script Date: 11/11/2015 9:22:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PartNumber] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[User] [nvarchar](max) NULL,
	[SalesCode] [nvarchar](max) NULL,
	[ExtendedDescription] [nvarchar](max) NULL,
	[Facility] [nvarchar](max) NULL,
	[InventType] [nvarchar](max) NULL,
	[ItemClass] [nvarchar](max) NULL,
	[LeadTimeCode] [nvarchar](max) NULL,
	[MfgLeadTime] [nvarchar](max) NULL,
	[PartDescription] [nvarchar](max) NULL,
	[PartNumberNoFacility] [nvarchar](max) NULL,
	[ProductType] [nvarchar](max) NULL,
	[UnitOfMeasure] [nvarchar](max) NULL,
	[HiddenSpec] [nvarchar](max) NULL,
	[PriceIsRfq] [bit] NOT NULL,
	[DrawingNumber] [nvarchar](max) NULL,
	[RevisionComments] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[EngineeringStatus] [nvarchar](max) NULL,
	[InventoryStatus] [nvarchar](max) NULL,
	[TotalQuantityRequired] [float] NOT NULL,
	[TotalSquareFootage] [float] NOT NULL,
	[BomLevel] [int] NOT NULL,
	[Cost] [float] NOT NULL,
	[BaseCost] [float] NOT NULL,
	[Qpa] [float] NOT NULL,
	[BaseQpa] [float] NOT NULL,
	[MarketCost] [float] NOT NULL,
	[BaseMarketCost] [float] NOT NULL,
	[BatchSize] [float] NOT NULL,
	[TotalWeight] [float] NOT NULL,
	[CostError] [bit] NOT NULL,
	[ParentNum] [nvarchar](max) NULL,
	[ShopFloorNotes] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Parts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Index [IX_ParentPart_Id]    Script Date: 11/11/2015 9:22:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_ParentPart_Id] ON [dbo].[Component]
(
	[ParentPartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Component]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Component_dbo.Parts_ParentPartId] FOREIGN KEY([ParentPartId])
REFERENCES [dbo].[Parts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Component] CHECK CONSTRAINT [FK_dbo.Component_dbo.Parts_ParentPartId]
GO
ALTER TABLE [dbo].[LaborSequences]  WITH CHECK ADD  CONSTRAINT [FK_LaborSequences_ParentPartId] FOREIGN KEY([ParentPartId])
REFERENCES [dbo].[Parts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LaborSequences] CHECK CONSTRAINT [FK_LaborSequences_ParentPartId]
GO
USE [master]
GO
ALTER DATABASE [PartsCatalog] SET  READ_WRITE 
GO
