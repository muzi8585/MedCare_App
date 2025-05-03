import 'package:ecommerce_cataloge/entry_point.dart';
import 'package:ecommerce_cataloge/route/route_constants.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';

class CategoryModel {
  final String name;
  final String? imageUrl;
  final VoidCallback route;

  CategoryModel({
    required this.name,
    required this.imageUrl,
    required this.route,
  });
}

List<CategoryModel> demoCategoriesBuilder(BuildContext context) => [
      CategoryModel(
        name: "Tiles",
        imageUrl:
            'https://img.freepik.com/premium-photo/modern-ceramic-tiles-display-luxury-shopping-mall-shopping-mall-sell-ceramic-materials-tile_255667-81169.jpg',
        route: () {
          Navigator.pushNamed(context, dummyroute);
        },
      ),
      CategoryModel(
        name: "Bathroom Tiles",
        imageUrl:
            "https://img.freepik.com/free-photo/still-life-putting-up-decorative-vinyls_23-2149683466.jpg",
        route: () {
          Navigator.pushNamed(context, dummyroute1);
        },
      ),
      CategoryModel(
        name: "Floor Tiles",
        imageUrl:
            "https://img.freepik.com/free-vector/realistic-ceramic-set-with-pieces-rectangular-facing-tile-with-different-color-patterns-editable-text_1284-31834.jpg",
        route: () {
          Navigator.pushNamed(context, dummyroute2);
        },
      ),
      CategoryModel(
        name: "Imported Tiles",
        imageUrl:
            "https://img.freepik.com/free-vector/colored-realistic-ceramic-floor-tiles-icon-set-different-types-colors-patterns_1284-29011.jpg",
        route: () {
          Navigator.pushNamed(context, dummyroute3);
        },
      ),
      CategoryModel(
        name: "Sanitary Ware",
        imageUrl:
            "https://img.freepik.com/premium-photo/top-wrench-disassembled-faucet-with-copyspace_696657-638.jpg",
        route: () {
          Navigator.pushNamed(context, dummyroute4);
        },
      ),
    ];

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final demoCategories = demoCategoriesBuilder(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          demoCategories.length,
          (index) => Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? defaultPadding : defaultPadding / 2,
              right: index == demoCategories.length - 1 ? defaultPadding : 0,
            ),
            child: CategoryButton(
              category: demoCategories[index].name,
              imageUrl: demoCategories[index].imageUrl ?? '',
              onTap: demoCategories[index].route,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.category,
    required this.imageUrl,
    required this.onTap,
  });

  final String category;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(35),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            category,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
