import 'package:flutter/material.dart';
import 'package:ecommerce_cataloge/components/product/secondary_product_card.dart';
import 'package:ecommerce_cataloge/models/product_model.dart';
import 'package:ecommerce_cataloge/screens/product/views/product_details_screen.dart';

import '../../../../constants.dart';
import '../../../../route/route_constants.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Most popular",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // SeconderyProductsSkelton(),
        SizedBox(
          height: 114,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoPopularProducts on models/ProductModel.dart
            itemCount: tilesProducts.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == tilesProducts.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: SecondaryProductCard(
                image: tilesProducts[index].image,
                brandName: tilesProducts[index].brandName,
                title: tilesProducts[index].title,
                price: tilesProducts[index].price,
             //   priceAfetDiscount: tilesProducts[index].priceAfetDiscount,
                discountPercent: tilesProducts[index].dicountpercent,
                onPress: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            description: tilesProducts[index].description ?? 'No Description...',
                             product: tilesProducts[index], tilesProducts:tilesProducts,
                              images: [tilesProducts[index].image.toString()],
                              title: tilesProducts[index].brandName,
                              subtitle: tilesProducts[index].title,
                              discPrice: tilesProducts[index].price,
                              price: tilesProducts[index].priceAfetDiscount??tilesProducts[index].price,)));
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
