import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
    required this.historyEntries,
    required this.onClear,
  });

  final List<Map<String, String>> historyEntries;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Column(
        children: [
          // HEADER
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF4B6CB7),
              ),
              child: const Center(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Explore 2 + Explore 3
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xFF6DAEDB),
                    child: const Center(
                      child: Text(
                        'Explore 2',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFF84C0C6),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () => print("Browse pressed"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B6CB7),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Browse",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PERSONAL HISTORY
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal History',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA48DD0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: historyEntries.isEmpty
                          ? const Center(
                              child: Text(
                                "Aucun film archivé pour le moment.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: DataTable(
                                    headingRowColor: MaterialStateProperty.all(
                                      const Color(0xFFE3D8F9),
                                    ),
                                    border: TableBorder.all(
                                      color: const Color(0xFFBCA7E8),
                                      width: 1,
                                    ),
                                    columnSpacing: 40,
                                    columns: const [
                                      DataColumn(label: Text("ID")),
                                      DataColumn(label: Text("Movie Name")),
                                      DataColumn(label: Text("Genre")),
                                      DataColumn(label: Text("Date")),
                                    ],
                                    rows: List.generate(
                                      historyEntries.length,
                                      (index) {
                                        final entry = historyEntries[index];
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                                Text((index + 1).toString())),
                                            DataCell(Text(
                                                entry['title'] ?? 'Unknown')),
                                            DataCell(Text(
                                                entry['genre'] ?? 'Unknown')),
                                            DataCell(Text(
                                                entry['date'] ?? 'Unknown')),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: historyEntries.isEmpty ? null : onClear,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9534F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "CLEAR",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
