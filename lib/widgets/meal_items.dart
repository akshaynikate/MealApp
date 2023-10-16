import 'package:flutter/material.dart';
import 'package:newmealapp/models/mealModel.dart';
import 'package:newmealapp/screens/mealDetailScreen.dart';
import 'package:newmealapp/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItems extends StatelessWidget {
  const MealItems({
    super.key,
    required this.meal,
  });
  final MealModel meal;

  String get compexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
          child: Stack(
            children: [
              Hero(
                tag: meal.id,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                top: 100,
                right: 0,
                left: 0,
                child: Container(
                  color: const Color.fromARGB(106, 0, 0, 0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaealTrait(
                              icon: Icons.schedule,
                              label: '${meal.duration} min'),
                          const SizedBox(
                            width: 5,
                          ),
                          MaealTrait(icon: Icons.work, label: compexityText),
                          const SizedBox(
                            width: 5,
                          ),
                          MaealTrait(
                              icon: Icons.money, label: affordabilityText),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MealDetailScreen(
                  meal: meal,
                ),
              ),
            );
          }),
    );
  }
}
