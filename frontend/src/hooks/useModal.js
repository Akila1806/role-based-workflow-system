import { useState } from 'react';

export const useModal = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [modalConfig, setModalConfig] = useState({
    title: '',
    message: '',
    type: 'info',
    confirmText: 'OK',
    cancelText: 'Cancel',
    showCancel: false,
    onConfirm: null
  });

  const showModal = (config) => {
    setModalConfig({
      title: config.title || 'Notification',
      message: config.message || '',
      type: config.type || 'info',
      confirmText: config.confirmText || 'OK',
      cancelText: config.cancelText || 'Cancel',
      showCancel: config.showCancel || false,
      onConfirm: config.onConfirm || null
    });
    setIsOpen(true);
  };

  const closeModal = () => {
    setIsOpen(false);
  };

  // Helper methods for different types
  const showSuccess = (message, title = 'Success') => {
    showModal({ type: 'success', title, message });
  };

  const showError = (message, title = 'Error') => {
    showModal({ type: 'error', title, message });
  };

  const showWarning = (message, title = 'Warning') => {
    showModal({ type: 'warning', title, message });
  };

  const showInfo = (message, title = 'Information') => {
    showModal({ type: 'info', title, message });
  };

  const showConfirm = (message, onConfirm, title = 'Confirm') => {
    showModal({
      type: 'warning',
      title,
      message,
      showCancel: true,
      confirmText: 'Confirm',
      onConfirm
    });
  };

  return {
    isOpen,
    modalConfig,
    showModal,
    closeModal,
    showSuccess,
    showError,
    showWarning,
    showInfo,
    showConfirm
  };
};
