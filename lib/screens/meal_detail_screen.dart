import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealItem = ModalRoute.of(context)!.settings.arguments as Meal;

    Widget buildMealContainer(String title,
        Widget? Function(BuildContext, int) itemBuilder, int length) {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(10),
            width: 300,
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              color: Colors.white,
            ),
            child: ListView.builder(
              itemBuilder: itemBuilder,
              itemCount: length,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 244, 199),
      appBar: AppBar(
        title: Text(
          mealItem.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.network(mealItem.imageUrl),
          buildMealContainer(
            'Ingredients',
            (_, index) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color.fromARGB(255, 218, 198, 21),
              ),
              child: Text(
                mealItem.ingredients[index],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            mealItem.ingredients.length,
          ),
          buildMealContainer(
            'Steps',
            (_, index) => Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${index + 1}'),
                  ),
                  title: Text(
                    mealItem.steps[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const Divider(),
              ],
            ),
            mealItem.steps.length,
          ),
        ],
      )),
    );
  }
}
