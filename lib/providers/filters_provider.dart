import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newmealapp/providers/meals_provider.dart';

enum Filters { gluttenFree, lactoseFree, vegetarian, vegan }

class FilterNotifire extends StateNotifier<Map<Filters, bool>> {
  FilterNotifire()
      : super({
          Filters.gluttenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });

  void setFilters(Map<Filters, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifire, Map<Filters, bool>>(
        (ref) => FilterNotifire());

final filterdMealProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((meal) {
    if (activeFilters[Filters.gluttenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filters.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
