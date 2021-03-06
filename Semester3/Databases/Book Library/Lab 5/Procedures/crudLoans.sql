USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[crudLoans]    Script Date: 1/17/2018 5:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[crudLoans] 
	@what varchar(MAX),
	@bid varchar(15),
	@cid varchar(max),
	@loanDate varchar(max),
	@dueDate varchar(max),
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

	if dbo.checkFormatNumber(@bid) = 0
	begin
		print 'BId is not a number'
		set @res = 0
	end

	if dbo.checkFormatNumber(@cid) = 0
	begin
		print 'CId is not a number'
		set @res = 0
	end

	if dbo.checkFormatDate(@loanDate) = 0
	begin
		print 'Loan Date invalid'
		set @res = 0
	end

	if dbo.checkFormatDate(@dueDate) = 0
	begin
		print 'Due Date invalid'
		set @res = 0
	end

	

	--execute command

	if @RES = 1
	begin
		if @what = 'delete'
		begin
			delete from Loans
			where BId = cast(@bid as int) and CId = cast(@cid as int)
			print 'Delete complet'
		end
		else if @what = 'insert'
		begin
			if not exists (select * from dbo.Books where BId = cast(@bid as int))
			begin
				print 'The action cannot be performed because the Bid does not exist'
				return
			end

			if not exists (select * from dbo.Clients where CId = cast(@cid as int))
			begin
				print 'The action cannot be performed because the Cid does not exist'
				return
			end

			if exists (select * from dbo.Loans where CId = cast(@cid as int) and BId = cast(@bid as int))
			begin
				print 'The action cannot be performed because the Cid and BId already in Loans'
				return
			end

			insert into Loans values(cast(@bid as int), cast(@cid as int), @loanDate, @dueDate, @mentions)
			print 'Insert complet'
		end
		else if @what = 'update'
		begin
			if @bid is null or @cid is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.Books where BId = cast(@bid as int))
			begin
				print 'The action cannot be performed because the Bid does not exist'
				return
			end

			if not exists (select * from dbo.Clients where CId = cast(@cid as int))
			begin
				print 'The action cannot be performed because the Cid does not exist'
				return
			end
			
			update Loans
			set LoanDate = @loanDate, DueDate = @dueDate, Mentions = @mentions
			where BId = cast(@bid as int) and CId = cast(@cid as int)

			print 'Update complet'
		end
		else if @what = 'select'
		begin
			select * from Loans
			where LoanDate = @loanDate
			
			print 'Select complet'
		end
		else 
			print 'Please insert a correct command!'
	end
END