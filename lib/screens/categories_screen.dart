import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  List<Meal> filteredMeals;
  CategoriesScreen({required this.filteredMeals});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          final categoryItem = DUMMY_CATEGORIES[index];
          return CategoryItem(categoryItem, filteredMeals);
        },
        itemCount: DUMMY_CATEGORIES.length,
      ),
    );
  }
}
