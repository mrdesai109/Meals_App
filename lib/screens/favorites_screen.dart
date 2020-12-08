import 'package:Meals_App/models/meal.dart';
import 'package:Meals_App/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  FavoritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    return favMeals.isEmpty
        ? Center(
            child: Text('You have no favorites yet - start adding some!'),
          )
        : ListView.builder(
            itemBuilder: (ctx, pos) {
              return MealItem(
                  id: favMeals[pos].id,
                  title: favMeals[pos].title,
                  imageUrl: favMeals[pos].imageUrl,
                  affordability: favMeals[pos].affordability,
                  complexity: favMeals[pos].complexity,
                  duration: favMeals[pos].duration);
            },
            itemCount: favMeals.length,
          );
  }
}
