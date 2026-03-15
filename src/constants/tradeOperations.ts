import { licenseTypeOptions, type LicenseType } from './companyApplication';

export const tradeOperationFamilyCatalog = {
    inbound_cargo_movement: {
        label: 'Inbound Cargo Movement',
        description: 'Bring goods into the Free Zone through sea, air, or road channels under the prescribed customs process.',
    },
    cargo_handling_customs_control: {
        label: 'Cargo Handling / Customs Control',
        description: 'Request inspection and customs examination services before release, use, or onward processing.',
    },
    outbound_release: {
        label: 'Outbound / Release',
        description: 'Move approved goods out of the Free Zone through sea or air export workflows.',
    },
    transfers_temporary_movement: {
        label: 'Transfers / Temporary Movement',
        description: 'Transfer goods between licensees or move them temporarily outside the Free Zone under customs supervision.',
    },
    processing_value_addition: {
        label: 'Processing / Value Addition',
        description: 'Process, assemble, or add value to goods in the Free Zone before release into the Customs Territory.',
    },
} as const;

export type TradeOperationFamilyKey = keyof typeof tradeOperationFamilyCatalog;

type TradeOperationDocumentDefinition = {
    label: string;
    description: string;
    placeholder: string;
    required?: boolean;
};

export const tradeOperationDocumentCatalog = {
    commercial_invoice: {
        label: 'Commercial Invoice',
        description: 'Provide the filename or reference for the commercial invoice attached to this request.',
        placeholder: 'e.g. commercial_invoice.pdf',
        required: true,
    },
    bill_of_lading: {
        label: 'Bill of Lading',
        description: 'Provide the filename or reference for the Bill of Lading.',
        placeholder: 'e.g. bill_of_lading.pdf',
        required: true,
    },
    bill_of_lading_or_airway_bill: {
        label: 'Bill of Lading / Airway Bill',
        description: 'Provide the filename or reference for the relevant Bill of Lading or Airway Bill.',
        placeholder: 'e.g. shipping_document.pdf',
        required: true,
    },
    packing_list: {
        label: 'Packing List',
        description: 'Provide the filename or reference for the packing list.',
        placeholder: 'e.g. packing_list.xlsx',
        required: true,
    },
    attested_invoice_c16: {
        label: 'Attested Invoice (Form C16)',
        description: 'Provide the filename or reference for the attested invoice / Form C16.',
        placeholder: 'e.g. form_c16.pdf',
        required: true,
    },
    airway_bill: {
        label: 'Airway Bill',
        description: 'Provide the filename or reference for the Airway Bill.',
        placeholder: 'e.g. airway_bill.pdf',
        required: true,
    },
    waybill: {
        label: 'Waybill',
        description: 'Provide the filename or reference for the road waybill.',
        placeholder: 'e.g. waybill.pdf',
        required: true,
    },
    c16_invoice: {
        label: 'C16 Invoice',
        description: 'Provide the filename or reference for the C16 invoice.',
        placeholder: 'e.g. c16_invoice.pdf',
        required: true,
    },
    form_m: {
        label: 'Form M',
        description: 'Provide the filename or reference for Form M.',
        placeholder: 'e.g. form_m.pdf',
        required: true,
    },
    paar: {
        label: 'PAAR',
        description: 'Provide the filename or reference for the PAAR document.',
        placeholder: 'e.g. paar.pdf',
        required: true,
    },
    declaration_form: {
        label: 'Declaration Form',
        description: 'Provide the filename or reference for the declaration form.',
        placeholder: 'e.g. declaration_form.pdf',
        required: true,
    },
    transfer_approval: {
        label: 'Customs Transfer Approval',
        description: 'Provide the filename or reference for the customs transfer approval.',
        placeholder: 'e.g. transfer_approval.pdf',
        required: true,
    },
    duty_payment_receipt: {
        label: 'E-Payment / Duty Payment Receipt',
        description: 'Provide the filename or reference for the e-payment or duty payment receipt.',
        placeholder: 'e.g. duty_payment_receipt.pdf',
        required: true,
    },
    export_declaration_form: {
        label: 'Export Declaration Form',
        description: 'Provide the filename or reference for the export declaration form.',
        placeholder: 'e.g. export_declaration_form.pdf',
        required: true,
    },
    customs_approval: {
        label: 'Customs Approval',
        description: 'Provide the filename or reference for the customs approval attached to the transfer request.',
        placeholder: 'e.g. customs_approval.pdf',
        required: true,
    },
    free_zone_bond: {
        label: 'Oil & Gas Free Zone Bond',
        description: 'Provide the filename or reference for the Oil & Gas Free Zone Bond.',
        placeholder: 'e.g. free_zone_bond.pdf',
        required: true,
    },
    free_zone_waybill_or_shipping_doc: {
        label: 'Airway Bill / Bill of Lading / Free Zone Waybill',
        description: 'Provide the filename or reference for the shipping document supporting the temporary movement request.',
        placeholder: 'e.g. free_zone_waybill.pdf',
        required: true,
    },
    duty_tariff_rebate_certificate: {
        label: 'Certificate for Import Duty Tariffs Rebate of 75%',
        description: 'Provide the filename or reference for the 75% duty tariff rebate certificate.',
        placeholder: 'e.g. duty_tariff_rebate_certificate.pdf',
        required: true,
    },
    transloading_or_transfer_approval: {
        label: 'Trans-loading and/or Transfer Approval',
        description: 'Provide the filename or reference for the trans-loading or transfer approval.',
        placeholder: 'e.g. transloading_transfer_approval.pdf',
        required: true,
    },
    minuted_customs_unstuffing_approval: {
        label: 'Minuted Customs Unstuffing Approval',
        description: 'Provide the filename or reference for the minuted customs unstuffing approval.',
        placeholder: 'e.g. customs_unstuffing_approval.pdf',
        required: true,
    },
    free_zone_waybill: {
        label: 'Free Zone Waybill',
        description: 'Provide the filename or reference for the Free Zone waybill.',
        placeholder: 'e.g. free_zone_waybill.pdf',
        required: true,
    },
    final_invoice: {
        label: 'Final Invoice',
        description: 'Provide the filename or reference for the final invoice after processing.',
        placeholder: 'e.g. final_invoice.pdf',
        required: true,
    },
    free_zone_ccvo: {
        label: 'Free Zone CCVO',
        description: 'Provide the filename or reference for the Free Zone Combined Certificate of Value and Origin.',
        placeholder: 'e.g. free_zone_ccvo.pdf',
        required: true,
    },
    duty_rebate_spreadsheet: {
        label: '75% Duty Rebate Spreadsheet',
        description: 'Provide the filename or reference for the 75% duty rebate spreadsheet.',
        placeholder: 'e.g. duty_rebate_spreadsheet.xlsx',
        required: true,
    },
} as const satisfies Record<string, TradeOperationDocumentDefinition>;

