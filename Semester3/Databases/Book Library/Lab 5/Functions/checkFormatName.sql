USE [Book Library]
GO
/****** Object:  UserDefinedFunction [dbo].[checkFormatName]    Script Date: 1/17/2018 6:05:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[checkFormatName]
(
	-- Add the parameters for the function here
	@name varchar(50)
)
RETURNS BIT
AS
BEGIN
	-- Return the result of the function
	IF @name IS NULL
		RETURN 1
	IF LTRIM(@name) = ''
		return 0
	IF LEN(@name) < 3 
		RETURN 0

	declare @lungime int
	set @lungime = LEN(@name)

	declare @contor int
	set @contor = 1

	declare @substrin varchar(MAX)
	declare @car char

	while @contor <= @lungime
	begin
		if not SUBSTRING(@name, @contor, 1) like '%[a-zA-Z]'
			return 0

		set @contor = @contor + 1
	end

	RETURN 1

END
