USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[crudLanguages]    Script Date: 1/17/2018 5:59:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[crudLanguages] 
	-- Add the parameters for the stored procedure here
	@what varchar(MAX),
	@denumire varchar(50),
	@id varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--Verify data

	DECLARE @RES BIT = 1
	DECLARE @comm varchar(250)

	if  dbo.checkFormatName(@denumire) = 0
	BEGIN
		PRINT 'THE ACTION CANNOT BE PERFORMED BECAUSE OF THE NAME FORMAT(len(type) > 3, contains only letters)'
		SET @res = 0
	END

	if dbo.checkFormatNumber(@id) = 0
	begin
		print 'Id must be a number'
		set @res = 0
	end

	--execute command

	if @RES = 1
	begin
		if @what = 'delete'
		begin
			if not exists (select * from dbo.Books where LId = cast(@id as INT))
			begin
				print 'The action cannot be performed because the id is in Books'
				return
			end

			delete from Languages
			where LanguageName = @denumire
			print 'Delete complet'
		end
		else if @what = 'insert'
		begin
			insert into Languages values(@denumire)
			print 'Insert complet'
		end
		else if @what = 'update'
		begin
			if @id is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.Languages where LId = cast(@id as INT))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			
			update Languages
			set LanguageName = @denumire
			where LId = cast(@id as INT)

			print 'Update complet'
		end
		else if @what = 'select'
		begin
			select * from Languages
			where LanguageName = @denumire
			
			print 'Select complet'
		end
		else 
			print 'Please insert a correct command!'
	end
END
