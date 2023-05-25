import 'package:flutter/material.dart';
import 'home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Lógica para esvaziar o carrinho
              setState(() {
                cartItems.clear();
              });
            },
          ),
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
                      Text('Preço: R\$${item.price.toStringAsFixed(2)}'),
                      // Text('Quantity: ${item.quantity}'),
                      Text('Total: R\$${itemTotal.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (item.quantity > 1) {
                              item.quantity--;
                            } else {
                              cartItems.removeAt(index);
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            item.quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ListTile(
            title:
                Text('Sub-Total: R\$ ${calculateTotal().toStringAsFixed(2)}'),
          ),
          ListTile(
            title: Text('Frete: R\$ ${shippingCost.toStringAsFixed(2)}'),
          ),
          ListTile(
            title:
                Text('Total: R\$ ${calculateGrandTotal().toStringAsFixed(2)}'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para finalizar a compra
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Compra Finalizada'),
                    content: const Text('Obrigado por sua compra!'),
                    actions: [
                      TextButton(
                        child: const Text('Fechar'),
                        onPressed: () {
                          //navegar para a página inicial
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Finalizar Compra'),
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
}

class CartItem {
  String name;
  int quantity;
  double price;
  String imagePath;

  CartItem(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.imagePath});
}
