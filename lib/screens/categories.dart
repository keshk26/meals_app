
import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_gird_item.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({ super.key, required this.availableMeals });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      lowerBound: 0,
      upperBound: 1
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  

  void _selectCategory(BuildContext context, Category category) {
    final meals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => 
        MealsScreen(
          title: category.title, 
          meals: meals,
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController, 
      child: GridView(
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
      builder: (context, child) => SlideTransition(
        position: Tween(
            begin: Offset(0, 0.3),
            end: Offset(0, 0)
          ).animate(CurvedAnimation(
            parent: _animationController, 
            curve: Curves.easeInOut
            )
          ),
        child: child,
      ),
    );
  }
}