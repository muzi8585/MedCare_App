import 'package:ecommerce_cataloge/models/category_model.dart';
import 'package:ecommerce_cataloge/screens/discover/views/components/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ecommerce_cataloge/Data/Provider.dart';
import 'package:ecommerce_cataloge/components/network_image_with_loader.dart';
import 'package:ecommerce_cataloge/components/product/product_card.dart';
import 'package:ecommerce_cataloge/constants.dart';
import 'package:ecommerce_cataloge/models/category_model.dart' as categoryModel;
import 'package:ecommerce_cataloge/models/product_model.dart';
import 'package:ecommerce_cataloge/screens/discover/views/components/discover_categoryBtn.dart';
import 'package:ecommerce_cataloge/screens/discover/views/components/discover_productCard.dart';
import 'package:ecommerce_cataloge/screens/home/views/components/categories.dart';
import 'package:ecommerce_cataloge/screens/product/views/product_details_screen.dart';
import 'package:ecommerce_cataloge/screens/search/views/components/search_form.dart';
import 'package:ecommerce_cataloge/theme/input_decoration_theme.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  final String? selectedCategory;

  const DiscoverScreen({super.key, this.selectedCategory});

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  late String selectedCategory;
  String searchQuery = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory ?? "All";
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  List<ProductModel> getProducts() {
    List<ProductModel> products = selectedCategory == "All"
        ? [
            ...tilesProducts,
            ...floorTilesProducts,
            ...bathroomTilesProducts,
            ...importedTilesProducts,
            ...sanitaryWareProducts
          ]
        : selectedCategory == "Floor Tiles"
            ? floorTilesProducts
            : selectedCategory == "Bathroom Tiles"
                ? bathroomTilesProducts
                : selectedCategory == "Imported Tiles"
                    ? importedTilesProducts
                    : selectedCategory == "Sanitary Ware"
                        ? sanitaryWareProducts
                        : tilesProducts;

    return products
        .where((product) =>
            product.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _refreshData();
          });
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  textInputAction: TextInputAction.search,
                  cursorColor: Color(0xFF31B0D8),
                  
                  decoration: InputDecoration(
                    filled: true,
        fillColor: Colors.transparent,
                    hintText: "Find something...",
                    border: secodaryOutlineInputBorder(context),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                        "assets/icons/Search.svg",
                        height: 24,
                        color:
                            Theme.of(context).iconTheme.color!.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: defaultPadding + 2),
                      child: Categorybutton(
                        category: "All",
                        isActive: selectedCategory == "All",
                        press: () {
                          setState(() {
                            selectedCategory = "All";
                          });
                        },
                      ),
                    ),
                    ...demoCategories.map((category) {
                      bool isActive = selectedCategory == category.title;
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: defaultPadding / 2),
                        child: Categorybutton(
                          category: category.title,
                          isActive: isActive,
                          press: () {
                            setState(() {
                              selectedCategory = category.title;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                child: Text(
                  "${getProducts().length} Products",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: _isLoading
                      ? GridView.builder(
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: defaultPadding,
                            mainAxisSpacing: defaultPadding,
                            childAspectRatio: 0.67,
                          ),
                          itemBuilder: (context, index) {
                            return const ProductCardShimmer();
                          },
                        )
                      : GridView.builder(
                          itemCount: getProducts().length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: defaultPadding,
                            mainAxisSpacing: defaultPadding,
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (context, index) {
                            final product = getProducts()[index];
                            return ProductCard(
                              product: product,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailsScreen(
                                      description: product.description ??
                                          'No Description...',
                                      images: [product.image.toString()],
                                      title: product.brandName,
                                      subtitle: product.title,
                                      discPrice: product.price,
                                      price: product.priceAfetDiscount ??
                                          product.price,
                                      product: product,
                                      tilesProducts: getProducts(),
                                    ),
                                  ),
                                );
                              },
                              image: product.image,
                              brandName: product.brandName,
                              title: product.title,
                              price: product.price,
                              priceAfterDiscount: product.priceAfetDiscount,
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
