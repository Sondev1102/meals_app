import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/appFilter.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/routes.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/main_controller_tab_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/meal_screen.dart';
import 'package:meals_app/screens/tab_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppFilter filter = AppFilter(
      isGluten: false, isLactose: false, isVegetarian: false, isVegan: false);

  void _changeFilter(_isGluten, _isLactose, _isVegetarian, _isVegan) {
    setState(() {
      filter = AppFilter(
          isGluten: _isGluten,
          isLactose: _isLactose,
          isVegetarian: _isVegetarian,
          isVegan: _isVegan);
    });
  }

  List<Meal> filteredMeals = DUMMY_MEALS;

  @override
  Widget build(BuildContext context) {
    List<Meal> filtered() {
      return DUMMY_MEALS.where((meal) {
        if (filter.isGluten && !meal.isGlutenFree) return false;
        if (filter.isLactose && !meal.isLactoseFree) return false;
        if (filter.isVegetarian && !meal.isVegetarian) return false;
        if (filter.isVegan && !meal.isVegan) return false;
        return true;
      }).toList();
    }

    ;
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
              fontSize: 14,
              color: Colors.black,
            )),
      ),
      home: MainTabScreen(
        filter: filter,
        changeFilter: _changeFilter,
        filteredMeals: filtered(),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        meal: (context) => MealScreen(),
        mealDetail: (context) => MealDetailScreen(),
      },
    );
  }
}
