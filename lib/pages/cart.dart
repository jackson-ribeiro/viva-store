import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import '../Class/Produto.dart';
import 'home_page.dart';

class CartPage extends StatefulWidget {
  final List<Produto> carrinho;

  const CartPage({Key? key, required this.carrinho}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double shippingCost = 0.0;
  TextEditingController cepController = TextEditingController();

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        title: const Text(
          'Viva Store - Meu Carrinho',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: Icon(Icons.arrow_back),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.carrinho.length,
              itemBuilder: (BuildContext context, int index) {
                final produto = widget.carrinho[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(14),
                  padding: const EdgeInsets.all(14),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: produto.imageUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 50,
                      height: 50,
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            produto.nome_prod,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.carrinho.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.remove_circle),
                          color: Colors.red,
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'R\$${produto.valor.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Digite o CEP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: cepController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Digite o CEP',
                      suffixIcon: IconButton(
                        onPressed: () {
                          calculateShippingCost(cepController.text);
                        },
                        icon: const Icon(Icons.search,
                            color: Color.fromARGB(255, 48, 191, 62)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 8),
                Text(
                  'Sub-Total: R\$ ${calculateTotal().toStringAsFixed(2)}',
                ),
                const SizedBox(height: 8),
                Text(
                  'Frete: R\$ ${shippingCost.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: R\$ ${calculateGrandTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _showConfirmationDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 48, 191, 62),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Finalizar Compra',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double calculateProductTotal(Produto produto) {
    return produto.valor * produto.estoque;
  }

  double calculateTotal() {
    return widget.carrinho
        .fold(0, (sum, produto) => sum + calculateProductTotal(produto));
  }

  double calculateGrandTotal() {
    return calculateTotal() + shippingCost;
  }

  Future<void> calculateShippingCost(String cep) async {
    String cepOrigem = '60130240';
    String cepDestino = cep;
    String peso = '1.5';
    String formato = '1';
    String comprimento = '20';
    String altura = '10';
    String largura = '15';
    String diametro = '0';

    String url =
        'https://melhorenvio.com.br/api/v2/calculator?from=$cepOrigem&to=$cepDestino&weight=$peso&length=$comprimento&width=$largura&height=$altura&diameter=$diametro';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json[0]['price']);
      setState(() {
        this.shippingCost = double.parse(json[0]['price']);
      });
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text(
                'Erro ao calcular o frete. Por favor, verifique o CEP informado.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showConfirmationDialog() {
    String cep = cepController.text.trim();

    if (cep.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Atenção'),
            content:
                const Text('Digite um CEP válido para finalizar a compra.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Retorna para impedir a exibição do diálogo de confirmação
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://static-00.iconduck.com/assets.00/successful-purchase-illustration-512x352-ok8qwrme.png',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 8),
              const Text('Deseja finalizar a compra?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para finalizar a compra
                // por exemplo, limpar o carrinho, salvar os dados no banco de dados, etc.
                // Depois de finalizar, você pode navegar para a página inicial
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                ),
              ),
              child: const Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                ),
              ),
              child: const Text('Não'),
            ),
          ],
        );
      },
    );
  }
}
