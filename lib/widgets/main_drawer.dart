import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/appFilter.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/routes.dart';
import 'package:meals_app/screens/meal_screen.dart';

class MainDrawer extends StatefulWidget {
  AppFilter filter;
  Function changeFilter;
  List<Meal> filteredMeals;

  MainDrawer(
      {required this.filter,
      required this.changeFilter,
      required this.filteredMeals});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isExpand = false;
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    Widget renderSwitch(
        String title, String subTitle, bool value, Function onChange) {
      return ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          subTitle,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
        ),
        trailing: Switch(value: value, onChanged: (val) => onChange(val)),
      );
    }

    Widget buildListTitle(
        IconData iconData, String title, Function tapHandler) {
      return Column(
        children: [
          ListTile(
            onTap: () => setState(() {
              isExpand = !isExpand;
            }),
            leading: Icon(iconData),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: !isExpand
                ? const Icon(Icons.keyboard_arrow_down)
                : const Icon(Icons.keyboard_arrow_up),
          ),
          isExpand
              ? Container(
                  padding: const EdgeInsets.only(left: 2),
                  child: Column(
                    children: [
                      renderSwitch(
                          'Gluten-free',
                          'Only include gluten-free meals',
                          widget.filter.isGluten,
                          (val) => widget.changeFilter(
                              val,
                              widget.filter.isLactose,
                              widget.filter.isVegetarian,
                              widget.filter.isVegan)),
                      renderSwitch(
                          'Lactose-free',
                          'Only include lactose-free meals',
                          widget.filter.isLactose,
                          (val) => widget.changeFilter(
                              widget.filter.isGluten,
                              val,
                              widget.filter.isVegetarian,
                              widget.filter.isVegan)),
                      renderSwitch(
                          'Vegetarian',
                          'Only include vegetarian meals',
                          widget.filter.isVegetarian,
                          (val) => widget.changeFilter(
                              widget.filter.isGluten,
                              widget.filter.isLactose,
                              val,
                              widget.filter.isVegan)),
                      renderSwitch(
                        'Vegan',
                        'Only include vegan meals',
                        widget.filter.isVegan,
                        (val) => widget.changeFilter(
                          widget.filter.isGluten,
                          widget.filter.isLactose,
                          widget.filter.isVegetarian,
                          val,
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushNamed(meal,
                arguments:
                    MealArgs(title: 'Meals', mealList: widget.filteredMeals)),
            leading: Icon(Icons.restaurant),
            title: const Text(
              'Meals',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          buildListTitle(Icons.filter_alt, 'Filter', () {}),
        ],
      ),
    );
  }
}
