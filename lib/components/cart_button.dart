// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:ecommerce_cataloge/Data/Provider.dart';

// class CartButton extends ConsumerStatefulWidget {
//   const CartButton({
//     super.key,
//     required this.price,
//     required this.discPrice,
//     required this.onpress,
//     this.title = "Add to Cart",
//     this.subTitle = "Unit price",
//     required this.tileName,
//   });

//   final double price, discPrice;
//   final VoidCallback onpress;
//   final String title, subTitle, tileName;

//   @override
//   ConsumerState<CartButton> createState() => _CartButtonState();
// }

// class _CartButtonState extends ConsumerState<CartButton> {
//   @override
//   Widget build(BuildContext context) {
//     final cartItems = ref.watch(cartProvider);
//     final cartNotifier = ref.read(cartProvider.notifier);

//     final cartItem = cartItems.firstWhere(
//       (item) => item.title == widget.tileName,

//     );

//     final bool isAlreadyAdded = cartItem != null;

//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: SizedBox(
//           height: 50,
//           child: isAlreadyAdded
//               ? Row(
//                   children: [
//                     Container(
//                       width: 110,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 6,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.remove, size: 18),
//                             onPressed: () {
//                               cartNotifier.decrementQuantity(widget.tileName);
//                             },
//                           ),
//                           Text(
//                             '${cartItem!.quantity}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.add, size: 18),
//                             onPressed: () {
//                               cartNotifier.incrementQuantity(widget.tileName);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     // Price Box
//                     Expanded(
//                       child: Container(
//                         height: double.infinity,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF31B0D8),
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 6,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Add Rs: ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               : InkWell(
//                   onTap: widget.onpress,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF31B0D8),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 6,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Rs${widget.price.toStringAsFixed(2)}",
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 widget.subTitle,
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           widget.title,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_cataloge/Data/Provider.dart';
import 'package:ecommerce_cataloge/constants.dart';

class CartButton extends ConsumerWidget {
  const CartButton({
    super.key,
    required this.price,
    this.title = "Add to Cart",
    this.subTitle = "Unit price",
    required this.discPrice,
    required this.tileName,
    required this.press,
  });

  final double price, discPrice;
  final String title, subTitle, tileName;
  final VoidCallback press;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final isAdded = cartItems.any((item) => item.title == tileName);
    // final cartItem = cartItems.firstWhere(
    //   (item) => item.title == tileName,
    // );
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultBorderRadious / 2),
        child: SizedBox(
          height: 50,
          child: InkWell(
              onTap: isAdded ? null : press,
              child: Row(
                children: [
                  Container(
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 18),
                          onPressed: () {
                            // if (cartItem.quantity > 1) {
                            //   ref
                            //       .read(cartProvider.notifier)
                            //       .decrementQuantity(title);
                            // } else {
                            //   ref
                            //       .read(cartProvider.notifier)
                            //       .removeFromCart(title);
                            // }
                          },
                        ),
                        Text('1',
                        //  cartItems.first.quantity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 18),
                          onPressed: () {
                            //        cartNotifier.incrementQuantity(tileName);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Price Box
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF31B0D8),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Add Rs: ${(price).toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
