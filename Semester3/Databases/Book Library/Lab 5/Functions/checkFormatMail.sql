USE [Book Library]
GO
/****** Object:  UserDefinedFunction [dbo].[checkFormatMail]    Script Date: 1/17/2018 6:05:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[checkFormatMail]
(
	-- Add the parameters for the function here
	@mail varchar(MAX)
)
RETURNS BIT
AS
BEGIN
	IF @mail IS NULL
		RETURN 1
	IF LTRIM(@mail) = ''
		return 0
	IF LEN(@mail) < 3 
		RETURN 0

	declare @lungime int
	set @lungime = LEN(@mail)

	declare @contor int
	set @contor = 1

	declare @substrin varchar(MAX)
	declare @car char

	while @contor <= @lungime
	begin
		if not SUBSTRING(@mail, @contor, 1) like '%[a-zA-Z_0-9@.]'
			return 0

		set @contor = @contor + 1
	end
	return 1
END
