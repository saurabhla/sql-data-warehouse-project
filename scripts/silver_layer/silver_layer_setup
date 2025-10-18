USE [DataWarehouse]
GO

/****** Object:  Table [silver].[crm_cust_info]    Script Date: 18-10-2025 22:55:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [silver].[crm_cust_info](
	[cst_id] [int] NULL,
	[cst_key] [nvarchar](50) NULL,
	[cst_firstname] [nvarchar](50) NULL,
	[cst_lastname] [nvarchar](50) NULL,
	[cst_material_status] [nvarchar](50) NULL,
	[cst_gndr] [nvarchar](50) NULL,
	[cst_create_date] [date] NULL,
	[dwh_create_date] [datetime2](7) NULL
) ON [PRIMARY]
GO

ALTER TABLE [silver].[crm_cust_info] ADD  DEFAULT (getdate()) FOR [dwh_create_date]
GO


USE [DataWarehouse]
GO

/****** Object:  Table [silver].[crm_prd_info]    Script Date: 18-10-2025 22:56:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [silver].[crm_prd_info](
	[prd_id] [int] NULL,
	[cat_id] [nvarchar](50) NULL,
	[prd_key] [nvarchar](50) NULL,
	[prd_nm] [nvarchar](50) NULL,
	[prd_cost] [int] NULL,
	[prd_line] [nvarchar](50) NULL,
	[prd_start_dt] [date] NULL,
	[prd_end_dt] [date] NULL,
	[dwh_create_date] [datetime2](7) NULL
) ON [PRIMARY]
GO

ALTER TABLE [silver].[crm_prd_info] ADD  DEFAULT (getdate()) FOR [dwh_create_date]
GO


USE [DataWarehouse]
GO

/****** Object:  Table [silver].[crm_sales_details]    Script Date: 18-10-2025 22:56:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [silver].[crm_sales_details](
	[sls_ord_num] [nvarchar](50) NULL,
	[sls_prd_key] [nvarchar](50) NULL,
	[sls_cust_id] [int] NULL,
	[sls_order_dt] [date] NULL,
	[sls_ship_dt] [date] NULL,
	[sls_due_dt] [date] NULL,
	[sls_sales] [int] NULL,
	[sls_quantity] [int] NULL,
	[sls_price] [int] NULL,
	[dwh_create_date] [datetime2](7) NULL
) ON [PRIMARY]
GO

ALTER TABLE [silver].[crm_sales_details] ADD  DEFAULT (getdate()) FOR [dwh_create_date]
GO


