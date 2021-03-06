USE [Book Library]
GO
/****** Object:  UserDefinedFunction [dbo].[checkFormatWebsite]    Script Date: 1/17/2018 6:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[checkFormatWebsite]
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
	IF LEN(@mail) < 13
		RETURN 0

	declare @lungime int
	set @lungime = LEN(@mail)

	declare @contor int
	set @contor = 13

	declare @substrin varchar(MAX)
	declare @car char

	if not SUBSTRING(@mail, 1, 12) like 'https://www.'
			return 0
	
	while @contor <= @lungime
	begin
		if not SUBSTRING(@mail, @contor, 1) like '%[a-zA-Z_0-9@\.]'
			return 0

		set @contor = @contor + 1
	end
	return 1
END
