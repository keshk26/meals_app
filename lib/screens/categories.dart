
import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_gird_item.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({ super.key });

  void _selectCategory(BuildContext context, Category category) {
    final meals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => 
        MealsScreen(
          title: category.title, 
          meals: meals
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick your category'),
      ),
      body: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGirdItem(
              category: category, 
              onSelectCategory: () => _selectCategory(context, category)
            )
        ],
      ),
    );
  }
}