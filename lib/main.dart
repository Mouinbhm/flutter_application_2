import 'package:flutter/material.dart';
import 'package:flutter_application_2/history_screen.dart';
import 'package:flutter_application_2/movies_screen.dart';
import 'package:flutter_application_2/profile_screen.dart';

void main() => runApp(const ResponsiveApp());

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Responsive Navigation App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ResponsiveHome(),
    );
  }
}

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// Liste de l’historique des films archivés
  final List<Map<String, String>> _historyEntries = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) setState(() {});
    });
  }

  /// Ajoute un film dans l’historique
  void _addToHistory(Map<String, dynamic> movie) {
    setState(() {
      _historyEntries.add({
        'title': movie['title'] as String,
        'genre': movie['genre'] as String,
        'year': movie['year'] as String,
        // Date simple AAAA-MM-JJ
        'date': DateTime.now().toString().split(' ').first,
      });
    });
  }

  /// Vide l’historique
  void _clearHistory() {
    setState(() {
      _historyEntries.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isPhone = width < 600;
    final bool isTablet = width >= 600 && width < 1000;
    final bool isDesktop = width >= 1000;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ["Movies", "History", "Profile"][_tabController.index],
        ),
      ),

      // PHONE → Bottom TabBar
      bottomNavigationBar: isPhone
          ? Material(
              color: Colors.white,
              elevation: 8,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.indigo,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(icon: Icon(Icons.movie), text: "Movies"),
                  Tab(icon: Icon(Icons.history), text: "History"),
                  Tab(icon: Icon(Icons.person), text: "Profile"),
                ],
              ),
            )
          : null,

      body: Row(
        children: [
          // TABLET / DESKTOP → NavigationRail
          if (!isPhone)
            NavigationRail(
              selectedIndex: _tabController.index,
              onDestinationSelected: (i) {
                setState(() {
                  _tabController.index = i;
                });
              },
              extended: isDesktop,
              labelType: isTablet
                  ? NavigationRailLabelType.selected
                  : NavigationRailLabelType.none,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.movie_outlined),
                  selectedIcon: Icon(Icons.movie),
                  label: Text("Movies"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: Text("History"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: Text("Profile"),
                ),
              ],
            ),

          // MAIN VIEW (Tab Screens)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MoviesScreen(onArchiveMovie: _addToHistory),
                HistoryScreen(
                  historyEntries: _historyEntries,
                  onClear: _clearHistory,
                ),
                const ProfileScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
