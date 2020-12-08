import 'package:Meals_App/models/meal.dart';
import 'package:Meals_App/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String id;
  // final String title;

  // CategoryMealsScreen(this.id, this.title);

  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final gotID = routeArgs['id']; //id of CATEGORY
      categoryTitle = routeArgs['title'];

      //Filter all the meals whose category is 'gotID'
      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(gotID))
          .toList();
      loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void removeMeal(String mealID) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, pos) {
          return MealItem(
              id: displayedMeals[pos].id,
              title: displayedMeals[pos].title,
              imageUrl: displayedMeals[pos].imageUrl,
              affordability: displayedMeals[pos].affordability,
              complexity: displayedMeals[pos].complexity,
              duration: displayedMeals[pos].duration);
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
