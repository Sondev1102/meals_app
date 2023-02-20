import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/routes.dart';

class MealItem extends StatelessWidget {
  Meal mealItem;
  MealItem({required this.mealItem});

  get complexityText {
    switch (mealItem.complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  get affordabilityText {
    switch (mealItem.affordability) {
      case Affordability.Affordable:
        return 'Affordable';

      case Affordability.Luxurious:
        return 'Luxurious';
      case Affordability.Pricey:
        return 'Pricey';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mealDescription(IconData iconData, String string) {
      return Row(
        children: [
          Icon(iconData),
          const SizedBox(
            width: 6,
          ),
          Text(string),
        ],
      );
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(mealDetail, arguments: mealItem);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    mealItem.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 250,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    color: Colors.black45,
                    child: Text(
                      mealItem.title,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  mealDescription(
                    Icons.schedule,
                    '${mealItem.duration.toString()} min',
                  ),
                  mealDescription(
                    Icons.work,
                    complexityText,
                  ),
                  mealDescription(
                    Icons.attach_money,
                    affordabilityText,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