export type TradeOperationDocumentType = keyof typeof tradeOperationDocumentCatalog;

type TradeOperationServiceDefinition = {
    label: string;
    family: TradeOperationFamilyKey;
    description: string;
    timeline: string;
    feeGuidance: readonly string[];
    allowedLicenseTypes: readonly LicenseType[];
    documentTypes: readonly TradeOperationDocumentType[];
};

export const tradeOperationServiceCatalog = {
    sea_freight: {
        label: 'Sea Freight',
        family: 'inbound_cargo_movement',
        description: 'Request inward transfer of cargo into the Free Zone by sea after manifest capture and customs transfer approval.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            'Documentation - Transfer by Sea (General Cargo up to first 20 Freight Tons): $200 per Bill Lading',
            'Documentation - Transfer by Sea Bulk Cargo: $0.30 per Metric Ton',
        ],
        allowedLicenseTypes: licenseTypeOptions,
        documentTypes: [
            'commercial_invoice',
            'bill_of_lading',
            'packing_list',
            'attested_invoice_c16',
        ],
    },
    air_freight: {
        label: 'Air Freight',
        family: 'inbound_cargo_movement',
        description: 'Request inward transfer of cargo into the Free Zone by air after manifest capture and customs approval.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            'Inward Transfer 0-300kg: $3.5 per kg',
            'Inward Transfer 301-700kg: $3.0 per kg',
            'Inward Transfer 701-3,000kg: $2.5 per kg',
            'Inward Transfer 3,001-10,000kg: $1.5 per kg',
        ],
        allowedLicenseTypes: licenseTypeOptions,
        documentTypes: [
            'commercial_invoice',
            'airway_bill',
            'packing_list',
        ],
    },
    road_import: {
        label: 'Road Import',
        family: 'inbound_cargo_movement',
        description: 'Request import of goods into the Free Zone by road under customs escort and landing certificate reconciliation.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            'Documentation - Transfer by Road (General Cargo up to first 20 Freight Tons): $200 per Bill Lading',
            'Transfer by Road (First 20ft Container): $200 per Container; each additional 20ft container: $50',
            'Transfer by Road (First 40ft Container): $400 per Container; each additional 40ft container: $100',
            'Documentation - Transfer by Road Bulk Cargo: $0.30 per Metric Ton',
        ],
        allowedLicenseTypes: licenseTypeOptions,
        documentTypes: [
            'commercial_invoice',
            'waybill',
            'packing_list',
        ],
    },
    examination_assessment: {
        label: 'Examination / Assessment',
        family: 'cargo_handling_customs_control',
        description: 'Request examination, assessment, valuation, and immediate-use release processing for Free Zone goods.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            'Delivery Documentation - Import by Air: $250 per AWB',
            'Delivery Documentation - Import by Sea: $250 per Bill Lading',
            'Customs Examination: $100 per BL/AWB',
        ],
        allowedLicenseTypes: licenseTypeOptions,
        documentTypes: [
            'bill_of_lading_or_airway_bill',
            'c16_invoice',
            'form_m',
            'paar',
            'commercial_invoice',
            'declaration_form',
            'packing_list',
            'transfer_approval',
            'duty_payment_receipt',
        ],
    },
    export_by_sea: {
        label: 'Export by Sea',
        family: 'outbound_release',
        description: 'Request overseas export of goods from the Free Zone by sea after customs examination and release.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            'Export Documentation by Sea: $250',
            'Customs Examination: $100',
        ],
        allowedLicenseTypes: [
            'Free Zone Service Licence',
            'Free Zone Enterprise Licence',
            'Free Zone Enterprise - Special Activity Licence',
        ],
        documentTypes: [
            'commercial_invoice',
            'bill_of_lading',
            'packing_list',
            'export_declaration_form',
        ],
    },
    export_by_air: {
        label: 'Export by Air',
        family: 'outbound_release',
        description: 'Request overseas export of goods from the Free Zone by air after customs examination and airport release approval.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            'Export Documentation by Air: $250',
            'Customs Examination: $100',
        ],
        allowedLicenseTypes: [
            'Free Zone Service Licence',
            'Free Zone Enterprise Licence',
            'Free Zone Enterprise - Special Activity Licence',
        ],
        documentTypes: [
            'commercial_invoice',
            'airway_bill',
            'packing_list',
            'export_declaration_form',
        ],
    },
    transfer_between_licensees: {
        label: 'Transfer Between Licensees',
        family: 'transfers_temporary_movement',
        description: 'Request transfer of goods between Free Zone licensees with customs approval and transaction request order control.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            '$100 per BL/AWB',
        ],
        allowedLicenseTypes: licenseTypeOptions,
        documentTypes: [
            'bill_of_lading_or_airway_bill',
            'packing_list',
            'customs_approval',
        ],
    },
    temporary_movement: {
        label: 'Temporary Movement',
        family: 'transfers_temporary_movement',
        description: 'Request temporary movement of goods to the Customs Territory for a defined period under bond and customs release controls.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            '$500 per transaction',
        ],
        allowedLicenseTypes: licenseTypeOptions,
        documentTypes: [
            'commercial_invoice',
            'free_zone_bond',
            'packing_list',
            'free_zone_waybill_or_shipping_doc',
            'transfer_approval',
        ],
    },
    processing_value_addition: {
        label: 'Processing / Value Addition',
        family: 'processing_value_addition',
        description: 'Request approval for processing, value addition, and confirmation of processed goods within the Free Zone.',
        timeline: '48 hours on submission of service request and complete documentation.',
        feeGuidance: [
            'Processing of Goods in the Zone: $100 per Bill Lading/AWB',
            'Cancellation of Processing: $100 per Bill Lading/AWB',
            'Confirmation of Goods after Processing: $100 per Bill Lading/AWB',
            'Processing of Free Zone Waybill (FZWB): $100 each',
            'Processing of Combined Certificate of Value and Origin: $100 each',
        ],
        allowedLicenseTypes: [
            'Free Zone Enterprise Licence',
            'Free Zone Enterprise - Special Activity Licence',
        ],
        documentTypes: [
            'duty_tariff_rebate_certificate',
            'packing_list',
            'bill_of_lading_or_airway_bill',
            'transloading_or_transfer_approval',
            'commercial_invoice',
            'attested_invoice_c16',
            'minuted_customs_unstuffing_approval',
            'free_zone_waybill',
            'final_invoice',
            'free_zone_ccvo',
            'duty_rebate_spreadsheet',
        ],
    },
} as const satisfies Record<string, TradeOperationServiceDefinition>;

