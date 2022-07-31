// ignore_for_file: prefer_const_constructors, deprecated_member_use,everything

import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './models/filter.dart';
import './screens/filters_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/meal_detail_screenl.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _filter = Filter(
    gluten: false,
    lactose: false,
    vegan: false,
    vegetaian: false,
  );

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoutirMeals = [];

  void _saveFilter(Filter newfilter) {
    setState(() {
      _filter = newfilter;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filter.gluten && !meal.isGlutenFree) {
          return false;
        }
        if (_filter.lactose && !meal.isLactoseFree) {
          return false;
        }
        if (_filter.vegan && !meal.isVegan) {
          return false;
        }
        if (_filter.vegetaian && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String id) {
    final index = _favoutirMeals.indexWhere((meal) => meal.id == id);
    if (index >= 0) {
      setState(() {
        _favoutirMeals.removeAt(index);
      });
    } else {
      setState(() {
        _favoutirMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
      });
    }
  }

  bool _isFavourite(String id) {
    return _favoutirMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        // same as this i think
        // canvasColor: Colors.white,
        backgroundColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              // bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              // bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              titleLarge: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // don't know whats happening when using two fonts !!
                // fontFamily: 'RobotoCondensed',
              ),
              titleMedium: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                // don't know whats happening when using two fonts !!
                fontFamily: 'RobotoCondensed',
              ),
              titleSmall: TextStyle(
                fontSize: 18,
                // don't know whats happening when using two fonts !!
                fontFamily: 'Raleway',
              ),
            ),
      ),
      routes: {
        '/': (context) => TabsScreen(_favoutirMeals),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavourite, _isFavourite),
        FilterScreen.routeName: (context) => FilterScreen(_filter, _saveFilter),
      },
    );
  }
}
