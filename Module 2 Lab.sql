create schema DirectMarketing
AUTHORIZATION dbo ;
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [DirectMarketing].[CampaignResponse](
	[CampaignResponseId] [int] IDENTITY(1,1) NOT NULL,
	[ResponceDate] [date] NOT NULL,
	[ResponceType] [varchar](50) NOT NULL,
	[ResponcePrice] [money] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[CampaignResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [DirectMarketing].[Competitor](
	[CompetitorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[CompetitorData] [varchar](50) NOT NULL,
	[Comments] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Competitor] PRIMARY KEY CLUSTERED 
(
	[CompetitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [DirectMarketing].[TVAdvertisement](
	[TVAdvertisementId] [int] IDENTITY(1,1) NOT NULL,
	[TVAdvertisement_Date] [date] NOT NULL,
	[TVAdvertisementId_Time1] [time](7) NOT NULL,
	[TVAdvertisementId_Time2] [time](7) NOT NULL,
	[TVAdvertisementIdAmount] [int] NOT NULL,
 CONSTRAINT [PK_TVAdvertisement] PRIMARY KEY CLUSTERED 
(
	[TVAdvertisementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


-----------------------------------------------------------

create schema Employee
AUTHORIZATION dbo ;
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Employee].[Detail](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeTypeId] [int] NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[MobileNumber] [varchar](50) NOT NULL,
	[EmailId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Employee.Detail] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [Employee].[Detail]  WITH CHECK ADD  CONSTRAINT [FK_Employee.Detail_Employee.Type] FOREIGN KEY([EmployeeTypeId])
REFERENCES [Employee].[Type] ([EmployeeTypeId])
GO

ALTER TABLE [Employee].[Detail] CHECK CONSTRAINT [FK_Employee.Detail_Employee.Type]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Employee].[Type](
	[EmployeeTypeId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeTypeName] [varchar](10) NOT NULL,
 CONSTRAINT [PK_.Type] PRIMARY KEY CLUSTERED 
(
	[EmployeeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO