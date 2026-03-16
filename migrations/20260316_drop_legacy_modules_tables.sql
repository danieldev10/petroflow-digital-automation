IF OBJECT_ID('dbo.contractor_documents', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.contractor_documents;
END;

IF OBJECT_ID('dbo.work_orders', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.work_orders;
END;

IF OBJECT_ID('dbo.contractors', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.contractors;
END;

IF OBJECT_ID('dbo.team_members', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.team_members;
END;

IF OBJECT_ID('dbo.permits', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.permits;
END;

IF OBJECT_ID('dbo.compliance', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.compliance;
END;
