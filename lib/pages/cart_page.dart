import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
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
    double total =
        cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

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
                    cartItems[index].imagePath,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(cartItems[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Preço: R\$ ${item.price.toStringAsFixed(2)}'),
                      Text('Total: R\$ ${itemTotal.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (cartItems[index].quantity > 1) {
                              cartItems[index].quantity--;
                            } else {
                              cartItems.removeAt(index);
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(cartItems[index].quantity.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cartItems[index].quantity++;
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
            title: Text('Sub-Total: R\$ ${total.toStringAsFixed(2)}'),
          ),
          ListTile(
            title: Text('Frete: R\$ ${shippingCost.toStringAsFixed(2)}'),
          ),
          ListTile(
            title:
                Text('Total: R\$ ${(total + shippingCost).toStringAsFixed(2)}'),
          ),
        ],
      ),
    );
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
