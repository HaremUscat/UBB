USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[up_to_version_1]    Script Date: 1/17/2018 6:31:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[up_to_version_1]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- modify the type of a column
	ALTER TABLE Clients
	ALTER COLUMN ClientCode varchar(6) NOT NULL
	print('up_to_version_1 - modify column ClientCode from int to varchar(6)')
END
