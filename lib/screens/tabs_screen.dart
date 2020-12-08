import 'package:Meals_App/models/meal.dart';
import 'package:Meals_App/screens/categories_screen.dart';
import 'package:Meals_App/screens/favorites_screen.dart';
import 'package:Meals_App/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favMeals;

  TabScreen(this.favMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> pages;

  int selectedPageIndex = 0;

  @override
  void initState() {
    pages = [CategoriesScreen(), FavoritesScreen(widget.favMeals)];
    super.initState();
  }

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
      ),
      drawer: MainDrawer(),
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
              backgroundColor: Theme.of(context).primaryColor)
        ],
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
