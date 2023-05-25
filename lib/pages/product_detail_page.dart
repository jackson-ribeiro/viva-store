import 'package:flutter/material.dart';
import '../Class/Produto.dart';

class ProductPage extends StatefulWidget {
  final Produto produto;
  final List<Produto> carrinho;

  const ProductPage({
    Key? key,
    required this.produto,
    required this.carrinho,
    required void Function(Produto produto) adicionarAoCarrinho,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.produto.nome_prod,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        widget.produto.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.produto.desc_prod,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'R\$ ${widget.produto.valor.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _adicionarAoCarrinho();
                },
                child: const Text('Adicionar ao Carrinho'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _adicionarAoCarrinho() {
    setState(() {
      widget.carrinho.add(widget.produto);
    });
  }
}
