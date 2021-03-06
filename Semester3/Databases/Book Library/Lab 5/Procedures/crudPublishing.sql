USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[crudPublishing]    Script Date: 1/17/2018 5:59:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[crudPublishing] 
	@what varchar(MAX),
	@id varchar(15),
	@publishingName varchar(max),
	@address varchar(max),
	@phone varchar(max),
	@email varchar(max),
	@website varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--Verify data

	DECLARE @RES BIT = 1
	DECLARE @comm varchar(250)

	if dbo.checkFormatNumber(@id) = 0
	begin
		print 'Id is not a number'
		set @res = 0
	end

	if dbo.checkFormatWebsite(@website) = 0
	begin
		print 'Website invalid'
		set @res = 0
	end

	if dbo.checkFormatName(@publishingName) = 0
	begin
		print 'Publishing Name invalid'
		set @res = 0
	end

	if dbo.checkFormatAddress(@address) = 0
	begin
		print 'Address invalid'
		set @res = 0
	end

	if dbo.checkFormatPhone(@phone) = 0
	begin
		print 'Phone is invalid'
		set @res = 0
	end

	if dbo.checkFormatMail(@email) = 0
	begin
		print 'Mail is invalid'
		set @res = 0
	end

	--execute command

	if @RES = 1
	begin
		if @what = 'delete'
		begin
			if not exists (select * from dbo.Publishing where PId = cast(@id as INT))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end

			if not exists (select * from dbo.Books where PId = cast(@id as INT))
			begin
				print 'The action cannot be performed because the PId is in Books'
				return
			end

			delete from Publishing
			where PId = cast(@id as INT)
			print 'Delete complet'
		end
		else if @what = 'insert'
		begin
			insert into Publishing values(@publishingName, @address, @phone, @email, @website)
			print 'Insert complet'
		end
		else if @what = 'update'
		begin
			if @id is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.Publishing where PId = cast(@id as INT))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			
			update Publishing
			set PublishingName = @publishingName, Adress = @address, Phone = @phone, Email = @email, Website =  @website
			where PId = cast(@id as INT)

			print 'Update complet'
		end
		else if @what = 'select'
		begin
			select * from Publishing
			where PublishingName = @publishingName
			
			print 'Select complet'
		end
		else 
			print 'Please insert a correct command!'
	end
END