SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DECLARE @admin_user_id INT = (SELECT TOP 1 id FROM dbo.users WHERE role = 'Admin' ORDER BY id);
DECLARE @compliance_user_id INT = (SELECT TOP 1 id FROM dbo.users WHERE role = 'Compliance' ORDER BY id);
DECLARE @operations_user_id INT = (SELECT TOP 1 id FROM dbo.users WHERE role = 'Operations' ORDER BY id);
DECLARE @finance_user_id INT = (SELECT TOP 1 id FROM dbo.users WHERE role = 'Finance' ORDER BY id);
DECLARE @contractor_alpha_id INT = (SELECT TOP 1 id FROM dbo.users WHERE email = 'contractor.alpha@ogfza.example.com' ORDER BY id);
DECLARE @contractor_beta_id INT = (SELECT TOP 1 id FROM dbo.users WHERE email = 'contractor.beta@ogfza.example.com' ORDER BY id);
DECLARE @contractor_gamma_id INT = (SELECT TOP 1 id FROM dbo.users WHERE email = 'contractor.gamma@ogfza.example.com' ORDER BY id);

IF @admin_user_id IS NULL THROW 50000, 'Required Admin user was not found in dbo.users.', 1;
IF @compliance_user_id IS NULL THROW 50000, 'Required Compliance user was not found in dbo.users.', 1;
IF @operations_user_id IS NULL THROW 50000, 'Required Operations user was not found in dbo.users.', 1;
IF @finance_user_id IS NULL THROW 50000, 'Required Finance user was not found in dbo.users.', 1;
IF @contractor_alpha_id IS NULL THROW 50000, 'Required contractor user contractor.alpha@ogfza.example.com was not found in dbo.users.', 1;
IF @contractor_beta_id IS NULL THROW 50000, 'Required contractor user contractor.beta@ogfza.example.com was not found in dbo.users.', 1;
IF @contractor_gamma_id IS NULL THROW 50000, 'Required contractor user contractor.gamma@ogfza.example.com was not found in dbo.users.', 1;

DELETE FROM dbo.company_compliance_case_events;
DELETE FROM dbo.company_compliance_cases;
DELETE FROM dbo.trade_operation_request_documents;
DELETE FROM dbo.trade_operation_request_events;
DELETE FROM dbo.trade_operation_requests;
DELETE FROM dbo.incident_events;
DELETE FROM dbo.incidents;
DELETE FROM dbo.company_application_documents;
DELETE FROM dbo.company_application_events;
DELETE FROM dbo.revenue;
DELETE FROM dbo.operations;
DELETE FROM dbo.equipment_maintenance;
DELETE FROM dbo.assets;
DELETE FROM dbo.companies;
DELETE FROM dbo.company_applications;

