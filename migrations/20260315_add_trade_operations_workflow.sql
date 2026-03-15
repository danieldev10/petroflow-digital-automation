SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    IF OBJECT_ID(N'dbo.trade_operation_requests', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.trade_operation_requests (
            id INT IDENTITY(1,1) PRIMARY KEY,
            request_reference NVARCHAR(64) NOT NULL,
            company_id INT NOT NULL,
            service_family NVARCHAR(100) NOT NULL,
            service_type NVARCHAR(100) NOT NULL,
            status NVARCHAR(50) NOT NULL
                CONSTRAINT DF_trade_operation_requests_status DEFAULT N'Submitted',
            goods_description NVARCHAR(MAX) NOT NULL,
            cargo_category NVARCHAR(255) NULL,
            origin_location NVARCHAR(255) NOT NULL,
            destination_location NVARCHAR(255) NOT NULL,
            quantity_value DECIMAL(18, 2) NULL,
            quantity_unit NVARCHAR(100) NULL,
            weight_kg DECIMAL(18, 2) NULL,
            container_count INT NULL,
            shipment_reference NVARCHAR(255) NULL,
            customs_reference NVARCHAR(255) NULL,
            operation_summary NVARCHAR(MAX) NOT NULL,
            requested_completion_date DATE NULL,
            submitted_by_user_id INT NOT NULL,
            submitted_at DATETIME2 NOT NULL
                CONSTRAINT DF_trade_operation_requests_submitted_at DEFAULT SYSDATETIME(),
            reviewed_at DATETIME2 NULL,
            reviewed_by_user_id INT NULL,
            returned_at DATETIME2 NULL,
            returned_by_user_id INT NULL,
            resubmitted_at DATETIME2 NULL,
            approved_at DATETIME2 NULL,
            rejected_at DATETIME2 NULL,
            rejected_by_user_id INT NULL,
            query_note NVARCHAR(MAX) NULL,
            rejection_reason NVARCHAR(MAX) NULL,
            created_at DATETIME2 NOT NULL
                CONSTRAINT DF_trade_operation_requests_created_at DEFAULT SYSDATETIME(),
            updated_at DATETIME2 NOT NULL
                CONSTRAINT DF_trade_operation_requests_updated_at DEFAULT SYSDATETIME(),
            CONSTRAINT UQ_trade_operation_requests_reference UNIQUE (request_reference),
            CONSTRAINT FK_trade_operation_requests_company FOREIGN KEY (company_id)
                REFERENCES dbo.companies(id),
            CONSTRAINT FK_trade_operation_requests_submitted_by_user FOREIGN KEY (submitted_by_user_id)
                REFERENCES dbo.users(id),
            CONSTRAINT FK_trade_operation_requests_reviewed_by_user FOREIGN KEY (reviewed_by_user_id)
                REFERENCES dbo.users(id),
            CONSTRAINT FK_trade_operation_requests_returned_by_user FOREIGN KEY (returned_by_user_id)
                REFERENCES dbo.users(id),
            CONSTRAINT FK_trade_operation_requests_rejected_by_user FOREIGN KEY (rejected_by_user_id)
                REFERENCES dbo.users(id),
            CONSTRAINT CK_trade_operation_requests_service_family CHECK (
                service_family IN (
                    N'inbound_cargo_movement',
                    N'cargo_handling_customs_control',
                    N'outbound_release',
                    N'transfers_temporary_movement',
                    N'processing_value_addition'
                )
            ),
            CONSTRAINT CK_trade_operation_requests_service_type CHECK (
                service_type IN (
                    N'sea_freight',
                    N'air_freight',
                    N'road_import',
                    N'examination_assessment',
                    N'export_by_sea',
                    N'export_by_air',
                    N'transfer_between_licensees',
                    N'temporary_movement',
                    N'processing_value_addition'
                )
            ),
            CONSTRAINT CK_trade_operation_requests_status CHECK (
                status IN (
                    N'Submitted',
                    N'Returned',
                    N'Approved',
                    N'Rejected'
                )
            )
        );
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM sys.indexes
        WHERE name = N'IX_trade_operation_requests_company_id'
          AND object_id = OBJECT_ID(N'dbo.trade_operation_requests')
    )
    BEGIN
        CREATE INDEX IX_trade_operation_requests_company_id
            ON dbo.trade_operation_requests(company_id);
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM sys.indexes
        WHERE name = N'IX_trade_operation_requests_status'
          AND object_id = OBJECT_ID(N'dbo.trade_operation_requests')
    )
    BEGIN
        CREATE INDEX IX_trade_operation_requests_status
            ON dbo.trade_operation_requests(status, submitted_at, id);
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM sys.indexes
        WHERE name = N'IX_trade_operation_requests_submitted_by_user_id'
          AND object_id = OBJECT_ID(N'dbo.trade_operation_requests')
    )
    BEGIN
        CREATE INDEX IX_trade_operation_requests_submitted_by_user_id
            ON dbo.trade_operation_requests(submitted_by_user_id, submitted_at, id);
    END;

    IF OBJECT_ID(N'dbo.trade_operation_request_documents', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.trade_operation_request_documents (
            id INT IDENTITY(1,1) PRIMARY KEY,
            request_id INT NOT NULL,
            document_type NVARCHAR(100) NOT NULL,
            file_name NVARCHAR(255) NOT NULL,
            created_at DATETIME2 NOT NULL
                CONSTRAINT DF_trade_operation_request_documents_created_at DEFAULT SYSDATETIME(),
            updated_at DATETIME2 NOT NULL
                CONSTRAINT DF_trade_operation_request_documents_updated_at DEFAULT SYSDATETIME(),
            CONSTRAINT FK_trade_operation_request_documents_request FOREIGN KEY (request_id)
                REFERENCES dbo.trade_operation_requests(id),
            CONSTRAINT CK_trade_operation_request_documents_type CHECK (
                document_type IN (
                    N'commercial_invoice',
                    N'bill_of_lading',
                    N'bill_of_lading_or_airway_bill',
                    N'packing_list',
                    N'attested_invoice_c16',
                    N'airway_bill',
                    N'waybill',
                    N'c16_invoice',
                    N'form_m',
                    N'paar',
                    N'declaration_form',
                    N'transfer_approval',
                    N'duty_payment_receipt',
                    N'export_declaration_form',
                    N'customs_approval',
                    N'free_zone_bond',
                    N'free_zone_waybill_or_shipping_doc',
                    N'duty_tariff_rebate_certificate',
                    N'transloading_or_transfer_approval',
                    N'minuted_customs_unstuffing_approval',
                    N'free_zone_waybill',
                    N'final_invoice',
                    N'free_zone_ccvo',
                    N'duty_rebate_spreadsheet'
                )
            )
        );
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM sys.indexes
        WHERE name = N'IX_trade_operation_request_documents_request_id'
          AND object_id = OBJECT_ID(N'dbo.trade_operation_request_documents')
    )
    BEGIN
        CREATE INDEX IX_trade_operation_request_documents_request_id
            ON dbo.trade_operation_request_documents(request_id, id);
    END;

    IF OBJECT_ID(N'dbo.trade_operation_request_events', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.trade_operation_request_events (
            id INT IDENTITY(1,1) PRIMARY KEY,
            request_id INT NOT NULL,
            event_type NVARCHAR(100) NOT NULL,
            actor_user_id INT NULL,
            actor_name NVARCHAR(255) NULL,
            actor_role NVARCHAR(255) NULL,
            from_status NVARCHAR(100) NULL,
            to_status NVARCHAR(100) NULL,
            note NVARCHAR(MAX) NULL,
            metadata_json NVARCHAR(MAX) NULL,
            created_at DATETIME2 NOT NULL
                CONSTRAINT DF_trade_operation_request_events_created_at DEFAULT SYSDATETIME(),
            CONSTRAINT FK_trade_operation_request_events_request FOREIGN KEY (request_id)
                REFERENCES dbo.trade_operation_requests(id),
            CONSTRAINT FK_trade_operation_request_events_actor FOREIGN KEY (actor_user_id)
                REFERENCES dbo.users(id),
            CONSTRAINT CK_trade_operation_request_events_type CHECK (
                event_type IN (
                    N'Submitted',
                    N'Resubmitted',
                    N'ReturnedForRevision',
                    N'Approved',
                    N'Rejected'
                )
            )
        );
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM sys.indexes
        WHERE name = N'IX_trade_operation_request_events_request_created'
          AND object_id = OBJECT_ID(N'dbo.trade_operation_request_events')
    )
    BEGIN
        CREATE INDEX IX_trade_operation_request_events_request_created
            ON dbo.trade_operation_request_events(request_id, created_at, id);
    END;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
