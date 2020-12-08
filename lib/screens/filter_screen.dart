import 'package:Meals_App/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var glutenFree = false;
  var vegetarian = false;
  var vegan = false;
  var lactoseFree = false;

  @override
  initState() {
    glutenFree = widget.currentFilters['gluten'];
    vegetarian = widget.currentFilters['vegetarian'];
    vegan = widget.currentFilters['vegan'];
    lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String subTitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final resultMap = {
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegan': vegan,
                  'vegetarian': vegetarian
                };
                widget.saveFilters(resultMap);
                Toast.show("Filters Applied!", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Set Your Meals Selection',
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(
                  'Gluten-free', 'Only include gluten-free meals', glutenFree,
                  (newValue) {
                setState(() {
                  glutenFree = newValue;
                });
              }),
              buildSwitchListTile('Lactose-free',
                  'Only include lactose-free meals', lactoseFree, (newValue) {
                setState(() {
                  lactoseFree = newValue;
                });
              }),
              buildSwitchListTile(
                  'Vegetarian', 'Only include vegetarian meals', vegetarian,
                  (newValue) {
                setState(() {
                  vegetarian = newValue;
                });
              }),
              buildSwitchListTile('Vegan', 'Only include vegan meals', vegan,
                  (newValue) {
                setState(() {
                  vegan = newValue;
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}
