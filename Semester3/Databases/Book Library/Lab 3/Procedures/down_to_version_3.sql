USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[down_to_version_3]    Script Date: 1/17/2018 6:29:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[down_to_version_3]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--remove a new table
	DROP TABLE School
	
	print('down_to_version_3 - remove table School')
END
