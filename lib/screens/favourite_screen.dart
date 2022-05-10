import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List favouriteMeals;
  FavouriteScreen(this.favouriteMeals);
  @override
  Widget build(BuildContext context) {
    return favouriteMeals.isEmpty
        ? Center(
            child: Text(
              'You Have no Favourite Meals yet !',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                id: favouriteMeals[index].id,
                title: favouriteMeals[index].title,
                imageUrl: favouriteMeals[index].imageUrl,
                duration: favouriteMeals[index].duration,
                affordability: favouriteMeals[index].affordability,
                complexity: favouriteMeals[index].complexity,
              );
            },
            itemCount: favouriteMeals.length,
          );
  }
}
