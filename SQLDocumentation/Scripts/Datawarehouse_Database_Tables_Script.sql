USE [Datawarehouse_DB]
GO
/****** Object:  Table [dbo].[dim_customer]    Script Date: 10/17/2024 5:56:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_customer](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Email] [nvarchar](255) NULL,
	[Phone] [nvarchar](20) NULL,
	[DateOfBirth] [date] NULL,
	[RegistrationDate] [date] NULL,
	[Address] [nvarchar](255) NULL,
	[City] [nvarchar](100) NULL,
	[Country] [nvarchar](100) NULL,
	[PostalCode] [nvarchar](20) NULL,
	[AddressType] [nvarchar](50) NULL,
	[WishlistID] [int] NULL,
	[ProductID] [int] NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NULL,
	[is_current] [tinyint] NOT NULL,
 CONSTRAINT [PK_dim_customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_date]    Script Date: 10/17/2024 5:56:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_date](
	[DateKey] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[FullDate] [char](10) NULL,
	[DayOfMonth] [varchar](2) NULL,
	[DayName] [varchar](9) NULL,
	[DayOfWeek] [char](1) NULL,
	[DayOfWeekInMonth] [varchar](2) NULL,
	[DayOfWeekInYear] [varchar](2) NULL,
	[DayOfQuarter] [varchar](3) NULL,
	[DayOfYear] [varchar](3) NULL,
	[WeekOfMonth] [varchar](1) NULL,
	[WeekOfQuarter] [varchar](2) NULL,
	[WeekOfYear] [varchar](2) NULL,
	[Month] [varchar](2) NULL,
	[MonthName] [varchar](9) NULL,
	[MonthOfQuarter] [varchar](2) NULL,
	[Quarter] [char](1) NULL,
	[QuarterName] [varchar](9) NULL,
	[Year] [char](4) NULL,
	[YearName] [char](7) NULL,
	[MonthYear] [char](10) NULL,
	[MMYYYY] [char](6) NULL,
	[FirstDayOfMonth] [date] NULL,
	[LastDayOfMonth] [date] NULL,
	[FirstDayOfQuarter] [date] NULL,
	[LastDayOfQuarter] [date] NULL,
	[FirstDayOfYear] [date] NULL,
	[LastDayOfYear] [date] NULL,
 CONSTRAINT [PK__DimDate__40DF45E3E924B2E5] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_interaction]    Script Date: 10/17/2024 5:56:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_interaction](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[InteractionDate] [date] NULL,
	[Channel] [nvarchar](50) NULL,
	[Notes] [nvarchar](500) NULL,
	[InteractionTypeName] [nvarchar](50) NULL,
	[InteractionID] [int] NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NULL,
	[is_current] [tinyint] NOT NULL,
 CONSTRAINT [PK_dim_interaction] PRIMARY KEY CLUSTERED 
(
	[InteractionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_product]    Script Date: 10/17/2024 5:56:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_product](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductName] [nvarchar](100) NULL,
	[Price] [numeric](10, 2) NULL,
	[CategoryName] [nvarchar](100) NULL,
	[CategoryDescription] [nvarchar](255) NULL,
	[Rating] [int] NULL,
	[ReviewText] [nvarchar](500) NULL,
	[ReviewDate] [date] NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NULL,
	[is_current] [tinyint] NOT NULL,
 CONSTRAINT [PK_dim_product] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_user]    Script Date: 10/17/2024 5:56:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_user](
	[UserKey] [int] IDENTITY(1,1) NOT NULL,
	[LoginID] [int] NULL,
	[Username] [nvarchar](100) NULL,
	[PasswordHash] [nvarchar](255) NULL,
	[Role] [nvarchar](50) NULL,
	[LoginTime] [datetime] NULL,
	[LogoutTime] [datetime] NULL,
	[LastLogin] [datetime] NULL,
	[LogType] [nvarchar](50) NULL,
	[Message] [nvarchar](255) NULL,
	[Timestamp] [datetime] NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NULL,
	[is_current] [tinyint] NOT NULL,
	[CustomerID] [int] NULL,
 CONSTRAINT [PK_dim_user] PRIMARY KEY CLUSTERED 
(
	[UserKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_transactions]    Script Date: 10/17/2024 5:56:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_transactions](
	[TransactionID] [int] NOT NULL,
	[TransactionDate] [datetime] NULL,
	[TransactionType] [nvarchar](50) NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[Quantity] [int] NULL,
	[Price] [numeric](10, 2) NULL,
	[ProductID] [int] NULL,
	[CustomerID] [int] NULL,
 CONSTRAINT [PK_fact_transactions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dim_customer] ADD  CONSTRAINT [DF__dim_custo__start__2B3F6F97]  DEFAULT (getdate()) FOR [start_date]
GO
ALTER TABLE [dbo].[dim_customer] ADD  CONSTRAINT [DF__dim_custo__is_cu__2C3393D0]  DEFAULT ((1)) FOR [is_current]
GO
ALTER TABLE [dbo].[dim_interaction] ADD  CONSTRAINT [DF__dim_inter__start__02FC7413]  DEFAULT (getdate()) FOR [start_date]
GO
ALTER TABLE [dbo].[dim_interaction] ADD  CONSTRAINT [DF__dim_inter__is_cu__03F0984C]  DEFAULT ((1)) FOR [is_current]
GO
ALTER TABLE [dbo].[dim_product] ADD  DEFAULT (getdate()) FOR [start_date]
GO
ALTER TABLE [dbo].[dim_product] ADD  DEFAULT ((1)) FOR [is_current]
GO
ALTER TABLE [dbo].[dim_user] ADD  DEFAULT (getdate()) FOR [start_date]
GO
ALTER TABLE [dbo].[dim_user] ADD  DEFAULT ((1)) FOR [is_current]
GO
ALTER TABLE [dbo].[dim_interaction]  WITH CHECK ADD  CONSTRAINT [FK_dim_interaction_dim_customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[dim_customer] ([CustomerID])
GO
ALTER TABLE [dbo].[dim_interaction] CHECK CONSTRAINT [FK_dim_interaction_dim_customer]
GO
ALTER TABLE [dbo].[dim_user]  WITH CHECK ADD  CONSTRAINT [FK_dim_user_dim_customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[dim_customer] ([CustomerID])
GO
ALTER TABLE [dbo].[dim_user] CHECK CONSTRAINT [FK_dim_user_dim_customer]
GO
ALTER TABLE [dbo].[fact_transactions]  WITH CHECK ADD  CONSTRAINT [FK_fact_transactions_dim_customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[dim_customer] ([CustomerID])
GO
ALTER TABLE [dbo].[fact_transactions] CHECK CONSTRAINT [FK_fact_transactions_dim_customer]
GO
ALTER TABLE [dbo].[fact_transactions]  WITH CHECK ADD  CONSTRAINT [FK_fact_transactions_dim_date] FOREIGN KEY([TransactionDate])
REFERENCES [dbo].[dim_date] ([Date])
GO
ALTER TABLE [dbo].[fact_transactions] CHECK CONSTRAINT [FK_fact_transactions_dim_date]
GO
ALTER TABLE [dbo].[fact_transactions]  WITH CHECK ADD  CONSTRAINT [FK_fact_transactions_dim_product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[dim_product] ([ProductKey])
GO
ALTER TABLE [dbo].[fact_transactions] CHECK CONSTRAINT [FK_fact_transactions_dim_product]
GO
