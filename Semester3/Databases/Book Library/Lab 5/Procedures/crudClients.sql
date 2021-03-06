USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[crudClients]    Script Date: 1/17/2018 5:59:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[crudClients] 
	@what varchar(MAX),
	@id varchar(15),
	@clientCode varchar(max),
	@firstName varchar(max),
	@secondName varchar(max),
	@cnp varchar(max),
	@ci_serie varchar(max),
	@ci varchar(max),
	@address varchar(max),
	@city varchar(max),
	@district varchar(max),
	@phone varchar(max),
	@email varchar(max),
	@registrationDate varchar(max),
	@cgid varchar(max),
	@active varchar(max),
	@mentions varchar(max)
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

	if dbo.checkFormatNumber(@clientCode) = 0
	begin
		print 'ClientCode is not a number'
		set @res = 0
	end

	if dbo.checkFormatName(@firstName) = 0
	begin
		print 'FirstName is invalid'
		set @res = 0
	end

	if dbo.checkFormatName(@secondName) = 0
	begin
		print 'SecondName is invalid'
		set @res = 0
	end

	if dbo.checkFormatCNP(@cnp) = 0
	begin
		print 'CNP is invalid'
		set @res = 0
	end

	if dbo.checkFormatNumber(@ci_serie) = 0
	begin
		print 'CI Serie is not a number'
		set @res = 0
	end
	
	if dbo.checkFormatName(@ci) = 0
	begin
		print 'CI is invalid'
		set @res = 0
	end

	if dbo.checkFormatName(@city) = 0
	begin
		print 'City is invalid'
		set @res = 0
	end

	if dbo.checkFormatName(@district) = 0
	begin
		print 'District is invalid'
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

	if dbo.checkFormatDate(@registrationDate) = 0
	begin
		print 'Registration Date is invalid'
		set @res = 0
	end

	if dbo.checkFormatNumber(@active) = 0 and (not @active like '%[01]')
	begin
		print 'Active has to be 0 or 1'
		set @res = 0
	end

	if dbo.checkFormatNumber(@cgid) = 0
	begin
		print 'Client Group ID is not a number'
		set @res = 0
	end

	--execute command

	if @RES = 1
	begin
		if @what = 'delete'
		begin
			if exists (select * from dbo.Loans where CId = cast(@id as int))
			begin
				print 'The action cannot be performed because the id exists in Loans'
				return
			end

			delete from Clients
			where CId = @id
			print 'Delete complet'
		end
		else if @what = 'insert'
		begin
			insert into Clients values(@clientCode, @firstName, @secondName, @cnp, @ci_serie, @ci, @address, @city, @district, @phone, @email, @registrationDate, @cgid, @active, @mentions)
			print 'Insert complet'
		end
		else if @what = 'update'
		begin
			if @id is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.Clients where CId = cast(@id as int))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			
			update Clients
			set ClientCode = @clientCode, FirstName = @firstName, SecondName = @secondName, CNP = @cnp, CI_Serie =  @ci_serie, CI = @ci, Adress = @address, City = @city, District = @district, Phone = @phone,Email = @email, RegistrationDate = @registrationDate, CGId = @cgid, Active = @active, Mentions = @mentions
			where CGId = cast(@id as int)

			print 'Update complet'
		end
		else if @what = 'select'
		begin
			select * from Clients
			where FirstName = @firstName
			
			print 'Select complet'
		end
		else 
			print 'Please insert a correct command!'
	end
END