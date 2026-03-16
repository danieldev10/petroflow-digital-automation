SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

MERGE dbo.users AS target
USING (
    VALUES
        (
            'admin@petroflow.com',
            '$2b$10$P5C0tCYjWkI17iHa/tjmwe7.5y4Epsm4wAS3K2Hlsvjwprfs5vXGe',
            'System Admin',
            'Admin',
            'HQ',
            0
        ),
        (
            'compliance@ogfza.gov',
            '$2b$10$.qK57Gxetu7RvaxgXy2JnePOgH7q.ECa1PKML8bPrpmo5VikelPGu',
            'Sarah Compliance',
            'Compliance',
            'Regulatory',
            0
        ),
        (
            'operations@ogfza.gov',
            '$2b$10$.qK57Gxetu7RvaxgXy2JnePOgH7q.ECa1PKML8bPrpmo5VikelPGu',
            'Victor Operations',
            'Operations',
            'Field Ops',
            0
        ),
        (
            'finance@ogfza.gov',
            '$2b$10$.qK57Gxetu7RvaxgXy2JnePOgH7q.ECa1PKML8bPrpmo5VikelPGu',
            'Florence Finance',
            'Finance',
            'Treasury',
            0
        ),
        (
            'contractor.alpha@ogfza.example.com',
            '$2b$10$.qK57Gxetu7RvaxgXy2JnePOgH7q.ECa1PKML8bPrpmo5VikelPGu',
            'Morgan Reed',
            'Contractor',
            'Onne',
            0
        ),
        (
            'contractor.beta@ogfza.example.com',
            '$2b$10$.qK57Gxetu7RvaxgXy2JnePOgH7q.ECa1PKML8bPrpmo5VikelPGu',
            'Jordan Cole',
            'Contractor',
            'Lagos',
            0
        ),
        (
            'contractor.gamma@ogfza.example.com',
            '$2b$10$.qK57Gxetu7RvaxgXy2JnePOgH7q.ECa1PKML8bPrpmo5VikelPGu',
            'Taylor Briggs',
            'Contractor',
            'Brass',
            0
        )
) AS source (email, password, full_name, role, operational_unit, must_change_password)
    ON target.email = source.email
WHEN MATCHED THEN
    UPDATE SET
        target.password = source.password,
        target.full_name = source.full_name,
        target.role = source.role,
        target.operational_unit = source.operational_unit,
        target.must_change_password = source.must_change_password,
        target.otp_code = NULL
WHEN NOT MATCHED THEN
    INSERT (
        email,
        password,
        full_name,
        role,
        operational_unit,
        must_change_password
    )
    VALUES (
        source.email,
        source.password,
        source.full_name,
        source.role,
        source.operational_unit,
        source.must_change_password
    );

COMMIT TRANSACTION;
