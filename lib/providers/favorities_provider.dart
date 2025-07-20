import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoritiesNotifier extends StateNotifier<List<Meal>> {
  FavoritiesNotifier() : super([]);

  bool toggleMealStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoritiesNotifier, List<Meal>>((ref) {
  return FavoritiesNotifier();
});