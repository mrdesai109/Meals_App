import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isMealFav;

  MealDetailScreen(this.toggleFavorite, this.isMealFav);

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final currentMeal = DUMMY_MEALS.firstWhere((m) => m.id == mealID);
    return Scaffold(
      appBar: AppBar(
        title: Text('${currentMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                currentMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (ctx, pos) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        currentMeal.ingredients[pos],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: currentMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (ctx, pos) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${pos + 1}'),
                        ),
                        title: Text(currentMeal.steps[pos]),
                      ),
                      Divider()
                    ],
                  );
                },
                itemCount: currentMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isMealFav(mealID) ? Icons.star : Icons.star_border),
        onPressed: () {
          return toggleFavorite(mealID);
        },
      ),
    );
  }

  Widget buildSectionTitle(BuildContext ctx, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        // ignore: deprecated_member_use
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }
}
