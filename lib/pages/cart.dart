import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Class/Produto.dart';

class CartPage extends StatelessWidget {
  final List<Produto> carrinho;

  const CartPage({Key? key, required this.carrinho}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
      ),
      body: ListView.builder(
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          final produto = carrinho[index];
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: produto.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 50,
              width: 50,
            ),
            title: Text(produto.nome_prod),
            subtitle: Text(produto.desc_prod),
          );
        },
      ),
    );
  }
}
