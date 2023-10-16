import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newmealapp/providers/filters_provider.dart';

import 'package:newmealapp/screens/CategoryScreen.dart';
import 'package:newmealapp/screens/filterScreen.dart';
import 'package:newmealapp/providers/favorite_provider.dart';
import 'package:newmealapp/screens/mealsScreen.dart';
import 'package:newmealapp/widgets/mian_drwarer.dart';

const kInitialFilters = {
  Filters.gluttenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int selectedPageIndex = 0;

  void _showInfoMessage(String message) {}

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void _setScreen(String identifire) async {
    if (identifire == 'filters') {
      Navigator.of(context).pop();
      await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterdMealProvider);
    Widget activePage = CategoryScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Select Category';
    if (selectedPageIndex == 1) {
      final favoriteMeal = ref.watch(favoriteMealProvider);
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
      activePageTitle = 'Your Favorite Meals';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'meal'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favorites'),
          ]),
    );
  }
}
