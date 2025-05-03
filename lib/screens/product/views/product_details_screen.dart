import 'package:ecommerce_cataloge/route/route_constants.dart';
import 'package:ecommerce_cataloge/screens/product/views/components/notify_me_card.dart';
import 'package:ecommerce_cataloge/screens/product/views/components/product_images.dart';
import 'package:ecommerce_cataloge/screens/product/views/components/product_info.dart';
import 'package:ecommerce_cataloge/screens/product/views/components/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:ecommerce_cataloge/constants.dart';
import 'package:ecommerce_cataloge/models/product_model.dart';
import 'package:ecommerce_cataloge/components/cart_button.dart';
import 'package:ecommerce_cataloge/components/custom_modal_bottom_sheet.dart';
import 'package:ecommerce_cataloge/components/product/product_card.dart';
import 'package:ecommerce_cataloge/components/review_card.dart';
import 'package:ecommerce_cataloge/screens/product/views/product_returns_screen.dart';
import 'package:ecommerce_cataloge/components/buy_full_ui_kit.dart';
import 'package:ecommerce_cataloge/components/product/component/widgetImageFull.dart';
import 'package:ecommerce_cataloge/Data/Provider.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({
    super.key,
    required this.images,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.discPrice,
    required this.price,
    this.isProductAvailable = true,
    required this.product,
    required this.tilesProducts,
  });

  final ProductModel product;
  final List<ProductModel> tilesProducts;
  final List<String> images;
  final String title;
  final String subtitle;
  final String description;
  final double price, discPrice;
  final bool isProductAvailable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(cartProvider.notifier);
    final bookmarks = ref.watch(bookmarkProvider);
    final cartItems = ref.watch(cartProvider);
    final int totalItems = cartItems.length;
    final bool isBookmarked = bookmarks.contains(product);

    return Scaffold(
      bottomNavigationBar: isProductAvailable
          ? CartButton(
              tileName: subtitle,
              price: price,
              discPrice: discPrice,
              press: () {
                cartNotifier.addToCart(
                  CartItem(
                    quantity: 1,
                    image: images[0],
                    price: price,
                    discountPrice: discPrice,
                    brandName: title,
                    title: subtitle,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item added to cart')),
                );
              },
            )
          : NotifyMeCard(
              isNotify: false,
              onChanged: (value) {},
            ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Bag.svg",
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, cartroute);
                      },
                    ),
                    if (totalItems > 0)
                      Positioned(
                        top: 8,
                        left: 6,
                        right: 0,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              totalItems.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    ref.read(bookmarkProvider.notifier).toggleBookmark(product);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Bookmark.svg",
                    color: isBookmarked ? const Color(0xFF31B0D8) : Colors.grey,
                  ),
                ),
              ],
            ),
            ProductImages(images: images),
            ProductInfo(
              brand: title,
              title: subtitle,
              isAvailable: isProductAvailable,
              description: description,
              rating: 4.4,
              numOfReviews: 126,
            ),
            ProductListTile(
              svgSrc: "assets/icons/Product.svg",
              title: "Product Details",
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const BuyFullKit(
                    images: ["assets/screens/Product detail.png"],
                  ),
                );
              },
            ),
            ProductListTile(
              svgSrc: "assets/icons/Delivery.svg",
              title: "Shipping Information",
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const BuyFullKit(
                    images: ["assets/screens/Shipping information.png"],
                  ),
                );
              },
            ),
            ProductListTile(
              svgSrc: "assets/icons/Return.svg",
              title: "Returns",
              isShowBottomBorder: true,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const ProductReturnsScreen(),
                );
              },
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: ReviewCard(
                  rating: 4.3,
                  numOfReviews: 128,
                  numOfFiveStar: 80,
                  numOfFourStar: 30,
                  numOfThreeStar: 5,
                  numOfTwoStar: 4,
                  numOfOneStar: 1,
                ),
              ),
            ),
            ProductListTile(
              svgSrc: "assets/icons/Chat.svg",
              title: "Reviews",
              isShowBottomBorder: true,
              press: () {
                context.goNamed('productReviews');
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "You may also like",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tilesProducts.length,
                  itemBuilder: (context, index) {
                    final item = tilesProducts[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == tilesProducts.length - 1
                            ? defaultPadding
                            : 0,
                      ),
                      child: ProductCard(
                        image: item.image,
                        title: item.title,
                        brandName: item.brandName,
                        price: item.price,
                        priceAfterDiscount:
                            item.priceAfetDiscount ?? item.price,
                        discountPercent: item.dicountpercent,
                        onTapButton: () {
                          cartNotifier.addToCart(
                            CartItem(
                              image: item.image,
                              price: item.price,
                              discountPrice:
                                  item.priceAfetDiscount ?? item.price,
                              brandName: item.brandName,
                              title: item.title,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item added to cart')),
                          );
                        },
                        press: () {
                          // Navigate to details if needed
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            ),
          ],
        ),
      ),
    );
  }
}
