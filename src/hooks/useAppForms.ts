import { useState } from 'react';
import { handleInviteUser, handleUpdateUserRole } from './useAuthSessions';
import { useCompanyForms } from './forms/useCompanyForms';
import { useIncidentForms } from './forms/useIncidentForms';
import { useOperationsForms } from './forms/useOperationsForms';
import { useTradeOperationForms } from './forms/useTradeOperationForms';

type UseAppFormsParams = {
    token: string | null;
    fetchData: () => Promise<void>;
};

export function useAppForms({ token, fetchData }: UseAppFormsParams) {
    const [actionLoading, setActionLoading] = useState(false);

    const sharedParams = {
        token,
        fetchData,
        actionLoading,
        setActionLoading,
    };

    const companyForms = useCompanyForms(sharedParams);
    const incidentForms = useIncidentForms(sharedParams);
    const operationsForms = useOperationsForms(sharedParams);
    const tradeOperationForms = useTradeOperationForms(sharedParams);

    const updateUserRoleHandler = handleUpdateUserRole(token, fetchData);
    const inviteUserHandler = handleInviteUser(token, fetchData);

    return {
        actionLoading,
        ...companyForms,
        ...incidentForms,
        ...operationsForms,
        ...tradeOperationForms,
        inviteUserHandler,
        updateUserRoleHandler,
    };
}
