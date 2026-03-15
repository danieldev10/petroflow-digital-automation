import { useState } from 'react';
import {
    handleReviewTradeOperationRequest,
    handleSubmitTradeOperationRequest,
} from '../useAuthSessions';
import { createInitialTradeOperationForm } from '../appInitialState';
import type { SharedFormHookParams, TradeOperationForm } from '../../types/appFormTypes';

export function useTradeOperationForms({
    token,
    fetchData,
    actionLoading,
    setActionLoading,
}: SharedFormHookParams) {
    const [showTradeOperationModal, setShowTradeOperationModal] = useState(false);
    const [editingTradeOperationId, setEditingTradeOperationId] = useState<number | null>(null);
    const [newTradeOperation, setNewTradeOperation] = useState<TradeOperationForm>(
        createInitialTradeOperationForm()
    );

    const submitTradeOperationHandler = handleSubmitTradeOperationRequest(
        newTradeOperation,
        setShowTradeOperationModal,
        setNewTradeOperation,
        editingTradeOperationId,
        setEditingTradeOperationId,
        actionLoading,
        setActionLoading,
        token,
        fetchData
    );

    const reviewTradeOperationHandler = handleReviewTradeOperationRequest(
        actionLoading,
        setActionLoading,
        token,
        fetchData
    );

    return {
        showTradeOperationModal,
        setShowTradeOperationModal,
        editingTradeOperationId,
        setEditingTradeOperationId,
        newTradeOperation,
        setNewTradeOperation,
        submitTradeOperationHandler,
        reviewTradeOperationHandler,
    };
}
