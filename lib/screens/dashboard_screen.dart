import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Semantics(
            label: 'Logout button',
            child: IconButton(
              key: const Key('logout_button'),
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back, Admin! 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Choose a module to practice automation:',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),

            // Stats row
            Row(
              children: [
                _StatCard(key: const Key('stat_users'), label: 'Users', value: '128', icon: Icons.people, color: Colors.blue),
                const SizedBox(width: 16),
                _StatCard(key: const Key('stat_orders'), label: 'Orders', value: '54', icon: Icons.shopping_cart, color: Colors.green),
                const SizedBox(width: 16),
                _StatCard(key: const Key('stat_revenue'), label: 'Revenue', value: '\$9,200', icon: Icons.attach_money, color: Colors.orange),
                const SizedBox(width: 16),
                _StatCard(key: const Key('stat_issues'), label: 'Issues', value: '3', icon: Icons.bug_report, color: Colors.red),
              ],
            ),
            const SizedBox(height: 32),

            const Text('Practice Modules', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Navigation cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2,
                children: [
                  _NavCard(
                    key: const Key('nav_form'),
                    title: 'Form Elements',
                    subtitle: 'Text fields, dropdowns, checkboxes, radio buttons',
                    icon: Icons.edit_note,
                    color: Colors.purple,
                    onTap: () => Navigator.pushNamed(context, '/form'),
                  ),
                  _NavCard(
                    key: const Key('nav_table'),
                    title: 'Data Table',
                    subtitle: 'Sort, filter, paginate table data',
                    icon: Icons.table_chart,
                    color: Colors.teal,
                    onTap: () => Navigator.pushNamed(context, '/table'),
                  ),
                  _NavCard(
                    key: const Key('nav_alerts'),
                    title: 'Alerts & Dialogs',
                    subtitle: 'Popups, snackbars, confirmations',
                    icon: Icons.notifications_active,
                    color: Colors.amber,
                    onTap: () => Navigator.pushNamed(context, '/alerts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({super.key, required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(label, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _NavCard({super.key, required this.title, required this.subtitle, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