export type TradeOperationServiceType = keyof typeof tradeOperationServiceCatalog;

export type TradeOperationDocumentDraft = {
    documentType: TradeOperationDocumentType;
    fileName: string;
};

export const tradeOperationServiceOptions = Object.keys(
    tradeOperationServiceCatalog
) as TradeOperationServiceType[];

export const isKnownTradeOperationServiceType = (
    serviceType?: string | null,
): serviceType is TradeOperationServiceType => (
    Boolean(serviceType) &&
    tradeOperationServiceOptions.includes(serviceType as TradeOperationServiceType)
);

export const getTradeOperationService = (serviceType?: string | null) => {
    if (!isKnownTradeOperationServiceType(serviceType)) {
        return null;
    }

    return {
        serviceType,
        ...tradeOperationServiceCatalog[serviceType],
        familyLabel: tradeOperationFamilyCatalog[tradeOperationServiceCatalog[serviceType].family].label,
    };
};

export const getTradeOperationServicesForLicense = (licenseType?: string | null) => (
    tradeOperationServiceOptions.filter((serviceType) => {
        const service = tradeOperationServiceCatalog[serviceType];
        const allowedLicenseTypes = service.allowedLicenseTypes as readonly LicenseType[];

        return Boolean(licenseType && allowedLicenseTypes.includes(licenseType as LicenseType));
    })
);

