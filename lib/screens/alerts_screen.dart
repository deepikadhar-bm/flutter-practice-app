import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _lastAction = 'None';

  void _setAction(String action) => setState(() => _lastAction = action);

  void _showSimpleDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        key: const Key('simple_dialog'),
        title: const Text('Information'),
        content: const Text('This is a simple alert dialog for automation practice.'),
        actions: [
          TextButton(
            key: const Key('dialog_ok_button'),
            onPressed: () {
              Navigator.pop(ctx);
              _setAction('Simple dialog OK clicked');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        key: const Key('confirm_dialog'),
        title: const Text('Confirm Action'),
        content: const Text('Are you sure you want to delete this item? This action cannot be undone.'),
        actions: [
          TextButton(
            key: const Key('dialog_cancel_button'),
            onPressed: () {
              Navigator.pop(ctx);
              _setAction('Confirm dialog Cancelled');
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            key: const Key('dialog_confirm_button'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(ctx);
              _setAction('Confirm dialog Confirmed');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showInputDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        key: const Key('input_dialog'),
        title: const Text('Enter Value'),
        content: TextField(
          key: const Key('dialog_input_field'),
          controller: controller,
          decoration: const InputDecoration(hintText: 'Type something...', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            key: const Key('dialog_input_cancel'),
            onPressed: () { Navigator.pop(ctx); _setAction('Input dialog cancelled'); },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            key: const Key('dialog_input_submit'),
            onPressed: () {
              Navigator.pop(ctx);
              _setAction('Input dialog value: "${controller.text}"');
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String type) {
    Color color;
    IconData icon;
    String message;
    switch (type) {
      case 'success':
        color = Colors.green; icon = Icons.check_circle; message = 'Operation completed successfully!';
        break;
      case 'error':
        color = Colors.red; icon = Icons.error; message = 'Something went wrong. Please try again.';
        break;
      case 'warning':
        color = Colors.orange; icon = Icons.warning; message = 'Please review your input carefully.';
        break;
      default:
        color = Colors.blue; icon = Icons.info; message = 'Here is some useful information.';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: Key('${type}_snackbar'),
        backgroundColor: color,
        content: Row(children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(message),
        ]),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {},
        ),
        duration: const Duration(seconds: 3),
      ),
    );
    _setAction('$type snackbar shown');
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => Padding(
        key: const Key('bottom_sheet'),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Bottom Sheet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('This is a modal bottom sheet. You can place forms or options here.'),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('bottom_sheet_close'),
              onPressed: () { Navigator.pop(ctx); _setAction('Bottom sheet closed'); },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
    _setAction('Bottom sheet opened');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts & Dialogs'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last action indicator
            Container(
              key: const Key('last_action'),
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: Text('Last Action: $_lastAction', style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 24),

            const Text('Dialogs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  key: const Key('simple_dialog_button'),
                  onPressed: _showSimpleDialog,
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Simple Dialog'),
                ),
                ElevatedButton.icon(
                  key: const Key('confirm_dialog_button'),
                  onPressed: _showConfirmDialog,
                  icon: const Icon(Icons.warning_amber_outlined),
                  label: const Text('Confirm Dialog'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                ),
                ElevatedButton.icon(
                  key: const Key('input_dialog_button'),
                  onPressed: _showInputDialog,
                  icon: const Icon(Icons.edit),
                  label: const Text('Input Dialog'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Snackbars', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  key: const Key('success_snackbar_button'),
                  onPressed: () => _showSnackbar('success'),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Success'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                ),
                ElevatedButton.icon(
                  key: const Key('error_snackbar_button'),
                  onPressed: () => _showSnackbar('error'),
                  icon: const Icon(Icons.error_outline),
                  label: const Text('Error'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                ),
                ElevatedButton.icon(
                  key: const Key('warning_snackbar_button'),
                  onPressed: () => _showSnackbar('warning'),
                  icon: const Icon(Icons.warning_amber_outlined),
                  label: const Text('Warning'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                ),
                ElevatedButton.icon(
                  key: const Key('info_snackbar_button'),
                  onPressed: () => _showSnackbar('info'),
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Info'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Other Components', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              key: const Key('bottom_sheet_button'),
              onPressed: _showBottomSheet,
              icon: const Icon(Icons.expand_less),
              label: const Text('Bottom Sheet'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
