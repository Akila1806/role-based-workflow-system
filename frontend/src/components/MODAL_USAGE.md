# Modal Component Usage Guide

## Overview
Beautiful, reusable modal popup component to replace browser's default `alert()` and `confirm()` dialogs.

## Features
- ✅ Success messages
- ❌ Error messages
- ⚠️ Warning messages
- ℹ️ Info messages
- 🔔 Confirmation dialogs
- 🎨 Dark mode support
- 📱 Mobile responsive
- ⌨️ Keyboard accessible (ESC to close)

## Quick Start

### 1. Import the hook and component
```jsx
import Modal from '../components/Modal';
import { useModal } from '../hooks/useModal';
```

### 2. Initialize in your component
```jsx
const { isOpen, modalConfig, closeModal, showSuccess, showError, showWarning, showInfo, showConfirm } = useModal();
```

### 3. Add Modal component to JSX
```jsx
<Modal
  isOpen={isOpen}
  onClose={closeModal}
  title={modalConfig.title}
  message={modalConfig.message}
  type={modalConfig.type}
  confirmText={modalConfig.confirmText}
  cancelText={modalConfig.cancelText}
  showCancel={modalConfig.showCancel}
  onConfirm={modalConfig.onConfirm}
/>
```

## Usage Examples

### Success Message
```jsx
showSuccess('Request created successfully!', 'Success');
```

### Error Message
```jsx
showError('Failed to save data. Please try again.', 'Error');
```

### Warning Message
```jsx
showWarning('This action cannot be undone.', 'Warning');
```

### Info Message
```jsx
showInfo('Your session will expire in 5 minutes.', 'Information');
```

### Confirmation Dialog
```jsx
showConfirm(
  'Are you sure you want to delete this item?',
  () => {
    // This function runs when user clicks "Confirm"
    deleteItem();
  },
  'Confirm Delete'
);
```

### Custom Modal
```jsx
showModal({
  type: 'warning',
  title: 'Custom Title',
  message: 'Custom message here',
  confirmText: 'Yes, Continue',
  cancelText: 'No, Go Back',
  showCancel: true,
  onConfirm: () => {
    // Custom action
  }
});
```

## Complete Example

```jsx
import { useState } from 'react';
import Modal from '../components/Modal';
import { useModal } from '../hooks/useModal';

const MyComponent = () => {
  const { isOpen, modalConfig, closeModal, showSuccess, showError, showConfirm } = useModal();
  const [loading, setLoading] = useState(false);

  const handleSave = async () => {
    setLoading(true);
    try {
      await saveData();
      showSuccess('Data saved successfully!', 'Success');
    } catch (error) {
      showError('Failed to save data.', 'Error');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = () => {
    showConfirm(
      'Are you sure you want to delete this?',
      async () => {
        try {
          await deleteData();
          showSuccess('Deleted successfully!');
        } catch (error) {
          showError('Failed to delete.');
        }
      },
      'Confirm Delete'
    );
  };

  return (
    <div>
      <Modal
        isOpen={isOpen}
        onClose={closeModal}
        title={modalConfig.title}
        message={modalConfig.message}
        type={modalConfig.type}
        confirmText={modalConfig.confirmText}
        cancelText={modalConfig.cancelText}
        showCancel={modalConfig.showCancel}
        onConfirm={modalConfig.onConfirm}
      />
      
      <button onClick={handleSave}>Save</button>
      <button onClick={handleDelete}>Delete</button>
    </div>
  );
};
```

## Modal Types
- `success` - Green checkmark icon
- `error` - Red alert icon
- `warning` - Orange warning icon
- `info` - Blue info icon (default)

## Props Reference

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| isOpen | boolean | false | Controls modal visibility |
| onClose | function | - | Called when modal closes |
| title | string | - | Modal title |
| message | string | - | Modal message content |
| type | string | 'info' | Modal type (success/error/warning/info) |
| confirmText | string | 'OK' | Confirm button text |
| cancelText | string | 'Cancel' | Cancel button text |
| showCancel | boolean | false | Show cancel button |
| onConfirm | function | null | Called when confirm clicked |

## Styling
The modal automatically adapts to your app's theme (light/dark mode) using CSS variables.

## Already Implemented In
- ✅ CreateRequest.jsx - Success/Error messages
- ✅ RequestDetail.jsx - Confirmation dialogs
- ✅ Login.jsx - Error messages

## Migration from alert()/confirm()

### Before:
```jsx
alert('Success!');
if (confirm('Are you sure?')) {
  deleteItem();
}
```

### After:
```jsx
showSuccess('Success!');
showConfirm('Are you sure?', () => deleteItem());
```
