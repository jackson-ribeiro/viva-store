import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Class/Produto.dart';

class ProductPage extends StatefulWidget {
  final Produto produto;
  final List<Produto> carrinho;
  final void Function(Produto produto) adicionarAoCarrinho;

  const ProductPage({
    Key? key,
    required this.produto,
    required this.carrinho,
    required this.adicionarAoCarrinho,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: MediaQuery.of(context).size.height / 1.7,
                      color: const Color.fromARGB(255, 224, 224, 224),
                      child: CachedNetworkImage(
                        imageUrl: widget.produto.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.produto.nome_prod,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'R\$ ${widget.produto.valor.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.produto.categoria,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 104, 104, 104),
                              ),
                            ),
                            Text(
                              widget.produto.estoque > 0
                                  ? 'Estoque: ${widget.produto.estoque}'
                                  : 'Indisponível',
                              style: TextStyle(
                                color: widget.produto.estoque > 0
                                    ? Color.fromARGB(255, 15, 181, 32)
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          widget.produto.desc_prod,
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _adicionarAoCarrinho();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Adicionar ao carrinho',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 48, 191, 62),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
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
