import 'package:Meals_App/dummy_data.dart';
import 'package:Meals_App/models/meal.dart';
import 'package:Meals_App/screens/categories_screen.dart';
import 'package:Meals_App/screens/category_meals_screen.dart';
import 'package:Meals_App/screens/filter_screen.dart';
import 'package:Meals_App/screens/meal_detail_screen.dart';
import 'package:Meals_App/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoritedMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFav(String mealID) {
    int existingIndex =
        favoritedMeals.indexWhere((element) => element.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        //remove now
        favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        //add now
        favoritedMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealID));
      });
    }
  }

  bool isMealFavorite(String mealID) {
    return favoritedMeals.any((element) => element.id == mealID);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(favoritedMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(toggleFav, isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(filters, setFilters)
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) {
          return CategoriesScreen();
        });
      },
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              // ignore: deprecated_member_use
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
    );
  }
}
