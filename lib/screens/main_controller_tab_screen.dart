import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/appFilter.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorite_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

enum tabsKey { title, body, renderBottomNav }

class TabElement {
  String title;
  Widget body;
  BottomNavigationBarItem renderBottomNav;

  TabElement(
      {required this.title, required this.body, required this.renderBottomNav});
}

class MainTabScreen extends StatefulWidget {
  AppFilter filter;
  Function changeFilter;
  List<Meal> filteredMeals;

  MainTabScreen(
      {required this.filter,
      required this.changeFilter,
      required this.filteredMeals});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<TabElement> tabs = [
      TabElement(
        title: 'Category',
        body: CategoriesScreen(filteredMeals: widget.filteredMeals),
        renderBottomNav: const BottomNavigationBarItem(
            icon: Icon(Icons.category), label: 'Category'),
      ),
      TabElement(
        title: 'Favorite',
        body: FavoriteScreen(),
        renderBottomNav: const BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: 'Favorite'),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(tabs[_currentTabIndex].title),
      ),
      drawer: MainDrawer(
        filter: widget.filter,
        changeFilter: widget.changeFilter,
        filteredMeals: widget.filteredMeals,
      ),
      body: tabs[_currentTabIndex].body,
      bottomNavigationBar: BottomNavigationBar(
        items: tabs.map((tab) => tab.renderBottomNav).toList(),
        onTap: (index) => setState(() {
          _currentTabIndex = index;
        }),
        currentIndex: _currentTabIndex,
      ),
    );
  }
}
