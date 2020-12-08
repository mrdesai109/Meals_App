import 'package:Meals_App/widgets/category_item.dart';
import 'package:flutter/material.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES.map((category) {
          return CategoryItem(category.id, category.title, category.color);
        }).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 1.5,
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20));
  }
}
