IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718210142_AddTestTable'
)
BEGIN
    CREATE TABLE [Tests] (
        [Id] uniqueidentifier NOT NULL,
        [Name] nvarchar(max) NULL,
        [TenantId] uniqueidentifier NOT NULL,
        [TemplateVersionId] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_Tests] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718210142_AddTestTable'
)
BEGIN
    CREATE INDEX [IX_Tests_TenantId] ON [Tests] ([TenantId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718210142_AddTestTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250718210142_AddTestTable', N'8.0.18');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718210543_MakeNameUniqueInTestTable'
)
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Tests]') AND [c].[name] = N'Name');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Tests] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Tests] ALTER COLUMN [Name] nvarchar(450) NULL;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718210543_MakeNameUniqueInTestTable'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Tests_Name_TenantId] ON [Tests] ([Name], [TenantId]) WHERE [Name] IS NOT NULL');
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718210543_MakeNameUniqueInTestTable'
)
BEGIN
    INSERT INTO Tests (Id, Name, TemplateVersionId, TenantId) 
                        VALUES (NEWID(), 'abc 1', NEWID(), NEWID()); 
                    
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718210543_MakeNameUniqueInTestTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250718210543_MakeNameUniqueInTestTable', N'8.0.18');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718211144_MakeNameTemplateUniqueInTests'
)
BEGIN
    INSERT INTO Tests (Id, Name, TemplateVersionId, TenantId) 
                        VALUES (NEWID(), 'abc 2', NEWID(), NEWID()); 
                    
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718211144_MakeNameTemplateUniqueInTests'
)
BEGIN
    DROP INDEX [IX_Tests_Name_TenantId] ON [Tests];
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718211144_MakeNameTemplateUniqueInTests'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Tests_Template_Name] ON [Tests] ([TemplateVersionId], [Name]) WHERE [Name] IS NOT NULL');
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718211144_MakeNameTemplateUniqueInTests'
)
BEGIN
    INSERT INTO Tests (Id, Name, TemplateVersionId, TenantId) 
                        VALUES (NEWID(), 'abc 3', NEWID(), NEWID()); 
                    
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250718211144_MakeNameTemplateUniqueInTests'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250718211144_MakeNameTemplateUniqueInTests', N'8.0.18');
END;
GO

COMMIT;
GO

