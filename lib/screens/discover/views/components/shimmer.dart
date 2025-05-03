import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ecommerce_cataloge/constants.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cardWidth = screenWidth * 0.4;
    double cardHeight = screenHeight * 0.3;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(defaultBorderRadious),
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.15,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(defaultBorderRadious),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenWidth * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenWidth * 0.025,
                      width: screenWidth * 0.2,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: screenWidth * 0.03,
                      width: screenWidth * 0.25,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: screenWidth * 0.03,
                      width: screenWidth * 0.3,
                      color: Colors.grey.shade300,
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      height: screenWidth * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
