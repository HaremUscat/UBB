USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[mainViewsIndexes]    Script Date: 1/17/2018 6:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[mainViewsIndexes]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from View_client_clientGroups order by ClientGroupName
	select * from View_client_clientGroups order by FirstName

	select * from View_LangPub order by LanguageName
	select * from View_LangPub order by Adress
END
