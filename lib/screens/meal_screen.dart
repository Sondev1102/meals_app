import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealArgs {
  String title;
  List<Meal> mealList;

  MealArgs({required this.title, required this.mealList});
}

class MealScreen extends StatelessWidget {
  MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as MealArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final meal = arguments.mealList[index];
          return MealItem(
            mealItem: meal,
          );
        },
        itemCount: arguments.mealList.length,
      ),
    );
  }
}
