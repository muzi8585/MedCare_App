import 'package:flutter/material.dart';
import 'package:ecommerce_cataloge/components/product/product_card.dart';
import 'package:ecommerce_cataloge/models/product_model.dart';
import 'package:ecommerce_cataloge/route/screen_export.dart';

import '../../../../constants.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
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
            "Popular products",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 205,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tilesProducts.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == tilesProducts.length - 1 ? defaultPadding : 0,
              ),
              child: ProductCard(
                image: tilesProducts[index].image.toString(),
                brandName: tilesProducts[index].brandName,
                title: tilesProducts[index].title,
                price: tilesProducts[index].price,
                priceAfterDiscount: tilesProducts[index].priceAfetDiscount,
                discountPercent: tilesProducts[index].dicountpercent,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                                description: tilesProducts[index].description ??
                                    'No Description...',
                                images: [tilesProducts[index].image.toString()],
                                title: tilesProducts[index].brandName,
                                subtitle: tilesProducts[index].title,
                                discPrice: tilesProducts[index].price,
                                price: tilesProducts[index].priceAfetDiscount ??
                                    tilesProducts[index].price,
                                product: tilesProducts[index],
                                tilesProducts: tilesProducts,
                              )));
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
