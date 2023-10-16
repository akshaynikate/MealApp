import 'package:flutter/material.dart';
import 'package:newmealapp/main.dart';
import 'package:newmealapp/models/categoryModel.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.categoryModel,
    required this.onSelectCategory,
  });
  final CategoryModel categoryModel;
  final void Function() onSelectCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [
                categoryModel.color.withOpacity(0.5),
                categoryModel.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.mirror),
        ),
        child: Text(
          categoryModel.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: kColorScheme.onBackground),
        ),
      ),
    );
  }
}
