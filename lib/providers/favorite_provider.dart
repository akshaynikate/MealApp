import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newmealapp/models/mealModel.dart';

class FavoriteMealNotifire extends StateNotifier<List<MealModel>> {
  FavoriteMealNotifire() : super([]);

  bool toggaleMealFavoriteStatus(MealModel meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealNotifire, List<MealModel>>((ref) {
  return FavoriteMealNotifire();
});
