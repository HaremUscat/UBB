USE [Book Library]
GO
/****** Object:  UserDefinedFunction [dbo].[checkFormatPhone]    Script Date: 1/17/2018 6:06:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[checkFormatPhone]
(
	-- Add the parameters for the function here
	@number varchar(MAX)
)
RETURNS BIT
AS
BEGIN
	IF @number IS NULL
		RETURN 0
	IF LTRIM(@number) = ''
		return 0

	declare @lungime int
	set @lungime = LEN(@number)

	declare @contor int
	set @contor = 3

	declare @substrin varchar(MAX)
	declare @car char

	if not SUBSTRING(@number, 1, 2) like '07%'
		return 0

	while @contor <= @lungime
	begin
		select @car = SUBSTRING(@number, @contor, 1)
		if ISNUMERIC(@car) != 1
		begin
			--printn 'nu e digit\n';
			return 0
		end

		set @contor = @contor + 1
	end
	return 1

END
