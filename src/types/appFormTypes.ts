import type { Dispatch, SetStateAction } from 'react';
import {
    createInitialCompanyApplicationForm,
    createInitialIncidentForm,
    createInitialOpsForm,
    createInitialTradeOperationForm,
} from '../hooks/appInitialState';

export type CompanyApplicationForm = ReturnType<typeof createInitialCompanyApplicationForm>;
export type TradeOperationForm = ReturnType<typeof createInitialTradeOperationForm>;
export type IncidentForm = ReturnType<typeof createInitialIncidentForm>;
export type OpsForm = ReturnType<typeof createInitialOpsForm>;

export type SharedFormHookParams = {
    token: string | null;
    fetchData: () => Promise<void>;
    actionLoading: boolean;
    setActionLoading: Dispatch<SetStateAction<boolean>>;
};

export type StringSetter = Dispatch<SetStateAction<string>>;
