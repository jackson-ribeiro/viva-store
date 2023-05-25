import 'package:flutter/material.dart';
import 'package:viva_store/ProdutosFire.dart';
import 'package:viva_store/Class/Produto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:viva_store/pages/product_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List<Produto> produtoList = []; // Lista de produtos
  List<String> categorias = [
    'todos',
    'vestuário',
    'decoração',
    'beleza',
    'cama, mesa e banho'
  ];
  String categoriaSelecionada = 'todos';
  String searchTerm = '';
  List<Produto> carrinho = []; // Lista de produtos no carrinho

  @override
  void initState() {
    super.initState();
    fetchProdutos(); // Chamar o método para buscar todos os produtos
  }

  // Método para buscar todos os produtos
  void fetchProdutos() async {
    List<Produto> produtos = await ProdutoFire.getProducts();
    setState(() {
      produtoList = produtos;
    });
  }

  // Método para buscar os produtos pela categoria selecionada
  void fetchProdutosByCategory(String category) async {
    List<Produto> produtos = await ProdutoFire.getProductsByCategory(category);
    setState(() {
      produtoList = produtos;
    });
  }

  // Método para buscar os produtos pelo termo de pesquisa
  void searchProducts(String search) async {
    List<Produto> produtos = await ProdutoFire.searchProducts(search);
    setState(() {
      produtoList = produtos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text(
          "Viva Store",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              _openCarrinho(); // Chama o método para exibir o carrinho
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide:
                      const BorderSide(color: Colors.yellow, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide:
                      const BorderSide(color: Colors.yellow, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide:
                      const BorderSide(color: Colors.yellow, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    searchProducts(searchTerm);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(categorias[index]),
                    selected: categoriaSelecionada == categorias[index],
                    onSelected: (selected) {
                      setState(() {
                        categoriaSelecionada = categorias[index];
                        if (categoriaSelecionada == 'todos') {
                          fetchProdutos();
                        } else {
                          fetchProdutosByCategory(categoriaSelecionada);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: produtoList.length,
              itemBuilder: (context, index) {
                final produto = produtoList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(
                          produto: produto,
                          carrinho: carrinho,
                          adicionarAoCarrinho: _adicionarAoCarrinho,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.0),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: produto.imageUrl,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produto.nome_prod,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                produto.desc_prod,
                                style: TextStyle(color: Colors.grey[600]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _adicionarAoCarrinho(Produto produto) {
    setState(() {
      carrinho.add(produto); // Adiciona o produto ao carrinho
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Produto adicionado ao carrinho'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openCarrinho() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarrinhoPage(carrinho: carrinho),
      ),
    );
  }
}

class CarrinhoPage extends StatelessWidget {
  final List<Produto> carrinho;

  const CarrinhoPage({Key? key, required this.carrinho}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: ListView.builder(
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          final produto = carrinho[index];
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: produto.imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
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
