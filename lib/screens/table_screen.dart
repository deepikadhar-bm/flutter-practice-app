import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final _searchController = TextEditingController();
  int _currentPage = 0;
  final int _rowsPerPage = 5;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  final List<Map<String, dynamic>> _allData = [
    {'id': 1, 'name': 'Alice Johnson', 'email': 'alice@example.com', 'role': 'Admin', 'status': 'Active'},
    {'id': 2, 'name': 'Bob Smith', 'email': 'bob@example.com', 'role': 'User', 'status': 'Inactive'},
    {'id': 3, 'name': 'Carol White', 'email': 'carol@example.com', 'role': 'Manager', 'status': 'Active'},
    {'id': 4, 'name': 'David Brown', 'email': 'david@example.com', 'role': 'User', 'status': 'Active'},
    {'id': 5, 'name': 'Eva Martinez', 'email': 'eva@example.com', 'role': 'Admin', 'status': 'Active'},
    {'id': 6, 'name': 'Frank Lee', 'email': 'frank@example.com', 'role': 'User', 'status': 'Inactive'},
    {'id': 7, 'name': 'Grace Kim', 'email': 'grace@example.com', 'role': 'Manager', 'status': 'Active'},
    {'id': 8, 'name': 'Henry Wilson', 'email': 'henry@example.com', 'role': 'User', 'status': 'Active'},
    {'id': 9, 'name': 'Iris Davis', 'email': 'iris@example.com', 'role': 'User', 'status': 'Inactive'},
    {'id': 10, 'name': 'Jack Thompson', 'email': 'jack@example.com', 'role': 'Admin', 'status': 'Active'},
    {'id': 11, 'name': 'Karen Anderson', 'email': 'karen@example.com', 'role': 'User', 'status': 'Active'},
    {'id': 12, 'name': 'Leo Garcia', 'email': 'leo@example.com', 'role': 'Manager', 'status': 'Active'},
  ];

  List<Map<String, dynamic>> get _filteredData {
    final query = _searchController.text.toLowerCase();
    var data = _allData.where((row) {
      return row['name'].toLowerCase().contains(query) ||
          row['email'].toLowerCase().contains(query) ||
          row['role'].toLowerCase().contains(query);
    }).toList();

    final keys = ['id', 'name', 'email', 'role', 'status'];
    data.sort((a, b) {
      final key = keys[_sortColumnIndex];
      final aVal = a[key].toString();
      final bVal = b[key].toString();
      return _sortAscending ? aVal.compareTo(bVal) : bVal.compareTo(aVal);
    });
    return data;
  }

  List<Map<String, dynamic>> get _pageData {
    final start = _currentPage * _rowsPerPage;
    final end = (start + _rowsPerPage).clamp(0, _filteredData.length);
    return _filteredData.sublist(start, end);
  }

  int get _totalPages => (_filteredData.length / _rowsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Users List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                SizedBox(
                  width: 300,
                  child: TextField(
                    key: const Key('search_field'),
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by name, email or role...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (_) => setState(() => _currentPage = 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Table
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  key: const Key('users_table'),
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  headingRowColor: WidgetStateProperty.all(Colors.indigo.shade50),
                  columns: [
                    _buildColumn('ID', 0),
                    _buildColumn('Name', 1),
                    _buildColumn('Email', 2),
                    _buildColumn('Role', 3),
                    _buildColumn('Status', 4),
                    const DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: _pageData.map((row) {
                    return DataRow(
                      key: ValueKey('row_${row['id']}'),
                      cells: [
                        DataCell(Text(row['id'].toString())),
                        DataCell(Text(row['name'])),
                        DataCell(Text(row['email'])),
                        DataCell(Text(row['role'])),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: row['status'] == 'Active' ? Colors.green.shade100 : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              row['status'],
                              style: TextStyle(
                                color: row['status'] == 'Active' ? Colors.green.shade700 : Colors.red.shade700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        DataCell(Row(
                          children: [
                            IconButton(
                              key: Key('edit_${row['id']}'),
                              icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
                              tooltip: 'Edit',
                              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Edit ${row['name']}')),
                              ),
                            ),
                            IconButton(
                              key: Key('delete_${row['id']}'),
                              icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                              tooltip: 'Delete',
                              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Delete ${row['name']}')),
                              ),
                            ),
                          ],
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

            // Pagination
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Showing ${_currentPage * _rowsPerPage + 1}–${(_currentPage * _rowsPerPage + _pageData.length)} of ${_filteredData.length} results'),
                Row(
                  children: [
                    Semantics(
                      label: 'Previous page button',
                      child: IconButton(
                        key: const Key('prev_page'),
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _currentPage > 0 ? () => setState(() => _currentPage--) : null,
                      ),
                    ),
                    ...List.generate(_totalPages, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ElevatedButton(
                          key: Key('page_$i'),
                          onPressed: () => setState(() => _currentPage = i),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentPage == i ? Colors.indigo : Colors.grey.shade200,
                            foregroundColor: _currentPage == i ? Colors.white : Colors.black,
                            minimumSize: const Size(36, 36),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text('${i + 1}'),
                        ),
                      );
                    }),
                    Semantics(
                      label: 'Next page button',
                      child: IconButton(
                        key: const Key('next_page'),
                        icon: const Icon(Icons.chevron_right),
                        onPressed: _currentPage < _totalPages - 1 ? () => setState(() => _currentPage++) : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DataColumn _buildColumn(String label, int index) {
    return DataColumn(
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      onSort: (i, asc) => setState(() {
        _sortColumnIndex = i;
        _sortAscending = asc;
      }),
    );
  }
}
