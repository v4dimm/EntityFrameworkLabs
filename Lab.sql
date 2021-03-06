USE [master]
GO
/****** Object:  Database [Lab]    Script Date: 21.03.2021 22:29:34 ******/
CREATE DATABASE [Lab]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Lab', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Lab.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Lab_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Lab_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Lab] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Lab].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Lab] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Lab] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Lab] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Lab] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Lab] SET ARITHABORT OFF 
GO
ALTER DATABASE [Lab] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Lab] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Lab] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Lab] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Lab] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Lab] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Lab] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Lab] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Lab] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Lab] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Lab] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Lab] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Lab] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Lab] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Lab] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Lab] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Lab] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Lab] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Lab] SET  MULTI_USER 
GO
ALTER DATABASE [Lab] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Lab] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Lab] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Lab] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Lab]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 21.03.2021 22:29:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[QuestionNumber] [int] NOT NULL,
	[PersonId] [uniqueidentifier] NOT NULL,
	[AnswerTime] [datetime2](7) NOT NULL,
	[AnswerText] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[QuestionNumber] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 21.03.2021 22:29:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [uniqueidentifier] NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[Patronymic] [varchar](100) NULL,
	[Age] [int] NOT NULL,
	[Gender] [char](1) NULL,
	[HasJob] [bit] NOT NULL,
	[UserID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 21.03.2021 22:29:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[Number] [int] NOT NULL,
	[QuestionText] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 21.03.2021 22:29:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleCode] [int] NOT NULL,
	[RoleName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 21.03.2021 22:29:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [uniqueidentifier] NOT NULL,
	[Login] [varchar](50) NOT NULL,
	[PasswordHash] [varchar](200) NOT NULL,
	[Salt] [uniqueidentifier] NOT NULL,
	[UserRole] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Person] ([Id], [LastName], [FirstName], [Patronymic], [Age], [Gender], [HasJob], [UserID]) VALUES (N'3ddb33de-de17-43d3-8395-004222b93e71', N'Иванов', N'Иван', N'Иванович', 20, N'м', 1, N'3ddb33de-de17-43d3-8395-004222b93e71')
INSERT [dbo].[Person] ([Id], [LastName], [FirstName], [Patronymic], [Age], [Gender], [HasJob], [UserID]) VALUES (N'3ddb33de-de17-43d3-8395-004222b93e73', N'Петров', N'Петр', N'Петрович', 23, N'м', 0, N'3ddb33de-de17-43d3-8395-004222b93e73')
INSERT [dbo].[Person] ([Id], [LastName], [FirstName], [Patronymic], [Age], [Gender], [HasJob], [UserID]) VALUES (N'3ddb33de-de17-43d3-8395-004222b93e78', N'Путшин', N'Михаил', N'Иванович', 60, N'м', 0, N'3ddb33de-de17-43d3-8395-004222b93e78')
INSERT [dbo].[Person] ([Id], [LastName], [FirstName], [Patronymic], [Age], [Gender], [HasJob], [UserID]) VALUES (N'4b5c8da1-4acf-4efb-bb2f-d619f5adb4a0', N'qweasd', N'qweqw', N'qweq', 23, N'м', 0, NULL)
GO
INSERT [dbo].[Question] ([Number], [QuestionText]) VALUES (1, N'Земля круглая?')
INSERT [dbo].[Question] ([Number], [QuestionText]) VALUES (2, N'Назовите страны с квадрартными флагами')
GO
INSERT [dbo].[Role] ([RoleCode], [RoleName]) VALUES (1, N'admin')
INSERT [dbo].[Role] ([RoleCode], [RoleName]) VALUES (2, N'user')
INSERT [dbo].[Role] ([RoleCode], [RoleName]) VALUES (3, N'guest')
GO
INSERT [dbo].[User] ([ID], [Login], [PasswordHash], [Salt], [UserRole]) VALUES (N'3ddb33de-de17-43d3-8395-004222b93e71', N'Ivan', N'7351384285A0F9A80103064C5DA4345A1166440B', N'3ddb33de-de17-43d3-8395-004222b93e71', 2)
INSERT [dbo].[User] ([ID], [Login], [PasswordHash], [Salt], [UserRole]) VALUES (N'3ddb33de-de17-43d3-8395-004222b93e73', N'Test', N'F373AC920F6EA1B089C2A844CE9669983E10AE27', N'3ddb33de-de17-43d3-8395-004222b93e73', 3)
INSERT [dbo].[User] ([ID], [Login], [PasswordHash], [Salt], [UserRole]) VALUES (N'3ddb33de-de17-43d3-8395-004222b93e78', N'Admin', N'E3AEAF2FF7D4C96D0BF7B3356D724ECF8BAC8B6D', N'3ddb33de-de17-43d3-8395-004222b93e78', 1)
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Person]
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Question] FOREIGN KEY([QuestionNumber])
REFERENCES [dbo].[Question] ([Number])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Question]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([UserRole])
REFERENCES [dbo].[Role] ([RoleCode])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [Lab] SET  READ_WRITE 
GO
