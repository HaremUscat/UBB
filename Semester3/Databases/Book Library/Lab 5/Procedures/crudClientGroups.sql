USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[crudClientGroups]    Script Date: 1/17/2018 5:57:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[crudClientGroups] 
	-- Add the parameters for the stored procedure here
	@what varchar(MAX),
	@name varchar(50),
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

	if  dbo.checkFormatName(@name) = 0
	BEGIN
		PRINT 'THE ACTION CANNOT BE PERFORMED BECAUSE OF THE NAME FORMAT(len(type) > 3, contains only letters)'
		SET @res = 0
	END

	--execute command

	if @RES = 1
	begin
		if @what = 'delete'
		begin
			if exists (select * from dbo.Clients where CGId = @id)
			begin
				print 'The action cannot be performed because the id exists in Clients'
				return
			end
			delete from ClientGroups
			where CGId = cast(@id as int)
			print 'Delete complet'
		end
		else if @what = 'insert'
		begin
			insert into ClientGroups values(@name)
			print 'Insert complet'
		end
		else if @what = 'update'
		begin
			if @id is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.ClientGroups where CGId = @id)
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			
			update ClientGroups
			set ClientGroupName = @name
			where CGId = @id

			print 'Update complet'
		end
		else if @what = 'select'
		begin
			select * from ClientGroups
			where ClientGroupName = @name
			
			print 'Select complet'
		end
		else 
			print 'Please insert a correct command!'
	end
END