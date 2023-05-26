import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  List<CartItem> cartItems = [
    CartItem(
      name: 'Item 1',
      quantity: 1,
      price: 10.0,
      imagePath: 'lib/images/camiseta.png',
    ),
    CartItem(
      name: 'Item 2',
      quantity: 2,
      price: 15.0,
      imagePath: 'lib/images/camiseta.png',
    ),
    CartItem(
      name: 'Item 3',
      quantity: 3,
      price: 20.0,
      imagePath: 'lib/images/camiseta.png',
    ),
  ];

  double shippingCost = 5.0;

  bool isProcessing = false;
  bool isAnimationCompleted = false;

  late AnimationController _animationController;
  late Animation<Color?> _buttonColorAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _buttonColorAnimation = _animationController.drive(
      ColorTween(
        begin: Colors.blue,
        end: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        title: const Text(
          'Viva Store',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: Icon(Icons.arrow_back_ios_new),
            // backgroundColor: Colors.blue,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.delete),
          //   onPressed: () {
          //     // Lógica para esvaziar o carrinho
          //     setState(() {
          //       cartItems.clear();
          //     });
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.home),
          //   onPressed: () {
          //     // Navegar para a página inicial
          //     Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => const HomePage()),
          //       (route) => false,
          //     );
          //   },
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = cartItems[index];
                final itemTotal = item.price * item.quantity;

                return ListTile(
                  leading: Image.asset(
                    item.imagePath,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preço: R\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total: R\$${itemTotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (item.quantity > 1) {
                              item.quantity--;
                            } else {
                              cartItems.removeAt(index);
                            }
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 198, 40, 40),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            item.quantity++;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 48, 191, 62),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Sub-Total: R\$ ${calculateTotal().toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Frete: R\$ ${shippingCost.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Total: R\$ ${calculateGrandTotal().toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _startAnimation();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isProcessing ? null : const Color.fromARGB(255, 48, 191, 62),
              foregroundColor: Colors.white,
              elevation: 3,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10),
              // ),
            ),
            child: AnimatedBuilder(
              animation: _buttonColorAnimation,
              builder: (context, child) {
                return isProcessing
                    ? const SpinKitCircle(
                        color: Colors.white,
                        size: 24,
                      )
                    : child!;
              },
              child: Text(
                isAnimationCompleted ? 'Finalizado' : 'Finalizar Compra',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal() {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double calculateGrandTotal() {
    return calculateTotal() + shippingCost;
  }

  void _startAnimation() {
    setState(() {
      isProcessing = true;
    });

    _animationController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    });
  }
}

class CartItem {
  String name;
  int quantity;
  double price;
  String imagePath;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.imagePath,
  });
}