export const getTradeOperationFamiliesForLicense = (licenseType?: string | null) => {
    const allowedServices = new Set(getTradeOperationServicesForLicense(licenseType));

    return (Object.keys(tradeOperationFamilyCatalog) as TradeOperationFamilyKey[]).map((familyKey) => ({
        key: familyKey,
        ...tradeOperationFamilyCatalog[familyKey],
        services: tradeOperationServiceOptions
            .filter((serviceType) => tradeOperationServiceCatalog[serviceType].family === familyKey)
            .filter((serviceType) => allowedServices.has(serviceType))
            .map((serviceType) => ({
                serviceType,
                ...tradeOperationServiceCatalog[serviceType],
            })),
    }));
};

export const getTradeOperationDocumentRequirements = (serviceType?: string | null) => {
    const service = getTradeOperationService(serviceType);

    if (!service) {
        return [];
    }

    return service.documentTypes.map((documentType) => ({
        documentType,
        ...tradeOperationDocumentCatalog[documentType],
    }));
};

export const getTradeOperationServiceDocumentRequirements = getTradeOperationDocumentRequirements;

export const mergeTradeOperationDocuments = (
    serviceType?: string | null,
    existingDocuments: TradeOperationDocumentDraft[] = [],
) => {
    const existingByType = new Map(
        existingDocuments.map((document) => [document.documentType, document.fileName.trim()])
    );

    return getTradeOperationDocumentRequirements(serviceType).map((requirement) => ({
        documentType: requirement.documentType,
        fileName: existingByType.get(requirement.documentType) || '',
    }));
};
