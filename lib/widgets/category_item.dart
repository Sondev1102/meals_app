import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/routes.dart';
import 'package:meals_app/screens/meal_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;
  List<Meal> mealLists = [];
  CategoryItem(this.categoryItem, this.mealLists);

  @override
  Widget build(BuildContext context) {
    final categoryMeal =
        DUMMY_CATEGORIES.firstWhere((ctg) => ctg.id == categoryItem.id);
    final mealList = mealLists
        .where((meal) => meal.categories.contains(categoryMeal.id))
        .toList();
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(meal,
          arguments: MealArgs(title: categoryItem.title, mealList: mealList)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [categoryItem.color.withOpacity(0.7), categoryItem.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            categoryItem.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
