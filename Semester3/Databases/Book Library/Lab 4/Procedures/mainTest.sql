USE [Book Library]
GO
/****** Object:  StoredProcedure [dbo].[mainTest]    Script Date: 1/17/2018 6:25:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[mainTest]
	-- Add the parameters for the stored procedure here
	@nb_of_rows varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if ISNUMERIC(@nb_of_rows) != 1
	BEGIN
		print('Not a number')
		return 1 
	END
	
	--SET @nb_of_rows = cast(@nb_of_rows as INT)

	declare @all_start datetime
	set @all_start = GETDATE();

	declare @loans_delete_start datetime
	set @loans_delete_start = GETDATE()
	execute delete_rows @nb_of_rows, 'Loans'
	declare @loans_delete_end datetime
	set @loans_delete_end = GETDATE()

	declare @client_delete_start datetime
	set @client_delete_start = GETDATE()
	execute delete_rows @nb_of_rows, 'Clients'
	declare @client_delete_end datetime
	set @client_delete_end = GETDATE()

	declare @client_group_delete_start datetime
	set @client_group_delete_start = GETDATE()
	execute delete_rows @nb_of_rows, 'ClientGroups'
	declare @client_group_delete_end datetime
	set @client_group_delete_end = GETDATE()


	declare @client_group_insert_start datetime
	set @client_group_insert_start = GETDATE()
	execute insert_rows @nb_of_rows, 'ClientGroups'
	declare @client_group_insert_end datetime
	set @client_group_insert_end = GETDATE()

	declare @client_insert_start datetime
	set @client_insert_start = GETDATE()
	execute insert_rows @nb_of_rows, 'Clients'
	declare @client_insert_end datetime
	set @client_insert_end = GETDATE()

	declare @loans_insert_start datetime
	set @loans_insert_start = GETDATE()
	execute insert_rows @nb_of_rows, 'Loans'
	declare @loans_insert_end datetime
	set @loans_insert_end = GETDATE()

	declare @view_1_table_start datetime
	set @view_1_table_start = GETDATE()
	execute select_view 'View_1_table'
	declare @view_1_table_end datetime
	set @view_1_table_end = GETDATE()

	declare @view_2_tables_start datetime
	set @view_2_tables_start = GETDATE()
	execute select_view 'View_2_tables'
	declare @view_2_tables_end datetime
	set @view_2_tables_end = GETDATE()

	declare @view_2_tables_group_by_start datetime
	set @view_2_tables_group_by_start = GETDATE()
	execute select_view 'View_2_tables_group_by'
	declare @view_2_tables_group_by_end datetime
	set @view_2_tables_group_by_end = GETDATE()

	declare @all_stop datetime 
	set @all_stop = getdate() 

	declare @description varchar(100)
	set @description = 'TestRun' + convert(varchar(7), (select max(TestRunID) from TestRuns)) + 'delete, insert' + @nb_of_rows + 'rows, select all views'

	insert into TestRuns(Description, StartAt, EndAt)
	values(@description, @all_start, @all_stop);

	declare @lastTestRunID int; 
	set @lastTestRunID = (select max(TestRunID) from TestRuns);

	insert into TestRunTables
	values(@lastTestRunID, 1, @client_delete_start, @client_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 2, @loans_delete_start, @loans_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 3, @client_group_delete_start, @client_group_insert_end)

	insert into TestRunViews
	values(@lastTestRunID, 1, @view_1_table_start, @view_1_table_end)
	
	insert into TestRunViews
	values(@lastTestRunID, 2, @view_2_tables_start, @view_2_tables_end)

	insert into TestRunViews
	values(@lastTestRunID,3, @view_2_tables_group_by_start, @view_2_tables_group_by_end)



END
