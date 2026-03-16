-- Refreshed from the active SQL Server database on 2026-03-16.

CREATE TABLE dbo.users (
  id INT IDENTITY(1,1) PRIMARY KEY,
  email NVARCHAR(255) NOT NULL,
  password NVARCHAR(255) NOT NULL,
  full_name NVARCHAR(255) NOT NULL,
  role NVARCHAR(100) NOT NULL,
  operational_unit NVARCHAR(255) NULL,
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  must_change_password BIT NOT NULL DEFAULT 0,
  otp_code NVARCHAR(50) NULL,
  CONSTRAINT [UQ__users__AB6E616402235D0A] UNIQUE (email)
);

CREATE TABLE dbo.company_applications (
  id INT IDENTITY(1,1) PRIMARY KEY,
  application_reference NVARCHAR(100) NOT NULL,
  company_name NVARCHAR(255) NULL,
  incorporation_type NVARCHAR(100) NULL,
  free_zone_location NVARCHAR(255) NULL,
  global_head_office_address NVARCHAR(MAX) NULL,
  global_phone_1 NVARCHAR(50) NULL,
  global_email NVARCHAR(255) NULL,
  global_phone_2 NVARCHAR(50) NULL,
  global_website NVARCHAR(255) NULL,
  nigeria_office_address NVARCHAR(MAX) NULL,
  nigeria_phone_1 NVARCHAR(50) NULL,
  nigeria_email NVARCHAR(255) NULL,
  nigeria_phone_2 NVARCHAR(50) NULL,
  nigeria_website NVARCHAR(255) NULL,
  primary_contact_name NVARCHAR(255) NULL,
  primary_contact_designation NVARCHAR(255) NULL,
  primary_contact_phone NVARCHAR(50) NULL,
  primary_contact_email NVARCHAR(255) NULL,
  secondary_contact_name NVARCHAR(255) NULL,
  secondary_contact_designation NVARCHAR(255) NULL,
  secondary_contact_phone NVARCHAR(50) NULL,
  secondary_contact_email NVARCHAR(255) NULL,
  present_business_operations NVARCHAR(MAX) NULL,
  dpr_registration_number NVARCHAR(255) NULL,
  activity_description NVARCHAR(MAX) NULL,
  countries_of_operation_west_africa NVARCHAR(MAX) NULL,
  proposed_business_activity NVARCHAR(MAX) NULL,
  project_summary_attachment_url NVARCHAR(MAX) NULL,
  undeveloped_land_sqm DECIMAL(18,2) NULL,
  developed_land_sqm DECIMAL(18,2) NULL,
  concrete_stacking_area_sqm DECIMAL(18,2) NULL,
  warehouse_space_sqm DECIMAL(18,2) NULL,
  factory_premises_sqm DECIMAL(18,2) NULL,
  office_accommodation_sqm DECIMAL(18,2) NULL,
  equipment_requirement NVARCHAR(MAX) NULL,
  residential_accommodation_personnel_count INT NULL,
  imports_summary NVARCHAR(MAX) NULL,
  exports_summary NVARCHAR(MAX) NULL,
  proposed_commencement_date DATE NULL,
  declaration_name NVARCHAR(255) NULL,
  declaration_designation NVARCHAR(255) NULL,
  declaration_signature_date DATE NULL,
  company_seal_file_url NVARCHAR(MAX) NULL,
  status NVARCHAR(100) NOT NULL DEFAULT 'Draft',
  submitted_by_user_id INT NULL,
  reviewed_by_user_id INT NULL,
  approved_by_user_id INT NULL,
  submitted_at DATETIME2 NULL,
  reviewed_at DATETIME2 NULL,
  approved_at DATETIME2 NULL,
  returned_at DATETIME2 NULL,
  rejected_at DATETIME2 NULL,
  rejection_reason NVARCHAR(MAX) NULL,
  internal_company_profile NVARCHAR(MAX) NULL,
  internal_activity_1 NVARCHAR(255) NULL,
  internal_activity_2 NVARCHAR(255) NULL,
  internal_activity_3 NVARCHAR(255) NULL,
  internal_activity_4 NVARCHAR(255) NULL,
  internal_activity_5 NVARCHAR(255) NULL,
  internal_license_category NVARCHAR(255) NULL,
  internal_free_zone_management_comment NVARCHAR(MAX) NULL,
  internal_facility_leased NVARCHAR(MAX) NULL,
  internal_project_recommendation BIT NULL,
  internal_project_endorsement_comment NVARCHAR(MAX) NULL,
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  updated_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  returned_by_user_id INT NULL,
  resubmitted_at DATETIME2 NULL,
  query_note NVARCHAR(MAX) NULL,
  requested_license_type NVARCHAR(100) NULL,
  estimated_fee_usd DECIMAL(18,2) NULL,
  approved_license_type NVARCHAR(100) NULL,
  approved_fee_usd DECIMAL(18,2) NULL,
  payment_status NVARCHAR(100) NULL,
  payment_reference NVARCHAR(255) NULL,
  payment_confirmed_at DATETIME2 NULL,
  payment_confirmed_by_user_id INT NULL,
  payment_submitted_at DATETIME2 NULL,
  payment_submitted_by_user_id INT NULL,
  CONSTRAINT FK_company_applications_submitted_by_user FOREIGN KEY (submitted_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_applications_reviewed_by_user FOREIGN KEY (reviewed_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_applications_approved_by_user FOREIGN KEY (approved_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_applications_returned_by_user FOREIGN KEY (returned_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_applications_payment_confirmed_by_user FOREIGN KEY (payment_confirmed_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_applications_payment_submitted_by_user FOREIGN KEY (payment_submitted_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT CK_company_applications_incorporation_type CHECK (
    incorporation_type IS NULL OR incorporation_type IN (
      'Nigerian registered company',
      'Free Zone incorporation',
      'Offshore/overseas incorporation'
    )
  ),
  CONSTRAINT CK_company_applications_free_zone_location CHECK (
    free_zone_location IS NULL OR free_zone_location IN (
      'Brass Oil & Gas Free Zone Area, Bayelsa State',
      'Eko Support Free Zone Area, Lagos State',
      'Liberty Oil & Gas Free Zone Area, Akwa Ibom State',
      'Onne Oil & Gas Free Zone Area, Rivers State',
      'Warri Oil & Gas Free Zone Area, Delta State',
      'Bestaf Maritime Industrial Free Zone, Lagos State'
    )
  ),
  CONSTRAINT CK_company_applications_status CHECK (
    status IN (
      'Draft',
      'Submitted',
      'Under Review',
      'Awaiting Admin Approval',
      'Returned',
      'Approved Pending Payment',
      'Payment Submitted',
      'Licence Issued',
      'Approved',
      'Rejected'
    )
  ),
  CONSTRAINT CK_company_applications_requested_license_type CHECK (
    requested_license_type IS NULL OR requested_license_type IN (
      'Free Zone Service Licence',
      'Free Zone Enterprise Licence',
      'Free Zone Enterprise - Special Activity Licence',
      'Free Zone Developer Licence'
    )
  ),
  CONSTRAINT CK_company_applications_approved_license_type CHECK (
    approved_license_type IS NULL OR approved_license_type IN (
      'Free Zone Service Licence',
      'Free Zone Enterprise Licence',
      'Free Zone Enterprise - Special Activity Licence',
      'Free Zone Developer Licence'
    )
  ),
  CONSTRAINT CK_company_applications_payment_status CHECK (
    payment_status IS NULL OR payment_status IN (
      'Awaiting Contractor Payment',
      'Payment Submitted',
      'Paid'
    )
  )
);

CREATE TABLE dbo.companies (
  id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(255) NOT NULL,
  license_no NVARCHAR(255) NULL,
  tin NVARCHAR(255) NULL,
  sector NVARCHAR(255) NULL,
  incorporation_type NVARCHAR(255) NULL,
  status NVARCHAR(100) NOT NULL DEFAULT 'Active',
  approved_date DATE NULL,
  lease_info NVARCHAR(MAX) NULL,
  representative_email NVARCHAR(255) NULL,
  free_zone_location NVARCHAR(255) NULL,
  approved_application_id INT NULL,
  license_type NVARCHAR(100) NULL,
  CONSTRAINT FK_companies_approved_application FOREIGN KEY (approved_application_id) REFERENCES dbo.company_applications(id),
  CONSTRAINT CK_companies_license_type CHECK (
    license_type IS NULL OR license_type IN (
      'Free Zone Service Licence',
      'Free Zone Enterprise Licence',
      'Free Zone Enterprise - Special Activity Licence',
      'Free Zone Developer Licence'
    )
  )
);

CREATE TABLE dbo.company_application_documents (
  id INT IDENTITY(1,1) PRIMARY KEY,
  application_id INT NOT NULL,
  document_type NVARCHAR(100) NOT NULL,
  file_name NVARCHAR(255) NOT NULL,
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  updated_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  CONSTRAINT FK_company_application_documents_application FOREIGN KEY (application_id) REFERENCES dbo.company_applications(id),
  CONSTRAINT CK_company_application_documents_type CHECK (
    document_type IN (
      'dpr_certificate',
      'certificate_of_incorporation',
      'certificate_or_notarized_overseas_incorporation',
      'memorandum_and_articles_of_association',
      'company_brochure_or_profile',
      'environmental_impact_assessment_report',
      'company_contact_details',
      'feasibility_study_business_plan',
      'financial_and_personnel_profile',
      'sources_of_funding',
      'audited_accounts_last_three_years',
      'facility_lease_confirmation',
      'oil_and_gas_affidavit',
      'pre_incorporation_meeting_with_promoters',
      'share_capital_and_stamp_duty_evidence',
      'financial_profile_fdi_and_personnel_profile',
      'project_summary',
      'company_stamp_or_seal',
      'notarized_overseas_incorporation'
    )
  )
);

CREATE TABLE dbo.company_application_events (
  id INT IDENTITY(1,1) PRIMARY KEY,
  application_id INT NOT NULL,
  event_type NVARCHAR(100) NOT NULL,
  actor_user_id INT NULL,
  actor_name NVARCHAR(255) NULL,
  actor_role NVARCHAR(255) NULL,
  from_status NVARCHAR(100) NULL,
  to_status NVARCHAR(100) NULL,
  note NVARCHAR(MAX) NULL,
  metadata_json NVARCHAR(MAX) NULL,
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  CONSTRAINT FK_company_application_events_application FOREIGN KEY (application_id) REFERENCES dbo.company_applications(id),
  CONSTRAINT FK_company_application_events_actor FOREIGN KEY (actor_user_id) REFERENCES dbo.users(id),
  CONSTRAINT CK_company_application_events_type CHECK (
    event_type IN (
      'Submitted',
      'Resubmitted',
      'ForwardedToAdmin',
      'PaymentSubmitted',
      'ReturnedForRevision',
      'RejectedByCompliance',
      'RejectedByAdmin',
      'ApprovedByAdmin',
      'LicenseIssued'
    )
  )
);

CREATE TABLE dbo.company_compliance_cases (
  id INT IDENTITY(1,1) PRIMARY KEY,
  company_id INT NOT NULL,
  case_type NVARCHAR(50) NOT NULL,
  title NVARCHAR(255) NOT NULL,
  document_type NVARCHAR(255) NULL,
  severity NVARCHAR(100) NULL,
  request_note NVARCHAR(MAX) NOT NULL,
  status NVARCHAR(100) NOT NULL DEFAULT 'Open',
  due_date DATE NULL,
  requested_by_user_id INT NULL,
  requested_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  contractor_response_note NVARCHAR(MAX) NULL,
  contractor_response_file_name NVARCHAR(255) NULL,
  contractor_response_submitted_at DATETIME2 NULL,
  contractor_response_submitted_by_user_id INT NULL,
  review_note NVARCHAR(MAX) NULL,
  returned_at DATETIME2 NULL,
  returned_by_user_id INT NULL,
  resolved_at DATETIME2 NULL,
  resolved_by_user_id INT NULL,
  closed_at DATETIME2 NULL,
  closed_by_user_id INT NULL,
  updated_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  legacy_compliance_id INT NULL,
  CONSTRAINT FK_company_compliance_cases_company FOREIGN KEY (company_id) REFERENCES dbo.companies(id),
  CONSTRAINT FK_company_compliance_cases_requested_by FOREIGN KEY (requested_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_compliance_cases_contractor_response_by FOREIGN KEY (contractor_response_submitted_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_compliance_cases_returned_by FOREIGN KEY (returned_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_compliance_cases_resolved_by FOREIGN KEY (resolved_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_company_compliance_cases_closed_by FOREIGN KEY (closed_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT CK_company_compliance_cases_type CHECK (case_type IN ('DocumentUpdate', 'AuditFinding')),
  CONSTRAINT CK_company_compliance_cases_status CHECK (status IN ('Open', 'Response Submitted', 'Returned', 'Resolved', 'Closed'))
);

CREATE TABLE dbo.company_compliance_case_events (
  id INT IDENTITY(1,1) PRIMARY KEY,
  case_id INT NOT NULL,
  event_type NVARCHAR(100) NOT NULL,
  actor_user_id INT NULL,
  actor_name NVARCHAR(255) NULL,
  actor_role NVARCHAR(100) NULL,
  from_status NVARCHAR(100) NULL,
  to_status NVARCHAR(100) NULL,
  note NVARCHAR(MAX) NULL,
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  CONSTRAINT FK_company_compliance_case_events_case FOREIGN KEY (case_id) REFERENCES dbo.company_compliance_cases(id),
  CONSTRAINT FK_company_compliance_case_events_actor FOREIGN KEY (actor_user_id) REFERENCES dbo.users(id)
);

CREATE TABLE dbo.assets (
  id INT IDENTITY(1,1) PRIMARY KEY,
  asset_name NVARCHAR(255) NULL,
  type NVARCHAR(100) NULL,
  location_coordinates NVARCHAR(255) NULL,
  status NVARCHAR(100) NOT NULL DEFAULT 'Operational',
  maintenance_date DATE NULL,
  company_id INT NULL,
  CONSTRAINT FK_assets_company_id FOREIGN KEY (company_id) REFERENCES dbo.companies(id)
);

CREATE TABLE dbo.revenue (
  id INT IDENTITY(1,1) PRIMARY KEY,
  company_id INT NULL,
  amount DECIMAL(18,2) NULL,
  description NVARCHAR(MAX) NULL,
  payment_date DATE NULL,
  status NVARCHAR(100) NOT NULL DEFAULT 'Paid',
  invoice_no NVARCHAR(255) NULL,
  CONSTRAINT FK_revenue_company FOREIGN KEY (company_id) REFERENCES dbo.companies(id)
);

CREATE TABLE dbo.operations (
  id INT IDENTITY(1,1) PRIMARY KEY,
  field_name NVARCHAR(255) NOT NULL,
  production_volume DECIMAL(18,2) NOT NULL DEFAULT 0,
  downtime_hours DECIMAL(18,2) NOT NULL DEFAULT 0,
  report_date DATE NULL,
  asset_id INT NULL,
  notes NVARCHAR(MAX) NULL,
  CONSTRAINT FK_operations_asset_id FOREIGN KEY (asset_id) REFERENCES dbo.assets(id)
);

CREATE TABLE dbo.incidents (
  id INT IDENTITY(1,1) PRIMARY KEY,
  company_name NVARCHAR(255) NULL,
  incident_type NVARCHAR(255) NULL,
  severity NVARCHAR(100) NULL,
  description NVARCHAR(MAX) NULL,
  reported_by NVARCHAR(255) NULL,
  status NVARCHAR(100) NOT NULL DEFAULT 'Open',
  reported_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  company_id INT NULL,
  reported_by_user_id INT NULL,
  follow_up_note NVARCHAR(MAX) NULL,
  follow_up_submitted_at DATETIME2 NULL,
  follow_up_submitted_by_user_id INT NULL,
  resolved_at DATETIME2 NULL,
  resolved_by_user_id INT NULL,
  closed_at DATETIME2 NULL,
  closed_by_user_id INT NULL,
  updated_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  asset_id INT NULL,
  CONSTRAINT FK_incidents_company_id FOREIGN KEY (company_id) REFERENCES dbo.companies(id),
  CONSTRAINT FK_incidents_asset_id FOREIGN KEY (asset_id) REFERENCES dbo.assets(id),
  CONSTRAINT FK_incidents_reported_by_user FOREIGN KEY (reported_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_incidents_follow_up_user FOREIGN KEY (follow_up_submitted_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_incidents_resolved_by_user FOREIGN KEY (resolved_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_incidents_closed_by_user FOREIGN KEY (closed_by_user_id) REFERENCES dbo.users(id)
);

CREATE TABLE dbo.incident_events (
  id INT IDENTITY(1,1) PRIMARY KEY,
  incident_id INT NOT NULL,
  event_type NVARCHAR(100) NOT NULL,
  actor_user_id INT NULL,
  actor_name NVARCHAR(255) NULL,
  actor_role NVARCHAR(100) NULL,
  from_status NVARCHAR(100) NULL,
  to_status NVARCHAR(100) NULL,
  note NVARCHAR(MAX) NULL,
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  CONSTRAINT FK_incident_events_incident FOREIGN KEY (incident_id) REFERENCES dbo.incidents(id),
  CONSTRAINT FK_incident_events_actor FOREIGN KEY (actor_user_id) REFERENCES dbo.users(id)
);

CREATE TABLE dbo.equipment_maintenance (
  id INT IDENTITY(1,1) PRIMARY KEY,
  asset_id INT NULL,
  maintenance_type NVARCHAR(255) NULL,
  description NVARCHAR(MAX) NULL,
  technician NVARCHAR(255) NULL,
  cost DECIMAL(18,2) NOT NULL DEFAULT 0,
  maintenance_date DATE NULL,
  next_due_date DATE NULL,
  status NVARCHAR(100) NOT NULL DEFAULT 'Completed',
  CONSTRAINT FK_equipment_maintenance_asset FOREIGN KEY (asset_id) REFERENCES dbo.assets(id)
);

CREATE TABLE dbo.trade_operation_requests (
  id INT IDENTITY(1,1) PRIMARY KEY,
  request_reference NVARCHAR(64) NOT NULL,
  company_id INT NOT NULL,
  service_family NVARCHAR(100) NOT NULL,
  service_type NVARCHAR(100) NOT NULL,
  status NVARCHAR(50) NOT NULL DEFAULT N'Submitted',
  goods_description NVARCHAR(MAX) NOT NULL,
  cargo_category NVARCHAR(255) NULL,
  origin_location NVARCHAR(255) NOT NULL,
  destination_location NVARCHAR(255) NOT NULL,
  quantity_value DECIMAL(18,2) NULL,
  quantity_unit NVARCHAR(100) NULL,
  weight_kg DECIMAL(18,2) NULL,
  container_count INT NULL,
  shipment_reference NVARCHAR(255) NULL,
  customs_reference NVARCHAR(255) NULL,
  operation_summary NVARCHAR(MAX) NOT NULL,
  requested_completion_date DATE NULL,
  submitted_by_user_id INT NOT NULL,
  submitted_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
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
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  updated_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  CONSTRAINT FK_trade_operation_requests_company FOREIGN KEY (company_id) REFERENCES dbo.companies(id),
  CONSTRAINT FK_trade_operation_requests_submitted_by_user FOREIGN KEY (submitted_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_trade_operation_requests_reviewed_by_user FOREIGN KEY (reviewed_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_trade_operation_requests_returned_by_user FOREIGN KEY (returned_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT FK_trade_operation_requests_rejected_by_user FOREIGN KEY (rejected_by_user_id) REFERENCES dbo.users(id),
  CONSTRAINT CK_trade_operation_requests_service_family CHECK (
    service_family IN (
      'inbound_cargo_movement',
      'cargo_handling_customs_control',
      'outbound_release',
      'transfers_temporary_movement',
      'processing_value_addition'
    )
  ),
  CONSTRAINT CK_trade_operation_requests_service_type CHECK (
    service_type IN (
      'sea_freight',
      'air_freight',
      'road_import',
      'examination_assessment',
      'export_by_sea',
      'export_by_air',
      'transfer_between_licensees',
      'temporary_movement',
      'processing_value_addition'
    )
  ),
  CONSTRAINT CK_trade_operation_requests_status CHECK (
    status IN ('Submitted', 'Returned', 'Approved', 'Rejected')
  )
);

CREATE TABLE dbo.trade_operation_request_documents (
  id INT IDENTITY(1,1) PRIMARY KEY,
  request_id INT NOT NULL,
  document_type NVARCHAR(100) NOT NULL,
  file_name NVARCHAR(255) NOT NULL,
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  updated_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  CONSTRAINT FK_trade_operation_request_documents_request FOREIGN KEY (request_id) REFERENCES dbo.trade_operation_requests(id),
  CONSTRAINT CK_trade_operation_request_documents_type CHECK (
    document_type IN (
      'commercial_invoice',
      'bill_of_lading',
      'bill_of_lading_or_airway_bill',
      'packing_list',
      'attested_invoice_c16',
      'airway_bill',
      'waybill',
      'c16_invoice',
      'form_m',
      'paar',
      'declaration_form',
      'transfer_approval',
      'duty_payment_receipt',
      'export_declaration_form',
      'customs_approval',
      'free_zone_bond',
      'free_zone_waybill_or_shipping_doc',
      'duty_tariff_rebate_certificate',
      'transloading_or_transfer_approval',
      'minuted_customs_unstuffing_approval',
      'free_zone_waybill',
      'final_invoice',
      'free_zone_ccvo',
      'duty_rebate_spreadsheet'
    )
  )
);

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
  created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  CONSTRAINT FK_trade_operation_request_events_request FOREIGN KEY (request_id) REFERENCES dbo.trade_operation_requests(id),
  CONSTRAINT FK_trade_operation_request_events_actor FOREIGN KEY (actor_user_id) REFERENCES dbo.users(id),
  CONSTRAINT CK_trade_operation_request_events_type CHECK (
    event_type IN ('Submitted', 'Resubmitted', 'ReturnedForRevision', 'Approved', 'Rejected')
  )
);

CREATE UNIQUE INDEX UQ_company_applications_reference
  ON dbo.company_applications(application_reference);

CREATE INDEX IX_company_applications_status
  ON dbo.company_applications(status);

CREATE INDEX IX_company_applications_submitted_by_user_id
  ON dbo.company_applications(submitted_by_user_id);

CREATE INDEX IX_company_applications_returned_by_user_id
  ON dbo.company_applications(returned_by_user_id);

CREATE INDEX IX_company_applications_payment_submitted_by_user_id
  ON dbo.company_applications(payment_submitted_by_user_id);

CREATE INDEX IX_company_applications_payment_confirmed_by_user_id
  ON dbo.company_applications(payment_confirmed_by_user_id);

CREATE UNIQUE INDEX UX_companies_license_no_non_null
  ON dbo.companies(license_no)
  WHERE license_no IS NOT NULL;

CREATE UNIQUE INDEX UQ_companies_approved_application_id
  ON dbo.companies(approved_application_id)
  WHERE approved_application_id IS NOT NULL;

CREATE INDEX IX_company_application_documents_application_id
  ON dbo.company_application_documents(application_id, document_type);

CREATE UNIQUE INDEX UQ_company_application_documents_type
  ON dbo.company_application_documents(application_id, document_type);

CREATE INDEX IX_company_application_events_actor_user_id
  ON dbo.company_application_events(actor_user_id);

CREATE INDEX IX_company_application_events_application_created
  ON dbo.company_application_events(application_id, created_at, id);

CREATE INDEX IX_company_compliance_cases_company_status
  ON dbo.company_compliance_cases(company_id, status);

CREATE INDEX IX_company_compliance_cases_due_date
  ON dbo.company_compliance_cases(due_date);

CREATE UNIQUE INDEX UX_company_compliance_cases_legacy_compliance_id
  ON dbo.company_compliance_cases(legacy_compliance_id)
  WHERE legacy_compliance_id IS NOT NULL;

CREATE INDEX IX_company_compliance_case_events_case_id
  ON dbo.company_compliance_case_events(case_id, created_at);

CREATE INDEX IX_assets_company_id
  ON dbo.assets(company_id);

CREATE INDEX IX_operations_asset_id
  ON dbo.operations(asset_id);

CREATE INDEX IX_incidents_asset_id
  ON dbo.incidents(asset_id);

CREATE UNIQUE INDEX UQ_trade_operation_requests_reference
  ON dbo.trade_operation_requests(request_reference);

CREATE INDEX IX_trade_operation_requests_company_id
  ON dbo.trade_operation_requests(company_id);

CREATE INDEX IX_trade_operation_requests_status
  ON dbo.trade_operation_requests(status, submitted_at, id);

CREATE INDEX IX_trade_operation_requests_submitted_by_user_id
  ON dbo.trade_operation_requests(submitted_by_user_id, submitted_at, id);

CREATE INDEX IX_trade_operation_request_documents_request_id
  ON dbo.trade_operation_request_documents(request_id, id);

CREATE INDEX IX_trade_operation_request_events_request_created
  ON dbo.trade_operation_request_events(request_id, created_at, id);

GO

CREATE TRIGGER dbo.TR_companies_assign_license_no
ON dbo.companies
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @companyId INT;
  DECLARE @candidate NVARCHAR(20);
  DECLARE @attempts INT;

  DECLARE pending CURSOR LOCAL FAST_FORWARD FOR
    SELECT id
    FROM inserted
    WHERE license_no IS NULL;

  OPEN pending;
  FETCH NEXT FROM pending INTO @companyId;

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @attempts = 0;

    WHILE 1 = 1
    BEGIN
      SET @candidate = CONCAT(
        N'RO-',
        RIGHT(N'00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS NVARCHAR(5)), 5)
      );

      IF NOT EXISTS (
        SELECT 1
        FROM dbo.companies
        WHERE license_no = @candidate
          AND id <> @companyId
      )
      BEGIN
        UPDATE dbo.companies
        SET license_no = @candidate
        WHERE id = @companyId
          AND license_no IS NULL;

        BREAK;
      END;

      SET @attempts = @attempts + 1;

      IF @attempts >= 50
      BEGIN
        CLOSE pending;
        DEALLOCATE pending;
        THROW 50002, 'Failed to generate a unique license number for a new company.', 1;
      END;
    END;

    FETCH NEXT FROM pending INTO @companyId;
  END;

  CLOSE pending;
  DEALLOCATE pending;
END;
