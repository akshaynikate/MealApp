import 'package:flutter/material.dart';
import 'package:newmealapp/data/dummy_data.dart';
import 'package:newmealapp/main.dart';
import 'package:newmealapp/models/categoryModel.dart';
import 'package:newmealapp/models/mealModel.dart';
import 'package:newmealapp/screens/mealsScreen.dart';
import 'package:newmealapp/widgets/category_greed_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.availableMeals,
  });

  final List<MealModel> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationConroller;
  @override
  void initState() {
    super.initState();
    _animationConroller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationConroller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationConroller.dispose();
  }

  void _selectCategory(BuildContext context, CategoryModel category) {
    final filterdMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filterdMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorScheme.onSecondaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: AnimatedBuilder(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            children: [
              for (final category in avilableCategories)
                CategoryGridItem(
                  categoryModel: category,
                  onSelectCategory: () {
                    _selectCategory(context, category);
                  },
                )
            ],
          ),
          animation: _animationConroller,
          builder: (context, child) => SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(CurvedAnimation(
                parent: _animationConroller, curve: Curves.easeInOut)),
            child: child,
          ),
        ),
      ),
    );
  }
}