DBCC CHECKIDENT ('dbo.company_applications', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.company_application_documents', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.company_application_events', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.companies', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.assets', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.revenue', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.operations', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.incidents', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.incident_events', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.equipment_maintenance', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.trade_operation_requests', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.trade_operation_request_documents', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.trade_operation_request_events', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.company_compliance_cases', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('dbo.company_compliance_case_events', RESEED, 0) WITH NO_INFOMSGS;

INSERT INTO dbo.company_applications (
    application_reference,
    company_name,
    incorporation_type,
    free_zone_location,
    global_head_office_address,
    global_phone_1,
    global_email,
    global_website,
    nigeria_office_address,
    nigeria_phone_1,
    nigeria_email,
    nigeria_website,
    primary_contact_name,
    primary_contact_designation,
    primary_contact_phone,
    primary_contact_email,
    secondary_contact_name,
    secondary_contact_designation,
    secondary_contact_phone,
    secondary_contact_email,
    present_business_operations,
    dpr_registration_number,
    activity_description,
    countries_of_operation_west_africa,
    proposed_business_activity,
    project_summary_attachment_url,
    warehouse_space_sqm,
    factory_premises_sqm,
    office_accommodation_sqm,
    equipment_requirement,
    residential_accommodation_personnel_count,
    imports_summary,
    exports_summary,
    proposed_commencement_date,
    declaration_name,
    declaration_designation,
    declaration_signature_date,
    company_seal_file_url,
    status,
    submitted_by_user_id,
    reviewed_by_user_id,
    approved_by_user_id,
    submitted_at,
    reviewed_at,
    approved_at,
    returned_at,
    rejected_at,
    rejection_reason,
    created_at,
    updated_at,
    returned_by_user_id,
    resubmitted_at,
    query_note,
    requested_license_type,
    estimated_fee_usd,
    approved_license_type,
    approved_fee_usd,
    payment_status,
    payment_reference,
    payment_confirmed_at,
    payment_confirmed_by_user_id,
    payment_submitted_at,
    payment_submitted_by_user_id
)
VALUES
(
    'FZA-DEMO-001',
    'Onne Marine Services Ltd',
    'Nigerian registered company',
    'Onne Oil & Gas Free Zone Area, Rivers State',
    '12 Marina Boulevard, Victoria Island, Lagos',
    '+234-803-110-2001',
    'contact.one@ogfza.example.com',
    'https://onnemarine.example.com',
    'Plot 18, Federal Ocean Terminal, Onne, Rivers State',
    '+234-809-110-2001',
    'contact.one@ogfza.example.com',
    'https://onnemarine.example.com/ng',
    'Grace Ibiba',
    'Head of Commercial',
    '+234-701-110-2001',
    'contact.one@ogfza.example.com',
    'Musa Adamu',
    'Operations Liaison',
    '+234-702-110-2001',
    'contact.two@ogfza.example.com',
    'Marine logistics, pipe handling, bonded cargo support, and offshore vessel coordination.',
    'DPR/ONNE/2026/001',
    'Marine services',
    'Nigeria, Ghana, Ivory Coast',
    'Expand bonded marine cargo handling and vessel support services within Onne Free Zone.',
    'onne_marine_project_summary.pdf',
    3400,
    1800,
    620,
    'Forklifts, reach stackers, tug support vehicles, and cargo scanners.',
    24,
    'Inbound pipe bundles, valves, lifting accessories, and marine consumables.',
    'Processed marine support equipment and bonded cargo kits for offshore projects.',
    '2026-03-15',
    'Grace Ibiba',
    'Head of Commercial',
    '2026-02-18',
    'onne_marine_company_seal.png',
    'Licence Issued',
    @contractor_alpha_id,
    @compliance_user_id,
    @admin_user_id,
    '2026-02-18T09:15:00',
    '2026-02-20T11:30:00',
    '2026-02-22T15:10:00',
    NULL,
    NULL,
    NULL,
    '2026-02-18T09:15:00',
    '2026-02-25T10:00:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Service Licence',
    4500,
    'Free Zone Service Licence',
    4500,
    'Paid',
    'PAY-ONNE-20260224-001',
    '2026-02-25T10:00:00',
    @admin_user_id,
    '2026-02-24T14:20:00',
    @contractor_alpha_id
),
(
    'FZA-DEMO-002',
    'Delta Fabrication & Logistics Ltd',
    'Free Zone incorporation',
    'Onne Oil & Gas Free Zone Area, Rivers State',
    '55 Warehouse Crescent, Lekki Phase 1, Lagos',
    '+234-803-220-2002',
    'contact.two@ogfza.example.com',
    'https://deltafablog.example.com',
    'FGZ Yard 7, Onne Oil & Gas Free Zone, Rivers State',
    '+234-809-220-2002',
    'contact.two@ogfza.example.com',
    'https://deltafablog.example.com/zone',
    'Adaeze Mba',
    'Business Development Manager',
    '+234-701-220-2002',
    'contact.two@ogfza.example.com',
    'Chinedu Oko',
    'Compliance Coordinator',
    '+234-702-220-2002',
    'contractor.alpha@ogfza.example.com',
    'Fabrication of skids, pipe spools, structural modules, and bonded logistics support.',
    'DPR/ONNE/2026/002',
    'Fabrication',
    'Nigeria, Cameroon, Equatorial Guinea',
    'Commission a fabrication bay with bonded export capability for offshore support structures.',
    'delta_fabrication_project_summary.pdf',
    5200,
    6400,
    880,
    'Plate rolling machines, welding manipulators, blasting unit, and QC testing kits.',
    38,
    'Steel plates, welding consumables, coated pipes, and mechanical fittings.',
    'Fabricated skids, structural frames, export-ready pipe spools, and assembled modules.',
    '2026-02-12',
    'Adaeze Mba',
    'Business Development Manager',
    '2026-01-10',
    'delta_fabrication_company_seal.png',
    'Licence Issued',
    @contractor_alpha_id,
    @compliance_user_id,
    @admin_user_id,
    '2026-01-10T08:30:00',
    '2026-01-16T12:00:00',
    '2026-01-18T16:15:00',
    '2026-01-14T11:00:00',
    NULL,
    NULL,
    '2026-01-10T08:30:00',
    '2026-01-22T09:10:00',
    @compliance_user_id,
    '2026-01-15T09:20:00',
    'Please include evidence of stamp duty payment and updated promoter meeting minutes.',
    'Free Zone Enterprise Licence',
    40500,
    'Free Zone Enterprise Licence',
    40500,
    'Paid',
    'PAY-DELTA-20260121-004',
    '2026-01-22T09:10:00',
    @admin_user_id,
    '2026-01-21T13:45:00',
    @contractor_alpha_id
),
(
    'FZA-DEMO-003',
    'Brass Offshore Calibration Ltd',
    'Offshore/overseas incorporation',
    'Brass Oil & Gas Free Zone Area, Bayelsa State',
    '10 Aberdeen Quay, Aberdeen, Scotland',
    '+44-1224-111-303',
    'contact.three@ogfza.example.com',
    'https://brasscalibration.example.com',
    'Pilot Road, Brass Oil & Gas Free Zone, Bayelsa State',
    '+234-809-330-2003',
    'contact.three@ogfza.example.com',
    'https://brasscalibration.example.com/ng',
    'Fatima Lawal',
    'Regional Director',
    '+234-701-330-2003',
    'contact.three@ogfza.example.com',
    'Ibrahim Sule',
    'Country Representative',
    '+234-702-330-2003',
    'contact.four@ogfza.example.com',
    'Calibration, pressure testing, metering verification, and offshore instrument recertification.',
    'DPR/BRASS/2025/019',
    'Calibration',
    'Nigeria, Senegal, Mauritania',
    'Establish a calibration lab and offshore instrumentation recertification hub inside Brass Free Zone.',
    'brass_calibration_project_summary.pdf',
    1200,
    2600,
    450,
    'Calibration benches, pressure pumps, gas analyzers, and master gauges.',
    16,
    'Calibration gases, precision gauges, control valves, and metering accessories.',
    'Certified gauges, recertified valves, calibration packs, and inspection reports.',
    '2025-12-12',
    'Fatima Lawal',
    'Regional Director',
    '2025-11-20',
    'brass_calibration_company_seal.png',
    'Licence Issued',
    @contractor_beta_id,
    @compliance_user_id,
    @admin_user_id,
    '2025-11-20T10:05:00',
    '2025-11-24T14:15:00',
    '2025-11-26T10:20:00',
    NULL,
    NULL,
    NULL,
    '2025-11-20T10:05:00',
    '2025-11-28T11:00:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Enterprise - Special Activity Licence',
    115500,
    'Free Zone Enterprise - Special Activity Licence',
    115500,
    'Paid',
    'PAY-BRASS-20251127-002',
    '2025-11-28T11:00:00',
    @admin_user_id,
    '2025-11-27T16:40:00',
    @contractor_beta_id
),
(
    'FZA-DEMO-004',
    'Niger Atlantic Developers Ltd',
    'Free Zone incorporation',
    'Bestaf Maritime Industrial Free Zone, Lagos State',
    '2 Admiralty Road, Ikoyi, Lagos',
    '+234-803-440-2004',
    'contractor.beta@ogfza.example.com',
    'https://nigeratlanticdev.example.com',
    'Block C, Bestaf Maritime Industrial Free Zone, Lagos State',
    '+234-809-440-2004',
    'contractor.beta@ogfza.example.com',
    'https://nigeratlanticdev.example.com/lagos',
    'Daniel Audu',
    'Project Director',
    '+234-701-440-2004',
    'contractor.beta@ogfza.example.com',
    'Helen Bassey',
    'Development Manager',
    '+234-702-440-2004',
    'contact.one@ogfza.example.com',
    'Zone infrastructure development, utility corridors, logistics support yards, and terminal expansion planning.',
    'DPR/BESTAF/2025/004',
    'Engineering services',
    'Nigeria, Togo, Benin Republic',
    'Develop a multi-user industrial support yard and logistics utilities block for marine operators.',
    'niger_atlantic_developers_project_summary.pdf',
    8800,
    7200,
    950,
    'Earth movers, utility trenching rigs, quay development equipment, and drainage pumps.',
    42,
    'Civil work materials, electrical fittings, marine utility kits, and terminal hardware.',
    'Prepared industrial pads, serviced plots, utility corridors, and marine support infrastructure.',
    '2025-04-10',
    'Daniel Audu',
    'Project Director',
    '2025-03-05',
    'niger_atlantic_developers_company_seal.png',
    'Licence Issued',
    @contractor_beta_id,
    @compliance_user_id,
    @admin_user_id,
    '2025-03-05T08:45:00',
    '2025-03-12T15:30:00',
    '2025-03-15T12:10:00',
    NULL,
    NULL,
    NULL,
    '2025-03-05T08:45:00',
    '2025-03-20T09:05:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Developer Licence',
    215500,
    'Free Zone Developer Licence',
    215500,
    'Paid',
    'PAY-DEVELOPER-20250318-003',
    '2025-03-20T09:05:00',
    @admin_user_id,
    '2025-03-18T16:10:00',
    @contractor_beta_id
),
(
    'FZA-DEMO-005',
    'Eko Support Logistics Hub Ltd',
    'Nigerian registered company',
    'Eko Support Free Zone Area, Lagos State',
    '27 Creek Road, Apapa, Lagos',
    '+234-803-550-2005',
    'contractor.gamma@ogfza.example.com',
    'https://ekosupporthub.example.com',
    'Warehouse Cluster 3, Eko Support Free Zone, Lagos State',
    '+234-809-550-2005',
    'contractor.gamma@ogfza.example.com',
    'https://ekosupporthub.example.com/eko',
    'Vincent Bura',
    'General Manager',
    '+234-701-550-2005',
    'contractor.gamma@ogfza.example.com',
    'Joseph Effiong',
    'Terminal Coordinator',
    '+234-702-550-2005',
    'contact.two@ogfza.example.com',
    'Bonded warehousing, cargo consolidation, export staging, and terminal trucking coordination.',
    'DPR/EKO/2025/017',
    'Oilfield services',
    'Nigeria, Ghana, Sierra Leone',
    'Expand bonded warehousing and export staging services for marine and oilfield support cargo.',
    'eko_support_logistics_project_summary.pdf',
    7600,
    2100,
    720,
    'Forklifts, cargo scanners, pallet wrappers, and dockside handling equipment.',
    22,
    'Mixed project cargo, containers, drilling consumables, and maintenance spares.',
    'Export-ready support cargo, consolidated outbound kits, and terminal dispatch loads.',
    '2025-03-01',
    'Vincent Bura',
    'General Manager',
    '2025-02-01',
    'eko_support_logistics_company_seal.png',
    'Licence Issued',
    @contractor_gamma_id,
    @compliance_user_id,
    @admin_user_id,
    '2025-02-01T09:30:00',
    '2025-02-06T13:15:00',
    '2025-02-10T10:35:00',
    NULL,
    NULL,
    NULL,
    '2025-02-01T09:30:00',
    '2025-02-14T08:50:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Enterprise Licence',
    40500,
    'Free Zone Enterprise Licence',
    40500,
    'Paid',
    'PAY-EKO-20250213-007',
    '2025-02-14T08:50:00',
    @admin_user_id,
    '2025-02-13T17:25:00',
    @contractor_gamma_id
),
(
    'FZA-DEMO-006',
    'Warri Marine Export Services Ltd',
    'Nigerian registered company',
    'Warri Oil & Gas Free Zone Area, Delta State',
    '14 Airport Road, Warri, Delta State',
    '+234-803-660-2006',
    'contact.four@ogfza.example.com',
    'https://warriexport.example.com',
    'Quay 5, Warri Oil & Gas Free Zone, Delta State',
    '+234-809-660-2006',
    'contact.four@ogfza.example.com',
    'https://warriexport.example.com/warri',
    'Oghenekaro Efe',
    'Managing Partner',
    '+234-701-660-2006',
    'contact.four@ogfza.example.com',
    'Sani Bello',
    'Commercial Lead',
    '+234-702-660-2006',
    'contact.three@ogfza.example.com',
    'Marine export packaging, bonded cargo dispatch, and vessel supply consolidation.',
    'DPR/WARRI/2026/010',
    'Marine services',
    'Nigeria, Ghana',
    'Launch a bonded export service line for packaged marine cargo leaving Warri Free Zone.',
    'warri_export_project_summary.pdf',
    4100,
    1400,
    540,
    'Palletizing systems, dockside forklifts, export packing materials, and scanning tools.',
    18,
    'Outbound marine spare kits, export packaging materials, and support pallets.',
    'Bonded export cargo and pre-cleared vessel support consignments.',
    '2026-04-20',
    'Oghenekaro Efe',
    'Managing Partner',
    '2026-03-05',
    'warri_export_company_seal.png',
    'Approved Pending Payment',
    @contractor_gamma_id,
    @compliance_user_id,
    @admin_user_id,
    '2026-03-05T10:10:00',
    '2026-03-08T12:20:00',
    '2026-03-10T09:00:00',
    NULL,
    NULL,
    NULL,
    '2026-03-05T10:10:00',
    '2026-03-10T09:00:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Enterprise Licence',
    40500,
    'Free Zone Enterprise Licence',
    40500,
    'Awaiting Contractor Payment',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
),
(
    'FZA-DEMO-007',
    'Bestaf Industrial Handling Ltd',
    'Offshore/overseas incorporation',
    'Bestaf Maritime Industrial Free Zone, Lagos State',
    '88 Rotterdam Quays, Rotterdam, Netherlands',
    '+31-102-000-2007',
    'contact.two@ogfza.example.com',
    'https://bestafhandling.example.com',
    'Handling Yard B, Bestaf Maritime Industrial Free Zone, Lagos State',
    '+234-809-770-2007',
    'contact.two@ogfza.example.com',
    'https://bestafhandling.example.com/ng',
    'Yusuf Lawan',
    'Country Manager',
    '+234-701-770-2007',
    'contact.two@ogfza.example.com',
    'Temi James',
    'Logistics Supervisor',
    '+234-702-770-2007',
    'contractor.alpha@ogfza.example.com',
    'Bulk cargo handling, rigging support, temporary storage, and terminal transfer services.',
    'DPR/BESTAF/2026/011',
    'Oilfield services',
    'Nigeria, Ghana, Benin Republic',
    'Scale cargo handling operations and customs transfer services inside Bestaf Maritime Industrial Free Zone.',
    'bestaf_handling_project_summary.pdf',
    5300,
    2000,
    610,
    'Reach stackers, slings, mobile cranes, and staging forklifts.',
    20,
    'Rigging supplies, cargo pallets, oversize lift components, and transfer spares.',
    'Handled oversized project cargo, transfer-ready cargo packs, and rigging support kits.',
    '2026-04-10',
    'Yusuf Lawan',
    'Country Manager',
    '2026-03-06',
    'bestaf_handling_company_seal.png',
    'Payment Submitted',
    @contractor_beta_id,
    @compliance_user_id,
    @admin_user_id,
    '2026-03-06T09:05:00',
    '2026-03-09T13:10:00',
    '2026-03-11T11:20:00',
    NULL,
    NULL,
    NULL,
    '2026-03-06T09:05:00',
    '2026-03-14T09:40:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Enterprise Licence',
    40500,
    'Free Zone Enterprise Licence',
    40500,
    'Payment Submitted',
    'PAY-BESTAF-20260314-009',
    NULL,
    NULL,
    '2026-03-14T09:40:00',
    @contractor_beta_id
),
(
    'FZA-DEMO-008',
    'Liberty Oilfield Manufacturing Ltd',
    'Free Zone incorporation',
    'Liberty Oil & Gas Free Zone Area, Akwa Ibom State',
    '31 Uyo Ring Road, Uyo, Akwa Ibom State',
    '+234-803-880-2008',
    'contact.three@ogfza.example.com',
    'https://libertymanufacturing.example.com',
    'Plot D4, Liberty Oil & Gas Free Zone, Akwa Ibom State',
    '+234-809-880-2008',
    'contact.three@ogfza.example.com',
    'https://libertymanufacturing.example.com/liberty',
    'Nkechi Ekanem',
    'Executive Director',
    '+234-701-880-2008',
    'contact.three@ogfza.example.com',
    'Hamisu Ali',
    'Projects Officer',
    '+234-702-880-2008',
    'contact.four@ogfza.example.com',
    'Manufacturing of support skids, modular panels, and special-purpose oilfield structures.',
    'DPR/LIBERTY/2026/012',
    'Manufacturing',
    'Nigeria, Cameroon',
    'Establish a manufacturing line for specialized oilfield structures and modular support assemblies.',
    'liberty_manufacturing_project_summary.pdf',
    4800,
    6900,
    700,
    'CNC cutting beds, paint booth, welding machines, and QA inspection tools.',
    30,
    'Steel coils, paint chemicals, fasteners, and piping support components.',
    'Manufactured support skids, coated panels, and preassembled structures.',
    '2026-05-05',
    'Nkechi Ekanem',
    'Executive Director',
    '2026-03-07',
    'liberty_manufacturing_company_seal.png',
    'Awaiting Admin Approval',
    @contractor_alpha_id,
    @compliance_user_id,
    NULL,
    '2026-03-07T08:40:00',
    '2026-03-11T12:00:00',
    NULL,
    NULL,
    NULL,
    NULL,
    '2026-03-07T08:40:00',
    '2026-03-11T12:00:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Enterprise - Special Activity Licence',
    115500,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
),
(
    'FZA-DEMO-009',
    'Atlantic Deepwater Services Ltd',
    'Offshore/overseas incorporation',
    'Onne Oil & Gas Free Zone Area, Rivers State',
    '9 Stavanger House, Stavanger, Norway',
    '+47-510-000-2009',
    'contact.one@ogfza.example.com',
    'https://atlanticdeepwater.example.com',
    'Marine Base Plot 12, Onne Free Zone, Rivers State',
    '+234-809-990-2009',
    'contact.one@ogfza.example.com',
    'https://atlanticdeepwater.example.com/onne',
    'Boma Peters',
    'Country Lead',
    '+234-701-990-2009',
    'contact.one@ogfza.example.com',
    'Aisha Musa',
    'Regulatory Liaison',
    '+234-702-990-2009',
    'contact.two@ogfza.example.com',
    'Deepwater support services, subsea intervention planning, and offshore marine logistics.',
    'DPR/ONNE/2026/013',
    'Engineering services',
    'Nigeria, Ghana, Angola',
    'Deploy deepwater support logistics and subsea intervention support services from Onne Free Zone.',
    'atlantic_deepwater_project_summary.pdf',
    2300,
    1800,
    540,
    'ROV workshop tools, subsea inspection kits, and marine support containers.',
    14,
    'ROV spares, intervention tooling, subsea survey kits, and marine consumables.',
    'Support packs, intervention kits, and offshore logistics bundles.',
    '2026-05-25',
    'Boma Peters',
    'Country Lead',
    '2026-03-08',
    'atlantic_deepwater_company_seal.png',
    'Returned',
    @contractor_gamma_id,
    @compliance_user_id,
    NULL,
    '2026-03-08T11:25:00',
    '2026-03-12T15:40:00',
    NULL,
    '2026-03-12T15:40:00',
    NULL,
    NULL,
    '2026-03-08T11:25:00',
    '2026-03-12T15:40:00',
    @compliance_user_id,
    NULL,
    'Please clarify the exact subsea equipment list and attach the notarized incorporation copy.',
    'Free Zone Service Licence',
    4500,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
),
(
    'FZA-DEMO-010',
    'Onshore Support Nigeria Ltd',
    'Nigerian registered company',
    'Brass Oil & Gas Free Zone Area, Bayelsa State',
    '71 Aba Road, Port Harcourt, Rivers State',
    '+234-803-101-2010',
    'contact.two@ogfza.example.com',
    'https://onshoresupport.example.com',
    'Service Cluster 2, Brass Free Zone, Bayelsa State',
    '+234-809-101-2010',
    'contact.two@ogfza.example.com',
    'https://onshoresupport.example.com/brass',
    'Mabel Johnson',
    'Commercial Manager',
    '+234-701-101-2010',
    'contact.two@ogfza.example.com',
    'Ahmed Danjuma',
    'Admin Officer',
    '+234-702-101-2010',
    'contractor.beta@ogfza.example.com',
    'Industrial support services, worksite consumables, and personnel welfare logistics.',
    'DPR/BRASS/2026/014',
    'Oilfield services',
    'Nigeria, Ghana',
    'Provide industrial support and welfare logistics for resident operators in Brass Free Zone.',
    'onshore_support_project_summary.pdf',
    2800,
    900,
    460,
    'Utility vans, warehouse racks, welfare containers, and handling kits.',
    12,
    'Consumables, PPE, catering kits, and worksite supplies.',
    'Prepared welfare kits, support consumables, and packaged site logistics materials.',
    '2026-05-15',
    'Mabel Johnson',
    'Commercial Manager',
    '2026-03-09',
    'onshore_support_company_seal.png',
    'Submitted',
    @contractor_beta_id,
    NULL,
    NULL,
    '2026-03-09T09:00:00',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '2026-03-09T09:00:00',
    '2026-03-09T09:00:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Service Licence',
    4500,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
),
(
    'FZA-DEMO-011',
    'Delta Terminal Special Projects Ltd',
    'Nigerian registered company',
    'Warri Oil & Gas Free Zone Area, Delta State',
    '88 Effurun Road, Warri, Delta State',
    '+234-803-111-2011',
    'contact.three@ogfza.example.com',
    'https://deltaterminalspecial.example.com',
    'Terminal Works Plot 8, Warri Oil & Gas Free Zone, Delta State',
    '+234-809-111-2011',
    'contact.three@ogfza.example.com',
    'https://deltaterminalspecial.example.com/warri',
    'Chika Omoruyi',
    'Managing Consultant',
    '+234-701-111-2011',
    'contact.three@ogfza.example.com',
    'Kabiru Garba',
    'Project Coordinator',
    '+234-702-111-2011',
    'contact.four@ogfza.example.com',
    'Special projects management, fabrication support oversight, and controlled offshore service coordination.',
    'DPR/WARRI/2026/015',
    'Engineering services',
    'Nigeria',
    'Deliver a special-activity support platform for offshore project cargo coordination and managed services.',
    'delta_terminal_special_project_summary.pdf',
    2500,
    1300,
    420,
    'Inspection tools, mobile office units, tracking devices, and staging equipment.',
    10,
    'Managed service kits, project tracking hardware, and marine support consumables.',
    'Project tracking bundles, dispatch packs, and managed offshore support kits.',
    '2026-06-01',
    'Chika Omoruyi',
    'Managing Consultant',
    '2026-03-10',
    'delta_terminal_special_company_seal.png',
    'Rejected',
    @contractor_gamma_id,
    @compliance_user_id,
    NULL,
    '2026-03-10T08:20:00',
    '2026-03-12T10:15:00',
    NULL,
    NULL,
    '2026-03-14T15:25:00',
    'The requested special activity licence was not justified by the submitted project scope and supporting evidence.',
    '2026-03-10T08:20:00',
    '2026-03-14T15:25:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Enterprise - Special Activity Licence',
    115500,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
),
(
    'FZA-DEMO-012',
    'Brass Support Contractors Ltd',
    'Nigerian registered company',
    'Brass Oil & Gas Free Zone Area, Bayelsa State',
    '18 Aggrey Road, Port Harcourt, Rivers State',
    '+234-803-112-2012',
    'contact.four@ogfza.example.com',
    'https://brasssupportcontractors.example.com',
    'Support Yard 1, Brass Oil & Gas Free Zone, Bayelsa State',
    '+234-809-112-2012',
    'contact.four@ogfza.example.com',
    'https://brasssupportcontractors.example.com/brass',
    'Tomi Briggs',
    'Managing Director',
    '+234-701-112-2012',
    'contact.four@ogfza.example.com',
    'Yakubu Ibrahim',
    'Operations Lead',
    '+234-702-112-2012',
    'contractor.gamma@ogfza.example.com',
    'Contract staffing support, shore-base consumables, and packaged industrial support services.',
    'DPR/BRASS/2026/016',
    'Oilfield services',
    'Nigeria',
    'Provide packaged support services and contractor logistics for resident operators in Brass Free Zone.',
    'brass_support_contractors_project_summary.pdf',
    1800,
    500,
    300,
    'Small utility fleet, welfare equipment, and warehousing racks.',
    8,
    'Consumables, PPE, camp support kits, and light logistics supplies.',
    'Packaged support kits and contractor welfare materials.',
    '2026-05-08',
    'Tomi Briggs',
    'Managing Director',
    '2026-03-11',
    'brass_support_contractors_company_seal.png',
    'Rejected',
    @contractor_alpha_id,
    @compliance_user_id,
    NULL,
    '2026-03-11T09:35:00',
    '2026-03-13T12:45:00',
    NULL,
    NULL,
    '2026-03-13T12:45:00',
    'The environmental impact assessment report and DPR certificate submitted were incomplete.',
    '2026-03-11T09:35:00',
    '2026-03-13T12:45:00',
    NULL,
    NULL,
    NULL,
    'Free Zone Service Licence',
    4500,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
);

;WITH application_document_seed AS (
    SELECT 'FZA-DEMO-001' AS application_reference, 'dpr_certificate' AS document_type UNION ALL
    SELECT 'FZA-DEMO-001', 'certificate_of_incorporation' UNION ALL
    SELECT 'FZA-DEMO-001', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-001', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-001', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-001', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-001', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-001', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-001', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-001', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-002', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-002', 'pre_incorporation_meeting_with_promoters' UNION ALL
    SELECT 'FZA-DEMO-002', 'share_capital_and_stamp_duty_evidence' UNION ALL
    SELECT 'FZA-DEMO-002', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-002', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-002', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-002', 'financial_profile_fdi_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-002', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-002', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-003', 'certificate_or_notarized_overseas_incorporation' UNION ALL
    SELECT 'FZA-DEMO-003', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-003', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-003', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-003', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-003', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-003', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-003', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-003', 'oil_and_gas_affidavit' UNION ALL
    SELECT 'FZA-DEMO-003', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-004', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-004', 'pre_incorporation_meeting_with_promoters' UNION ALL
    SELECT 'FZA-DEMO-004', 'share_capital_and_stamp_duty_evidence' UNION ALL
    SELECT 'FZA-DEMO-004', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-004', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-004', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-004', 'financial_profile_fdi_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-004', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-004', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-005', 'dpr_certificate' UNION ALL
    SELECT 'FZA-DEMO-005', 'certificate_of_incorporation' UNION ALL
    SELECT 'FZA-DEMO-005', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-005', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-005', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-005', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-005', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-005', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-005', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-005', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-006', 'dpr_certificate' UNION ALL
    SELECT 'FZA-DEMO-006', 'certificate_of_incorporation' UNION ALL
    SELECT 'FZA-DEMO-006', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-006', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-006', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-006', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-006', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-006', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-006', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-006', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-007', 'certificate_or_notarized_overseas_incorporation' UNION ALL
    SELECT 'FZA-DEMO-007', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-007', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-007', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-007', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-007', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-007', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-007', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-007', 'oil_and_gas_affidavit' UNION ALL
    SELECT 'FZA-DEMO-007', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-008', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-008', 'pre_incorporation_meeting_with_promoters' UNION ALL
    SELECT 'FZA-DEMO-008', 'share_capital_and_stamp_duty_evidence' UNION ALL
    SELECT 'FZA-DEMO-008', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-008', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-008', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-008', 'financial_profile_fdi_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-008', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-008', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-009', 'certificate_or_notarized_overseas_incorporation' UNION ALL
    SELECT 'FZA-DEMO-009', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-009', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-009', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-009', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-009', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-009', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-009', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-009', 'oil_and_gas_affidavit' UNION ALL
    SELECT 'FZA-DEMO-009', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-010', 'dpr_certificate' UNION ALL
    SELECT 'FZA-DEMO-010', 'certificate_of_incorporation' UNION ALL
    SELECT 'FZA-DEMO-010', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-010', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-010', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-010', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-010', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-010', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-010', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-010', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-011', 'dpr_certificate' UNION ALL
    SELECT 'FZA-DEMO-011', 'certificate_of_incorporation' UNION ALL
    SELECT 'FZA-DEMO-011', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-011', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-011', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-011', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-011', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-011', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-011', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-011', 'facility_lease_confirmation' UNION ALL
    SELECT 'FZA-DEMO-012', 'dpr_certificate' UNION ALL
    SELECT 'FZA-DEMO-012', 'certificate_of_incorporation' UNION ALL
    SELECT 'FZA-DEMO-012', 'memorandum_and_articles_of_association' UNION ALL
    SELECT 'FZA-DEMO-012', 'company_brochure_or_profile' UNION ALL
    SELECT 'FZA-DEMO-012', 'environmental_impact_assessment_report' UNION ALL
    SELECT 'FZA-DEMO-012', 'feasibility_study_business_plan' UNION ALL
    SELECT 'FZA-DEMO-012', 'financial_and_personnel_profile' UNION ALL
    SELECT 'FZA-DEMO-012', 'sources_of_funding' UNION ALL
    SELECT 'FZA-DEMO-012', 'audited_accounts_last_three_years' UNION ALL
    SELECT 'FZA-DEMO-012', 'facility_lease_confirmation'
)
INSERT INTO dbo.company_application_documents (
    application_id,
    document_type,
    file_name,
    created_at,
    updated_at
)
SELECT
    a.id,
    s.document_type,
    CONCAT('seed_', RIGHT('000' + CAST(a.id AS VARCHAR(10)), 3), '_', s.document_type, '.pdf'),
    DATEADD(MINUTE, 20, a.submitted_at),
    DATEADD(MINUTE, 20, a.submitted_at)
FROM application_document_seed s
INNER JOIN dbo.company_applications a
    ON a.application_reference = s.application_reference;

INSERT INTO dbo.company_application_events (
    application_id,
    event_type,
    actor_user_id,
    actor_name,
    actor_role,
    from_status,
    to_status,
    note,
    metadata_json,
    created_at
)
SELECT
    a.id,
    e.event_type,
    e.actor_user_id,
    e.actor_name,
    e.actor_role,
    e.from_status,
    e.to_status,
    e.note,
    NULL,
    e.created_at
FROM dbo.company_applications a
INNER JOIN (
    SELECT 'FZA-DEMO-001' AS application_reference, 'Submitted' AS event_type, @contractor_alpha_id AS actor_user_id, 'Morgan Reed' AS actor_name, 'Contractor' AS actor_role, NULL AS from_status, 'Submitted' AS to_status, 'Company application submitted by contractor.' AS note, CAST('2026-02-18T09:15:00' AS DATETIME2) AS created_at UNION ALL
    SELECT 'FZA-DEMO-001', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2026-02-20T11:30:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-001', 'ApprovedByAdmin', @admin_user_id, 'System Admin', 'Admin', 'Awaiting Admin Approval', 'Approved Pending Payment', 'Managing Director approved the application for Free Zone Service Licence. The contractor must now submit payment details before the licence can be issued.', CAST('2026-02-22T15:10:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-001', 'PaymentSubmitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', 'Approved Pending Payment', 'Payment Submitted', 'Contractor submitted payment reference PAY-ONNE-20260224-001 for admin confirmation.', CAST('2026-02-24T14:20:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-001', 'LicenseIssued', @admin_user_id, 'System Admin', 'Admin', 'Payment Submitted', 'Licence Issued', 'Payment was confirmed under reference PAY-ONNE-20260224-001. Licence RO-51234 was issued for Free Zone Service Licence.', CAST('2026-02-25T10:00:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-002', 'Submitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2026-01-10T08:30:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-002', 'ReturnedForRevision', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Returned', 'Please include evidence of stamp duty payment and updated promoter meeting minutes.', CAST('2026-01-14T11:00:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-002', 'Resubmitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', 'Returned', 'Submitted', 'Contractor resubmitted the application after addressing the compliance query.', CAST('2026-01-15T09:20:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-002', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2026-01-16T12:00:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-002', 'ApprovedByAdmin', @admin_user_id, 'System Admin', 'Admin', 'Awaiting Admin Approval', 'Approved Pending Payment', 'Managing Director approved the application for Free Zone Enterprise Licence. The contractor must now submit payment details before the licence can be issued.', CAST('2026-01-18T16:15:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-002', 'PaymentSubmitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', 'Approved Pending Payment', 'Payment Submitted', 'Contractor submitted payment reference PAY-DELTA-20260121-004 for admin confirmation.', CAST('2026-01-21T13:45:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-002', 'LicenseIssued', @admin_user_id, 'System Admin', 'Admin', 'Payment Submitted', 'Licence Issued', 'Payment was confirmed under reference PAY-DELTA-20260121-004. Licence RO-54891 was issued for Free Zone Enterprise Licence.', CAST('2026-01-22T09:10:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-003', 'Submitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2025-11-20T10:05:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-003', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2025-11-24T14:15:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-003', 'ApprovedByAdmin', @admin_user_id, 'System Admin', 'Admin', 'Awaiting Admin Approval', 'Approved Pending Payment', 'Managing Director approved the application for Free Zone Enterprise - Special Activity Licence. The contractor must now submit payment details before the licence can be issued.', CAST('2025-11-26T10:20:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-003', 'PaymentSubmitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', 'Approved Pending Payment', 'Payment Submitted', 'Contractor submitted payment reference PAY-BRASS-20251127-002 for admin confirmation.', CAST('2025-11-27T16:40:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-003', 'LicenseIssued', @admin_user_id, 'System Admin', 'Admin', 'Payment Submitted', 'Licence Issued', 'Payment was confirmed under reference PAY-BRASS-20251127-002. Licence RO-60321 was issued for Free Zone Enterprise - Special Activity Licence.', CAST('2025-11-28T11:00:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-004', 'Submitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2025-03-05T08:45:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-004', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2025-03-12T15:30:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-004', 'ApprovedByAdmin', @admin_user_id, 'System Admin', 'Admin', 'Awaiting Admin Approval', 'Approved Pending Payment', 'Managing Director approved the application for Free Zone Developer Licence. The contractor must now submit payment details before the licence can be issued.', CAST('2025-03-15T12:10:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-004', 'PaymentSubmitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', 'Approved Pending Payment', 'Payment Submitted', 'Contractor submitted payment reference PAY-DEVELOPER-20250318-003 for admin confirmation.', CAST('2025-03-18T16:10:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-004', 'LicenseIssued', @admin_user_id, 'System Admin', 'Admin', 'Payment Submitted', 'Licence Issued', 'Payment was confirmed under reference PAY-DEVELOPER-20250318-003. Licence RO-64512 was issued for Free Zone Developer Licence.', CAST('2025-03-20T09:05:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-005', 'Submitted', @contractor_gamma_id, 'Taylor Briggs', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2025-02-01T09:30:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-005', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2025-02-06T13:15:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-005', 'ApprovedByAdmin', @admin_user_id, 'System Admin', 'Admin', 'Awaiting Admin Approval', 'Approved Pending Payment', 'Managing Director approved the application for Free Zone Enterprise Licence. The contractor must now submit payment details before the licence can be issued.', CAST('2025-02-10T10:35:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-005', 'PaymentSubmitted', @contractor_gamma_id, 'Taylor Briggs', 'Contractor', 'Approved Pending Payment', 'Payment Submitted', 'Contractor submitted payment reference PAY-EKO-20250213-007 for admin confirmation.', CAST('2025-02-13T17:25:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-005', 'LicenseIssued', @admin_user_id, 'System Admin', 'Admin', 'Payment Submitted', 'Licence Issued', 'Payment was confirmed under reference PAY-EKO-20250213-007. Licence RO-69908 was issued for Free Zone Enterprise Licence.', CAST('2025-02-14T08:50:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-006', 'Submitted', @contractor_gamma_id, 'Taylor Briggs', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2026-03-05T10:10:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-006', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2026-03-08T12:20:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-006', 'ApprovedByAdmin', @admin_user_id, 'System Admin', 'Admin', 'Awaiting Admin Approval', 'Approved Pending Payment', 'Managing Director approved the application for Free Zone Enterprise Licence. The contractor must now submit payment details before the licence can be issued.', CAST('2026-03-10T09:00:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-007', 'Submitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2026-03-06T09:05:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-007', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2026-03-09T13:10:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-007', 'ApprovedByAdmin', @admin_user_id, 'System Admin', 'Admin', 'Awaiting Admin Approval', 'Approved Pending Payment', 'Managing Director approved the application for Free Zone Enterprise Licence. The contractor must now submit payment details before the licence can be issued.', CAST('2026-03-11T11:20:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-007', 'PaymentSubmitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', 'Approved Pending Payment', 'Payment Submitted', 'Contractor submitted payment reference PAY-BESTAF-20260314-009 for admin confirmation.', CAST('2026-03-14T09:40:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-008', 'Submitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2026-03-07T08:40:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-008', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2026-03-11T12:00:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-009', 'Submitted', @contractor_gamma_id, 'Taylor Briggs', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2026-03-08T11:25:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-009', 'ReturnedForRevision', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Returned', 'Please clarify the exact subsea equipment list and attach the notarized incorporation copy.', CAST('2026-03-12T15:40:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-010', 'Submitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2026-03-09T09:00:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-011', 'Submitted', @contractor_gamma_id, 'Taylor Briggs', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2026-03-10T08:20:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-011', 'ForwardedToAdmin', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Awaiting Admin Approval', 'Compliance review completed and the application was forwarded for final admin approval.', CAST('2026-03-12T10:15:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-011', 'RejectedByAdmin', @admin_user_id, 'System Admin', 'Admin', 'Awaiting Admin Approval', 'Rejected', 'The requested special activity licence was not justified by the submitted project scope and supporting evidence.', CAST('2026-03-14T15:25:00' AS DATETIME2) UNION ALL

    SELECT 'FZA-DEMO-012', 'Submitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', NULL, 'Submitted', 'Company application submitted by contractor.', CAST('2026-03-11T09:35:00' AS DATETIME2) UNION ALL
    SELECT 'FZA-DEMO-012', 'RejectedByCompliance', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Rejected', 'The environmental impact assessment report and DPR certificate submitted were incomplete.', CAST('2026-03-13T12:45:00' AS DATETIME2)
) e
    ON a.application_reference = e.application_reference;

INSERT INTO dbo.companies (
    name,
    license_no,
    tin,
    sector,
    incorporation_type,
    status,
    approved_date,
    lease_info,
    representative_email,
    free_zone_location,
    approved_application_id,
    license_type
)
SELECT
    a.company_name,
    c.license_no,
    c.tin,
    c.sector,
    a.incorporation_type,
    'Active',
    CAST(a.payment_confirmed_at AS DATE),
    c.lease_info,
    a.primary_contact_email,
    a.free_zone_location,
    a.id,
    a.approved_license_type
FROM dbo.company_applications a
INNER JOIN (
    SELECT 'FZA-DEMO-001' AS application_reference, 'RO-51234' AS license_no, 'TIN-ONNE-001' AS tin, 'Marine Services' AS sector, 'Quay apron and bonded marine support yard leased from Onne terminal operator.' AS lease_info UNION ALL
    SELECT 'FZA-DEMO-002', 'RO-54891', 'TIN-DELTA-002', 'Fabrication', 'Fabrication bay and bonded export yard leased under Free Zone operator agreement.' UNION ALL
    SELECT 'FZA-DEMO-003', 'RO-60321', 'TIN-BRASS-003', 'Calibration', 'Calibration lab suite and test bench block leased inside Brass Free Zone.' UNION ALL
    SELECT 'FZA-DEMO-004', 'RO-64512', 'TIN-NIGER-004', 'Zone Development', 'Industrial support yard development parcel leased under Bestaf development concession.' UNION ALL
    SELECT 'FZA-DEMO-005', 'RO-69908', 'TIN-EKO-005', 'Logistics', 'Warehouse cluster and staging dock leased inside Eko Support Free Zone.'
) c
    ON a.application_reference = c.application_reference;

INSERT INTO dbo.revenue (
    company_id,
    amount,
    description,
    payment_date,
    status,
    invoice_no
)
SELECT
    c.id,
    a.approved_fee_usd,
    CONCAT(a.approved_license_type, ' Fee'),
    CAST(a.payment_confirmed_at AS DATE),
    'Paid',
    CONCAT('LIC-', c.license_no)
FROM dbo.companies c
INNER JOIN dbo.company_applications a
    ON a.id = c.approved_application_id;

;WITH asset_seed AS (
    SELECT 'Onne Marine Services Ltd' AS company_name, 'Berth Support Crane 01' AS asset_name, 'Marine Crane' AS asset_type, 'Lat 4.7821, Long 7.1645' AS location_coordinates, 'Operational' AS status, CAST('2026-04-18' AS DATE) AS maintenance_date UNION ALL
    SELECT 'Onne Marine Services Ltd', 'Pipe Lay Yard A', 'Storage Yard', 'Lat 4.7834, Long 7.1662', 'Under Maintenance', CAST('2026-03-20' AS DATE) UNION ALL
    SELECT 'Delta Fabrication & Logistics Ltd', 'Fabrication Bay 02', 'Fabrication Facility', 'Lat 4.7890, Long 7.1710', 'Operational', CAST('2026-04-05' AS DATE) UNION ALL
    SELECT 'Delta Fabrication & Logistics Ltd', 'Heavy Lift Gantry', 'Lifting Equipment', 'Lat 4.7905, Long 7.1726', 'Operational', CAST('2026-03-28' AS DATE) UNION ALL
    SELECT 'Brass Offshore Calibration Ltd', 'Calibration Lab Unit 03', 'Calibration Facility', 'Lat 4.3095, Long 6.2407', 'Operational', CAST('2026-04-12' AS DATE) UNION ALL
    SELECT 'Niger Atlantic Developers Ltd', 'Jetty Development Block 4', 'Infrastructure Asset', 'Lat 6.4412, Long 3.2501', 'Operational', CAST('2026-04-30' AS DATE) UNION ALL
    SELECT 'Eko Support Logistics Hub Ltd', 'Export Staging Dock', 'Dock Infrastructure', 'Lat 6.4380, Long 3.4028', 'Under Maintenance', CAST('2026-03-24' AS DATE) UNION ALL
    SELECT 'Eko Support Logistics Hub Ltd', 'Warehouse Automation Line', 'Warehouse System', 'Lat 6.4395, Long 3.4016', 'Operational', CAST('2026-04-22' AS DATE)
)
INSERT INTO dbo.assets (
    company_id,
    asset_name,
    type,
    location_coordinates,
    status,
    maintenance_date
)
SELECT
    c.id,
    a.asset_name,
    a.asset_type,
    a.location_coordinates,
    a.status,
    a.maintenance_date
FROM asset_seed a
INNER JOIN dbo.companies c
    ON c.name = a.company_name;

;WITH maintenance_seed AS (
    SELECT 'Pipe Lay Yard A' AS asset_name, 'Routine Check' AS maintenance_type, 'Reinforce yard drainage and inspect load-bearing surface.' AS description, 'Engr. Yusuf' AS technician, CAST(12500.00 AS DECIMAL(18,2)) AS cost, CAST('2026-03-15' AS DATE) AS maintenance_date, CAST('2026-03-20' AS DATE) AS next_due_date, 'In Progress' AS status UNION ALL
    SELECT 'Heavy Lift Gantry', 'Inspection', 'Perform hydraulic pressure inspection and lifting tolerance validation.', 'Engr. David', CAST(6200.00 AS DECIMAL(18,2)), CAST('2026-03-18' AS DATE), CAST('2026-03-28' AS DATE), 'Scheduled' UNION ALL
    SELECT 'Calibration Lab Unit 03', 'Calibration', 'Quarterly recalibration of master gauge set and lab pumps.', 'Engr. Amina', CAST(3200.00 AS DECIMAL(18,2)), CAST('2026-03-10' AS DATE), CAST('2026-04-12' AS DATE), 'Completed' UNION ALL
    SELECT 'Jetty Development Block 4', 'Routine Check', 'Inspect quay wall progress markers and utility trench integrity.', 'Engr. Tunde', CAST(8800.00 AS DECIMAL(18,2)), CAST('2026-03-08' AS DATE), CAST('2026-04-30' AS DATE), 'Completed' UNION ALL
    SELECT 'Export Staging Dock', 'Repair', 'Repair dock fender points and replace damaged staging bollards.', 'Engr. Grace', CAST(15400.00 AS DECIMAL(18,2)), CAST('2026-03-14' AS DATE), CAST('2026-03-24' AS DATE), 'In Progress' UNION ALL
    SELECT 'Warehouse Automation Line', 'Routine Check', 'Sensor calibration and conveyor control inspection.', 'Engr. Chuks', CAST(4100.00 AS DECIMAL(18,2)), CAST('2026-03-19' AS DATE), CAST('2026-04-22' AS DATE), 'Scheduled'
)
INSERT INTO dbo.equipment_maintenance (
    asset_id,
    maintenance_type,
    description,
    technician,
    cost,
    maintenance_date,
    next_due_date,
    status
)
SELECT
    a.id,
    m.maintenance_type,
    m.description,
    m.technician,
    m.cost,
    m.maintenance_date,
    m.next_due_date,
    m.status
FROM maintenance_seed m
INNER JOIN dbo.assets a
    ON a.asset_name = m.asset_name;

;WITH operation_seed AS (
    SELECT 'Berth Support Crane 01' AS asset_name, CAST(1420.00 AS DECIMAL(18,2)) AS production_volume, CAST(1.50 AS DECIMAL(18,2)) AS downtime_hours, CAST('2026-03-14' AS DATE) AS report_date, 'Routine lifting operations remained stable with one minor delay during vessel repositioning.' AS notes UNION ALL
    SELECT 'Pipe Lay Yard A', CAST(0.00 AS DECIMAL(18,2)), CAST(8.00 AS DECIMAL(18,2)), CAST('2026-03-15' AS DATE), 'Yard access restricted for drainage reinforcement and bearing-surface repairs.' UNION ALL
    SELECT 'Fabrication Bay 02', CAST(980.00 AS DECIMAL(18,2)), CAST(2.00 AS DECIMAL(18,2)), CAST('2026-03-15' AS DATE), 'Pipe spool welding achieved target output after a short power reset.' UNION ALL
    SELECT 'Heavy Lift Gantry', CAST(760.00 AS DECIMAL(18,2)), CAST(0.50 AS DECIMAL(18,2)), CAST('2026-03-15' AS DATE), 'Lift operations completed with short pause for sling verification.' UNION ALL
    SELECT 'Calibration Lab Unit 03', CAST(430.00 AS DECIMAL(18,2)), CAST(0.00 AS DECIMAL(18,2)), CAST('2026-03-13' AS DATE), 'Lab completed all scheduled calibration batches without interruption.' UNION ALL
    SELECT 'Jetty Development Block 4', CAST(300.00 AS DECIMAL(18,2)), CAST(5.00 AS DECIMAL(18,2)), CAST('2026-03-10' AS DATE), 'Progress slowed by weather delays during utility trench backfill.' UNION ALL
    SELECT 'Export Staging Dock', CAST(650.00 AS DECIMAL(18,2)), CAST(6.00 AS DECIMAL(18,2)), CAST('2026-03-12' AS DATE), 'Outbound staging slowed while dock repairs and access controls were reviewed.' UNION ALL
    SELECT 'Warehouse Automation Line', CAST(1120.00 AS DECIMAL(18,2)), CAST(1.00 AS DECIMAL(18,2)), CAST('2026-03-15' AS DATE), 'Warehouse line processed mixed outbound kits with minor barcode scanner recalibration.'
)
INSERT INTO dbo.operations (
    asset_id,
    field_name,
    production_volume,
    downtime_hours,
    report_date,
    notes
)
SELECT
    a.id,
    a.asset_name,
    o.production_volume,
    o.downtime_hours,
    o.report_date,
    o.notes
FROM operation_seed o
INNER JOIN dbo.assets a
    ON a.asset_name = o.asset_name;

;WITH incident_seed AS (
    SELECT
        'Onne Marine Services Ltd' AS company_name,
        'Berth Support Crane 01' AS asset_name,
        'Fuel Spill' AS incident_type,
        'High' AS severity,
        'Minor fuel spill observed around the berth crane refuelling point during vessel support operations.' AS description,
        'Open' AS status,
        CAST('2026-03-12T10:15:00' AS DATETIME2) AS reported_date,
        NULL AS follow_up_note,
        NULL AS follow_up_submitted_at,
        NULL AS follow_up_submitted_by_user_id,
        NULL AS resolved_at,
        NULL AS resolved_by_user_id,
        NULL AS closed_at,
        NULL AS closed_by_user_id,
        CAST('2026-03-12T10:15:00' AS DATETIME2) AS updated_at
    UNION ALL
    SELECT
        'Delta Fabrication & Logistics Ltd',
        'Heavy Lift Gantry',
        'Pressure Alarm',
        'Medium',
        'A high-pressure alarm was triggered during hydraulic gantry testing and the incident was logged for review.',
        'Open',
        CAST('2026-03-13T08:50:00' AS DATETIME2),
        'The alarm occurred during a planned pressure test and the unit has since returned to safe operating parameters. Supporting calibration sheets have been uploaded.',
        CAST('2026-03-14T12:10:00' AS DATETIME2),
        @contractor_alpha_id,
        NULL,
        NULL,
        NULL,
        NULL,
        CAST('2026-03-14T12:10:00' AS DATETIME2)
    UNION ALL
    SELECT
        'Brass Offshore Calibration Ltd',
        'Calibration Lab Unit 03',
        'Gas Leak Alert',
        'Low',
        'A minor calibration gas leak alert was recorded inside the calibration lab during a routine verification cycle.',
        'Resolved',
        CAST('2026-03-09T14:35:00' AS DATETIME2),
        'The leaking regulator was replaced, the area was ventilated, and fresh calibration gas cylinders were commissioned.',
        CAST('2026-03-10T09:15:00' AS DATETIME2),
        @contractor_beta_id,
        CAST('2026-03-11T11:40:00' AS DATETIME2),
        @compliance_user_id,
        NULL,
        NULL,
        CAST('2026-03-11T11:40:00' AS DATETIME2)
    UNION ALL
    SELECT
        'Eko Support Logistics Hub Ltd',
        'Export Staging Dock',
        'Access Control Breach',
        'Medium',
        'An access control breach was reported when a non-cleared vendor vehicle entered the export staging dock area.',
        'Closed',
        CAST('2026-03-07T07:55:00' AS DATETIME2),
        'The incident was traced to a duplicate gate pass from a prior-day drill. No unauthorized cargo movement occurred.',
        CAST('2026-03-07T14:25:00' AS DATETIME2),
        @contractor_gamma_id,
        NULL,
        NULL,
        CAST('2026-03-08T09:05:00' AS DATETIME2),
        @compliance_user_id,
        CAST('2026-03-08T09:05:00' AS DATETIME2)
    UNION ALL
    SELECT
        'Niger Atlantic Developers Ltd',
        'Jetty Development Block 4',
        'Lifting Plan Deviation',
        'Critical',
        'A critical deviation from the approved lifting plan was observed during jetty utility trench works.',
        'Open',
        CAST('2026-03-15T09:20:00' AS DATETIME2),
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        CAST('2026-03-15T09:20:00' AS DATETIME2)
)
INSERT INTO dbo.incidents (
    company_id,
    asset_id,
    company_name,
    incident_type,
    severity,
    description,
    reported_by,
    reported_by_user_id,
    status,
    reported_date,
    follow_up_note,
    follow_up_submitted_at,
    follow_up_submitted_by_user_id,
    resolved_at,
    resolved_by_user_id,
    closed_at,
    closed_by_user_id,
    updated_at
)
SELECT
    c.id,
    a.id,
    s.company_name,
    s.incident_type,
    s.severity,
    s.description,
    'Sarah Compliance',
    @compliance_user_id,
    s.status,
    s.reported_date,
    s.follow_up_note,
    s.follow_up_submitted_at,
    s.follow_up_submitted_by_user_id,
    s.resolved_at,
    s.resolved_by_user_id,
    s.closed_at,
    s.closed_by_user_id,
    s.updated_at
FROM incident_seed s
INNER JOIN dbo.companies c
    ON c.name = s.company_name
INNER JOIN dbo.assets a
    ON a.asset_name = s.asset_name
   AND a.company_id = c.id;

INSERT INTO dbo.incident_events (
    incident_id,
    event_type,
    actor_user_id,
    actor_name,
    actor_role,
    from_status,
    to_status,
    note,
    created_at
)
SELECT
    i.id,
    e.event_type,
    e.actor_user_id,
    e.actor_name,
    e.actor_role,
    e.from_status,
    e.to_status,
    e.note,
    e.created_at
FROM dbo.incidents i
INNER JOIN (
    SELECT 'Onne Marine Services Ltd' AS company_name, 'Fuel Spill' AS incident_type, 'IncidentLogged' AS event_type, @compliance_user_id AS actor_user_id, 'Sarah Compliance' AS actor_name, 'Compliance' AS actor_role, NULL AS from_status, 'Open' AS to_status, 'Minor fuel spill observed around the berth crane refuelling point during vessel support operations.' AS note, CAST('2026-03-12T10:15:00' AS DATETIME2) AS created_at UNION ALL
    SELECT 'Delta Fabrication & Logistics Ltd', 'Pressure Alarm', 'IncidentLogged', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'A high-pressure alarm was triggered during hydraulic gantry testing and the incident was logged for review.', CAST('2026-03-13T08:50:00' AS DATETIME2) UNION ALL
    SELECT 'Delta Fabrication & Logistics Ltd', 'Pressure Alarm', 'FollowUpSubmitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', 'Open', 'Open', 'The alarm occurred during a planned pressure test and the unit has since returned to safe operating parameters. Supporting calibration sheets have been uploaded.', CAST('2026-03-14T12:10:00' AS DATETIME2) UNION ALL
    SELECT 'Brass Offshore Calibration Ltd', 'Gas Leak Alert', 'IncidentLogged', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'A minor calibration gas leak alert was recorded inside the calibration lab during a routine verification cycle.', CAST('2026-03-09T14:35:00' AS DATETIME2) UNION ALL
    SELECT 'Brass Offshore Calibration Ltd', 'Gas Leak Alert', 'FollowUpSubmitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', 'Open', 'Open', 'The leaking regulator was replaced, the area was ventilated, and fresh calibration gas cylinders were commissioned.', CAST('2026-03-10T09:15:00' AS DATETIME2) UNION ALL
    SELECT 'Brass Offshore Calibration Ltd', 'Gas Leak Alert', 'Resolved', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Open', 'Resolved', 'Contractor follow-up was accepted and the incident was resolved.', CAST('2026-03-11T11:40:00' AS DATETIME2) UNION ALL
    SELECT 'Eko Support Logistics Hub Ltd', 'Access Control Breach', 'IncidentLogged', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'An access control breach was reported when a non-cleared vendor vehicle entered the export staging dock area.', CAST('2026-03-07T07:55:00' AS DATETIME2) UNION ALL
    SELECT 'Eko Support Logistics Hub Ltd', 'Access Control Breach', 'FollowUpSubmitted', @contractor_gamma_id, 'Taylor Briggs', 'Contractor', 'Open', 'Open', 'The incident was traced to a duplicate gate pass from a prior-day drill. No unauthorized cargo movement occurred.', CAST('2026-03-07T14:25:00' AS DATETIME2) UNION ALL
    SELECT 'Eko Support Logistics Hub Ltd', 'Access Control Breach', 'Closed', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Open', 'Closed', 'The follow-up confirmed the report was logged against a drill-related duplicate pass, so the incident was closed.', CAST('2026-03-08T09:05:00' AS DATETIME2) UNION ALL
    SELECT 'Niger Atlantic Developers Ltd', 'Lifting Plan Deviation', 'IncidentLogged', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'A critical deviation from the approved lifting plan was observed during jetty utility trench works.', CAST('2026-03-15T09:20:00' AS DATETIME2)
) e
    ON i.company_name = e.company_name
   AND i.incident_type = e.incident_type;

INSERT INTO dbo.trade_operation_requests (
    request_reference,
    company_id,
    service_family,
    service_type,
    status,
    goods_description,
    cargo_category,
    origin_location,
    destination_location,
    quantity_value,
    quantity_unit,
    weight_kg,
    container_count,
    shipment_reference,
    customs_reference,
    operation_summary,
    requested_completion_date,
    submitted_by_user_id,
    submitted_at,
    reviewed_at,
    reviewed_by_user_id,
    returned_at,
    returned_by_user_id,
    resubmitted_at,
    approved_at,
    rejected_at,
    rejected_by_user_id,
    query_note,
    rejection_reason,
    created_at,
    updated_at
)
SELECT
    s.request_reference,
    c.id,
    s.service_family,
    s.service_type,
    s.status,
    s.goods_description,
    s.cargo_category,
    s.origin_location,
    s.destination_location,
    s.quantity_value,
    s.quantity_unit,
    s.weight_kg,
    s.container_count,
    s.shipment_reference,
    s.customs_reference,
    s.operation_summary,
    s.requested_completion_date,
    s.submitted_by_user_id,
    s.submitted_at,
    s.reviewed_at,
    s.reviewed_by_user_id,
    s.returned_at,
    s.returned_by_user_id,
    s.resubmitted_at,
    s.approved_at,
    s.rejected_at,
    s.rejected_by_user_id,
    s.query_note,
    s.rejection_reason,
    s.created_at,
    s.updated_at
FROM (
    SELECT 'TOR-DEMO-001' AS request_reference, 'Onne Marine Services Ltd' AS company_name, 'inbound_cargo_movement' AS service_family, 'sea_freight' AS service_type, 'Approved' AS status, 'Inbound marine cargo for vessel support operations.' AS goods_description, 'Marine support cargo' AS cargo_category, 'Tin Can Port, Lagos' AS origin_location, 'Onne Oil & Gas Free Zone Area, Rivers State' AS destination_location, CAST(20.00 AS DECIMAL(18,2)) AS quantity_value, 'Freight Tons' AS quantity_unit, CAST(18500.00 AS DECIMAL(18,2)) AS weight_kg, 2 AS container_count, 'BL-ONNE-001' AS shipment_reference, 'CUS-ONNE-SEA-001' AS customs_reference, 'Request inward transfer of marine support cargo into the zone after manifest capture and customs transfer approval.' AS operation_summary, CAST('2026-03-16' AS DATE) AS requested_completion_date, @contractor_alpha_id AS submitted_by_user_id, CAST('2026-03-01T09:25:00' AS DATETIME2) AS submitted_at, CAST('2026-03-02T11:40:00' AS DATETIME2) AS reviewed_at, @compliance_user_id AS reviewed_by_user_id, NULL AS returned_at, NULL AS returned_by_user_id, NULL AS resubmitted_at, CAST('2026-03-02T11:40:00' AS DATETIME2) AS approved_at, NULL AS rejected_at, NULL AS rejected_by_user_id, NULL AS query_note, NULL AS rejection_reason, CAST('2026-03-01T09:25:00' AS DATETIME2) AS created_at, CAST('2026-03-02T11:40:00' AS DATETIME2) AS updated_at UNION ALL
    SELECT 'TOR-DEMO-002', 'Delta Fabrication & Logistics Ltd', 'processing_value_addition', 'processing_value_addition', 'Approved', 'Processed structural modules and value-added fabrication outputs for export delivery.', 'Processed fabricated modules', 'Delta Fabrication Bay 02', 'Approved customs territory release channel', CAST(12.00 AS DECIMAL(18,2)), 'Batches', CAST(9400.00 AS DECIMAL(18,2)), 1, 'PV-DELTA-002', 'CUS-DELTA-PROCESS-002', 'Request confirmation of processed goods and value-added outputs after fabrication and customs documentation.', CAST('2026-03-14' AS DATE), @contractor_alpha_id, CAST('2026-03-03T10:10:00' AS DATETIME2), CAST('2026-03-04T15:05:00' AS DATETIME2), @compliance_user_id, NULL, NULL, NULL, CAST('2026-03-04T15:05:00' AS DATETIME2), NULL, NULL, NULL, NULL, CAST('2026-03-03T10:10:00' AS DATETIME2), CAST('2026-03-04T15:05:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-003', 'Brass Offshore Calibration Ltd', 'inbound_cargo_movement', 'road_import', 'Returned', 'Road import of calibration tooling, master gauges, and control valves.', 'Calibration tools', 'Port Harcourt bonded terminal', 'Brass Oil & Gas Free Zone Area, Bayelsa State', CAST(16.00 AS DECIMAL(18,2)), 'Freight Tons', CAST(12400.00 AS DECIMAL(18,2)), 1, 'WB-BRASS-003', 'CUS-BRASS-ROAD-003', 'Request road import movement into Brass Free Zone for calibration lab expansion and equipment readiness.', CAST('2026-03-18' AS DATE), @contractor_beta_id, CAST('2026-03-04T08:15:00' AS DATETIME2), CAST('2026-03-05T13:20:00' AS DATETIME2), @compliance_user_id, CAST('2026-03-05T13:20:00' AS DATETIME2), @compliance_user_id, NULL, NULL, NULL, NULL, 'Please attach the attested waybill endorsed by Customs and correct the tonnage declaration.', NULL, CAST('2026-03-04T08:15:00' AS DATETIME2), CAST('2026-03-05T13:20:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-004', 'Eko Support Logistics Hub Ltd', 'outbound_release', 'export_by_sea', 'Submitted', 'Overseas export of consolidated logistics spares and vessel support kits.', 'Export staging cargo', 'Eko Support Free Zone Area, Lagos State', 'Apapa Port Export Gate, Lagos', CAST(8.00 AS DECIMAL(18,2)), 'Containers', CAST(21000.00 AS DECIMAL(18,2)), 3, 'EXP-EKO-004', 'CUS-EKO-EXPORT-004', 'Request final export release for consolidated cargo staged for overseas dispatch by sea.', CAST('2026-03-20' AS DATE), @contractor_gamma_id, CAST('2026-03-13T12:10:00' AS DATETIME2), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST('2026-03-13T12:10:00' AS DATETIME2), CAST('2026-03-13T12:10:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-005', 'Onne Marine Services Ltd', 'transfers_temporary_movement', 'transfer_between_licensees', 'Approved', 'Transfer of vessel support parts between licensed service providers inside the zone.', 'Internal transfer cargo', 'Onne Service Yard A', 'Onne Service Yard C', CAST(5.00 AS DECIMAL(18,2)), 'Consignments', CAST(2800.00 AS DECIMAL(18,2)), 0, 'TRF-ONNE-005', 'CUS-ONNE-TRANSFER-005', 'Request transfer of vessel support spares between licensees within Onne Free Zone.', CAST('2026-03-12' AS DATE), @contractor_alpha_id, CAST('2026-03-08T14:05:00' AS DATETIME2), CAST('2026-03-09T09:10:00' AS DATETIME2), @compliance_user_id, NULL, NULL, NULL, CAST('2026-03-09T09:10:00' AS DATETIME2), NULL, NULL, NULL, NULL, CAST('2026-03-08T14:05:00' AS DATETIME2), CAST('2026-03-09T09:10:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-006', 'Delta Fabrication & Logistics Ltd', 'cargo_handling_customs_control', 'examination_assessment', 'Rejected', 'Immediate-use release request for fabrication consumables pending customs examination.', 'Fabrication consumables', 'Onne Bonded Yard', 'Delta Fabrication & Logistics Ltd', CAST(3.00 AS DECIMAL(18,2)), 'Shipments', CAST(5400.00 AS DECIMAL(18,2)), 1, 'EXM-DELTA-006', 'CUS-DELTA-EXAM-006', 'Request examination and assessment for fabrication consumables needed for immediate use in the fabrication bay.', CAST('2026-03-12' AS DATE), @contractor_alpha_id, CAST('2026-03-08T10:30:00' AS DATETIME2), CAST('2026-03-09T16:00:00' AS DATETIME2), @compliance_user_id, NULL, NULL, NULL, NULL, CAST('2026-03-09T16:00:00' AS DATETIME2), @compliance_user_id, NULL, 'Duty payment receipt submitted does not reconcile with the declared shipment value.', CAST('2026-03-08T10:30:00' AS DATETIME2), CAST('2026-03-09T16:00:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-007', 'Brass Offshore Calibration Ltd', 'inbound_cargo_movement', 'air_freight', 'Submitted', 'Air freight request for calibration gas, precision gauges, and portable testing kits.', 'Calibration imports', 'Murtala Muhammed Airport Cargo Terminal, Lagos', 'Brass Oil & Gas Free Zone Area, Bayelsa State', CAST(700.00 AS DECIMAL(18,2)), 'Kilograms', CAST(700.00 AS DECIMAL(18,2)), 0, 'AWB-BRASS-007', 'CUS-BRASS-AIR-007', 'Request inward air freight transfer of calibration gas cylinders and precision tools into Brass Free Zone.', CAST('2026-03-19' AS DATE), @contractor_beta_id, CAST('2026-03-14T08:45:00' AS DATETIME2), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST('2026-03-14T08:45:00' AS DATETIME2), CAST('2026-03-14T08:45:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-008', 'Eko Support Logistics Hub Ltd', 'transfers_temporary_movement', 'temporary_movement', 'Returned', 'Temporary movement request for outbound maintenance skids to customs territory for repair.', 'Temporary movement cargo', 'Eko Support Free Zone Area, Lagos State', 'Ikeja Industrial Repair Cluster, Lagos', CAST(2.00 AS DECIMAL(18,2)), 'Transactions', CAST(1800.00 AS DECIMAL(18,2)), 0, 'TMP-EKO-008', 'CUS-EKO-TEMP-008', 'Request temporary movement of damaged export staging skids to the customs territory under bond for repair and return.', CAST('2026-03-21' AS DATE), @contractor_gamma_id, CAST('2026-03-15T10:20:00' AS DATETIME2), CAST('2026-03-15T15:10:00' AS DATETIME2), @compliance_user_id, CAST('2026-03-15T15:10:00' AS DATETIME2), @compliance_user_id, NULL, NULL, NULL, NULL, 'Please provide the signed free zone bond reference and clarify the proposed return date.', NULL, CAST('2026-03-15T10:20:00' AS DATETIME2), CAST('2026-03-15T15:10:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-009', 'Delta Fabrication & Logistics Ltd', 'outbound_release', 'export_by_air', 'Approved', 'Export by air request for fabricated critical spares and lightweight modular assemblies.', 'Export cargo', 'Delta Fabrication & Logistics Ltd', 'Murtala Muhammed Airport Cargo Terminal, Lagos', CAST(4.00 AS DECIMAL(18,2)), 'Shipments', CAST(1350.00 AS DECIMAL(18,2)), 0, 'EXP-DELTA-009', 'CUS-DELTA-AIR-009', 'Request overseas export release by air for fabricated critical spares under urgent delivery terms.', CAST('2026-03-17' AS DATE), @contractor_alpha_id, CAST('2026-03-10T09:40:00' AS DATETIME2), CAST('2026-03-11T12:25:00' AS DATETIME2), @compliance_user_id, NULL, NULL, NULL, CAST('2026-03-11T12:25:00' AS DATETIME2), NULL, NULL, NULL, NULL, CAST('2026-03-10T09:40:00' AS DATETIME2), CAST('2026-03-11T12:25:00' AS DATETIME2)
) s
INNER JOIN dbo.companies c
    ON c.name = s.company_name;

;WITH trade_document_seed AS (
    SELECT 'TOR-DEMO-001' AS request_reference, 'commercial_invoice' AS document_type UNION ALL
    SELECT 'TOR-DEMO-001', 'bill_of_lading' UNION ALL
    SELECT 'TOR-DEMO-001', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-001', 'attested_invoice_c16' UNION ALL
    SELECT 'TOR-DEMO-002', 'duty_tariff_rebate_certificate' UNION ALL
    SELECT 'TOR-DEMO-002', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-002', 'bill_of_lading_or_airway_bill' UNION ALL
    SELECT 'TOR-DEMO-002', 'transloading_or_transfer_approval' UNION ALL
    SELECT 'TOR-DEMO-002', 'commercial_invoice' UNION ALL
    SELECT 'TOR-DEMO-002', 'attested_invoice_c16' UNION ALL
    SELECT 'TOR-DEMO-002', 'minuted_customs_unstuffing_approval' UNION ALL
    SELECT 'TOR-DEMO-002', 'free_zone_waybill' UNION ALL
    SELECT 'TOR-DEMO-002', 'final_invoice' UNION ALL
    SELECT 'TOR-DEMO-002', 'free_zone_ccvo' UNION ALL
    SELECT 'TOR-DEMO-002', 'duty_rebate_spreadsheet' UNION ALL
    SELECT 'TOR-DEMO-003', 'commercial_invoice' UNION ALL
    SELECT 'TOR-DEMO-003', 'waybill' UNION ALL
    SELECT 'TOR-DEMO-003', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-004', 'commercial_invoice' UNION ALL
    SELECT 'TOR-DEMO-004', 'bill_of_lading' UNION ALL
    SELECT 'TOR-DEMO-004', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-004', 'export_declaration_form' UNION ALL
    SELECT 'TOR-DEMO-005', 'bill_of_lading_or_airway_bill' UNION ALL
    SELECT 'TOR-DEMO-005', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-005', 'customs_approval' UNION ALL
    SELECT 'TOR-DEMO-006', 'bill_of_lading_or_airway_bill' UNION ALL
    SELECT 'TOR-DEMO-006', 'c16_invoice' UNION ALL
    SELECT 'TOR-DEMO-006', 'form_m' UNION ALL
    SELECT 'TOR-DEMO-006', 'paar' UNION ALL
    SELECT 'TOR-DEMO-006', 'commercial_invoice' UNION ALL
    SELECT 'TOR-DEMO-006', 'declaration_form' UNION ALL
    SELECT 'TOR-DEMO-006', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-006', 'transfer_approval' UNION ALL
    SELECT 'TOR-DEMO-006', 'duty_payment_receipt' UNION ALL
    SELECT 'TOR-DEMO-007', 'commercial_invoice' UNION ALL
    SELECT 'TOR-DEMO-007', 'airway_bill' UNION ALL
    SELECT 'TOR-DEMO-007', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-008', 'commercial_invoice' UNION ALL
    SELECT 'TOR-DEMO-008', 'free_zone_bond' UNION ALL
    SELECT 'TOR-DEMO-008', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-008', 'free_zone_waybill_or_shipping_doc' UNION ALL
    SELECT 'TOR-DEMO-008', 'transfer_approval' UNION ALL
    SELECT 'TOR-DEMO-009', 'commercial_invoice' UNION ALL
    SELECT 'TOR-DEMO-009', 'airway_bill' UNION ALL
    SELECT 'TOR-DEMO-009', 'packing_list' UNION ALL
    SELECT 'TOR-DEMO-009', 'export_declaration_form'
)
INSERT INTO dbo.trade_operation_request_documents (
    request_id,
    document_type,
    file_name,
    created_at,
    updated_at
)
SELECT
    r.id,
    d.document_type,
    CONCAT('trade_', RIGHT('000' + CAST(r.id AS VARCHAR(10)), 3), '_', d.document_type, '.pdf'),
    DATEADD(MINUTE, 15, r.submitted_at),
    DATEADD(MINUTE, 15, r.submitted_at)
FROM trade_document_seed d
INNER JOIN dbo.trade_operation_requests r
    ON r.request_reference = d.request_reference;

INSERT INTO dbo.trade_operation_request_events (
    request_id,
    event_type,
    actor_user_id,
    actor_name,
    actor_role,
    from_status,
    to_status,
    note,
    metadata_json,
    created_at
)
SELECT
    r.id,
    e.event_type,
    e.actor_user_id,
    e.actor_name,
    e.actor_role,
    e.from_status,
    e.to_status,
    e.note,
    NULL,
    e.created_at
FROM dbo.trade_operation_requests r
INNER JOIN (
    SELECT 'TOR-DEMO-001' AS request_reference, 'Submitted' AS event_type, @contractor_alpha_id AS actor_user_id, 'Morgan Reed' AS actor_name, 'Contractor' AS actor_role, NULL AS from_status, 'Submitted' AS to_status, 'Sea freight request submitted with complete documentation.' AS note, CAST('2026-03-01T09:25:00' AS DATETIME2) AS created_at UNION ALL
    SELECT 'TOR-DEMO-001', 'Approved', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Approved', 'Compliance confirmed all inbound sea freight documents and approved the request.', CAST('2026-03-02T11:40:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-002', 'Submitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', NULL, 'Submitted', 'Processing/value addition request submitted for compliance review.', CAST('2026-03-03T10:10:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-002', 'Approved', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Approved', 'Compliance approved the processing/value addition request after reviewing the duty rebate documents.', CAST('2026-03-04T15:05:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-003', 'Submitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', NULL, 'Submitted', 'Road import request submitted for customs transfer processing.', CAST('2026-03-04T08:15:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-003', 'ReturnedForRevision', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Returned', 'Please attach the attested waybill endorsed by Customs and correct the tonnage declaration.', CAST('2026-03-05T13:20:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-004', 'Submitted', @contractor_gamma_id, 'Taylor Briggs', 'Contractor', NULL, 'Submitted', 'Export by sea request submitted and awaiting compliance review.', CAST('2026-03-13T12:10:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-005', 'Submitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', NULL, 'Submitted', 'Transfer between licensees request submitted with customs approval.', CAST('2026-03-08T14:05:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-005', 'Approved', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Approved', 'Compliance approved the internal transfer between licensees.', CAST('2026-03-09T09:10:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-006', 'Submitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', NULL, 'Submitted', 'Examination and assessment request submitted for immediate-use release.', CAST('2026-03-08T10:30:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-006', 'Rejected', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Rejected', 'Duty payment receipt submitted does not reconcile with the declared shipment value.', CAST('2026-03-09T16:00:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-007', 'Submitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', NULL, 'Submitted', 'Air freight request submitted with airway bill and commercial invoice.', CAST('2026-03-14T08:45:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-008', 'Submitted', @contractor_gamma_id, 'Taylor Briggs', 'Contractor', NULL, 'Submitted', 'Temporary movement request submitted under bond for repair and return.', CAST('2026-03-15T10:20:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-008', 'ReturnedForRevision', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Returned', 'Please provide the signed free zone bond reference and clarify the proposed return date.', CAST('2026-03-15T15:10:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-009', 'Submitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', NULL, 'Submitted', 'Export by air request submitted for urgent fabricated spares.', CAST('2026-03-10T09:40:00' AS DATETIME2) UNION ALL
    SELECT 'TOR-DEMO-009', 'Approved', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Submitted', 'Approved', 'Compliance approved the export by air request after reviewing the export declaration pack.', CAST('2026-03-11T12:25:00' AS DATETIME2)
) e
    ON r.request_reference = e.request_reference;

INSERT INTO dbo.company_compliance_cases (
    company_id,
    case_type,
    title,
    document_type,
    severity,
    request_note,
    status,
    due_date,
    requested_by_user_id,
    requested_at,
    contractor_response_note,
    contractor_response_file_name,
    contractor_response_submitted_at,
    contractor_response_submitted_by_user_id,
    review_note,
    returned_at,
    returned_by_user_id,
    resolved_at,
    resolved_by_user_id,
    closed_at,
    closed_by_user_id,
    updated_at,
    legacy_compliance_id
)
SELECT
    c.id,
    s.case_type,
    s.title,
    s.document_type,
    s.severity,
    s.request_note,
    s.status,
    s.due_date,
    @compliance_user_id,
    s.requested_at,
    s.contractor_response_note,
    s.contractor_response_file_name,
    s.contractor_response_submitted_at,
    s.contractor_response_submitted_by_user_id,
    s.review_note,
    s.returned_at,
    s.returned_by_user_id,
    s.resolved_at,
    s.resolved_by_user_id,
    s.closed_at,
    s.closed_by_user_id,
    s.updated_at,
    NULL
FROM (
    SELECT 'Delta Fabrication & Logistics Ltd', 'DocumentUpdate', 'Upload Updated Insurance Certificate', 'Insurance Certificate', 'Medium', 'Provide the updated all-risk insurance certificate for the fabrication bay and bonded yard.', 'Response Submitted', CAST('2026-03-20' AS DATE), CAST('2026-03-11T13:20:00' AS DATETIME2), 'Updated insurance certificate has been attached with the new policy endorsement for the fabrication bay and export yard.', 'delta_fabrication_insurance_2026.pdf', CAST('2026-03-14T10:05:00' AS DATETIME2), @contractor_alpha_id, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST('2026-03-14T10:05:00' AS DATETIME2) UNION ALL
    SELECT 'Brass Offshore Calibration Ltd', 'AuditFinding', 'Close Out Calibration Lab Ventilation Finding', NULL, 'High', 'Respond to the audit finding on calibration gas ventilation controls and provide evidence of corrective action.', 'Returned', CAST('2026-03-14' AS DATE), CAST('2026-03-08T09:40:00' AS DATETIME2), 'Ventilation fans were serviced and the gas cylinder rack was repositioned. Attached is the maintenance close-out note.', 'brass_ventilation_closeout_note.pdf', CAST('2026-03-11T10:35:00' AS DATETIME2), @contractor_beta_id, 'The response is helpful, but the calibration lab layout sketch is still missing. Re-submit with the marked-up ventilation layout.', CAST('2026-03-12T16:10:00' AS DATETIME2), @compliance_user_id, NULL, NULL, NULL, NULL, CAST('2026-03-12T16:10:00' AS DATETIME2) UNION ALL
    SELECT 'Niger Atlantic Developers Ltd', 'AuditFinding', 'Resolve Drainage Channel Housekeeping Finding', NULL, 'Low', 'Submit evidence that the development yard drainage channels were cleaned and re-marked after the audit inspection.', 'Resolved', CAST('2026-03-12' AS DATE), CAST('2026-03-05T10:00:00' AS DATETIME2), 'Drainage channels were cleaned, remarking was completed, and attached photos show the close-out condition.', 'niger_atlantic_drainage_closeout.zip', CAST('2026-03-09T15:15:00' AS DATETIME2), @contractor_beta_id, 'Corrective action accepted. The drainage finding is resolved.', NULL, NULL, CAST('2026-03-10T12:20:00' AS DATETIME2), @compliance_user_id, NULL, NULL, CAST('2026-03-10T12:20:00' AS DATETIME2) UNION ALL
    SELECT 'Eko Support Logistics Hub Ltd', 'DocumentUpdate', 'Remove Duplicate Document Refresh Request', 'Warehouse Layout', 'Low', 'A refreshed warehouse layout file was requested during periodic compliance review.', 'Closed', CAST('2026-03-06' AS DATE), CAST('2026-03-04T08:30:00' AS DATETIME2), NULL, NULL, NULL, NULL, 'The request was logged against a document already refreshed in the prior quarter and has been closed.', NULL, NULL, NULL, NULL, CAST('2026-03-05T11:10:00' AS DATETIME2), @compliance_user_id, CAST('2026-03-05T11:10:00' AS DATETIME2) UNION ALL
    SELECT 'Delta Fabrication & Logistics Ltd', 'AuditFinding', 'Address Hot Work Permit Register Gaps', NULL, 'High', 'Provide corrective action for the gaps identified in the fabrication bay hot-work permit register and supervisor sign-off controls.', 'Open', CAST('2026-03-08' AS DATE), CAST('2026-03-01T09:00:00' AS DATETIME2), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST('2026-03-01T09:00:00' AS DATETIME2)
) s
INNER JOIN dbo.companies c
    ON c.name = s.company_name;

INSERT INTO dbo.company_compliance_case_events (
    case_id,
    event_type,
    actor_user_id,
    actor_name,
    actor_role,
    from_status,
    to_status,
    note,
    created_at
)
SELECT
    cc.id,
    e.event_type,
    e.actor_user_id,
    e.actor_name,
    e.actor_role,
    e.from_status,
    e.to_status,
    e.note,
    e.created_at
FROM dbo.company_compliance_cases cc
INNER JOIN (
    SELECT 'Upload Updated Insurance Certificate', 'CaseCreated', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'Provide the updated all-risk insurance certificate for the fabrication bay and bonded yard.', CAST('2026-03-11T13:20:00' AS DATETIME2) UNION ALL
    SELECT 'Upload Updated Insurance Certificate', 'ContractorResponseSubmitted', @contractor_alpha_id, 'Morgan Reed', 'Contractor', 'Open', 'Response Submitted', 'Updated insurance certificate has been attached with the new policy endorsement for the fabrication bay and export yard.', CAST('2026-03-14T10:05:00' AS DATETIME2) UNION ALL
    SELECT 'Close Out Calibration Lab Ventilation Finding', 'CaseCreated', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'Respond to the audit finding on calibration gas ventilation controls and provide evidence of corrective action.', CAST('2026-03-08T09:40:00' AS DATETIME2) UNION ALL
    SELECT 'Close Out Calibration Lab Ventilation Finding', 'ContractorResponseSubmitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', 'Open', 'Response Submitted', 'Ventilation fans were serviced and the gas cylinder rack was repositioned. Attached is the maintenance close-out note.', CAST('2026-03-11T10:35:00' AS DATETIME2) UNION ALL
    SELECT 'Close Out Calibration Lab Ventilation Finding', 'CaseReturned', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Response Submitted', 'Returned', 'The response is helpful, but the calibration lab layout sketch is still missing. Re-submit with the marked-up ventilation layout.', CAST('2026-03-12T16:10:00' AS DATETIME2) UNION ALL
    SELECT 'Resolve Drainage Channel Housekeeping Finding', 'CaseCreated', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'Submit evidence that the development yard drainage channels were cleaned and re-marked after the audit inspection.', CAST('2026-03-05T10:00:00' AS DATETIME2) UNION ALL
    SELECT 'Resolve Drainage Channel Housekeeping Finding', 'ContractorResponseSubmitted', @contractor_beta_id, 'Daniel Audu', 'Contractor', 'Open', 'Response Submitted', 'Drainage channels were cleaned, remarking was completed, and attached photos show the close-out condition.', CAST('2026-03-09T15:15:00' AS DATETIME2) UNION ALL
    SELECT 'Resolve Drainage Channel Housekeeping Finding', 'CaseResolved', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Response Submitted', 'Resolved', 'Corrective action accepted. The drainage finding is resolved.', CAST('2026-03-10T12:20:00' AS DATETIME2) UNION ALL
    SELECT 'Remove Duplicate Document Refresh Request', 'CaseCreated', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'A refreshed warehouse layout file was requested during periodic compliance review.', CAST('2026-03-04T08:30:00' AS DATETIME2) UNION ALL
    SELECT 'Remove Duplicate Document Refresh Request', 'CaseClosed', @compliance_user_id, 'Sarah Compliance', 'Compliance', 'Open', 'Closed', 'The request was logged against a document already refreshed in the prior quarter and has been closed.', CAST('2026-03-05T11:10:00' AS DATETIME2) UNION ALL
    SELECT 'Address Hot Work Permit Register Gaps', 'CaseCreated', @compliance_user_id, 'Sarah Compliance', 'Compliance', NULL, 'Open', 'Provide corrective action for the gaps identified in the fabrication bay hot-work permit register and supervisor sign-off controls.', CAST('2026-03-01T09:00:00' AS DATETIME2)
) e
    ON cc.title = e.title;

COMMIT;
