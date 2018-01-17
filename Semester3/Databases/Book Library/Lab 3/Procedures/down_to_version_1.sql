USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[down_to_version_1]    Script Date: 1/17/2018 6:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[down_to_version_1]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--remove a column
	ALTER TABLE ClientGroups
	DROP COLUMN Number 
	print('down_to_version_1 - remove from ClientGroups table column Number')
END
