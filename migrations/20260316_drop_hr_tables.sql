IF OBJECT_ID('dbo.attendance', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.attendance;
END;

IF OBJECT_ID('dbo.certifications', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.certifications;
END;

IF OBJECT_ID('dbo.employees', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.employees;
END;

IF OBJECT_ID('dbo.shifts', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.shifts;
END;
