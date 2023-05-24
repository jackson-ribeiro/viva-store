import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:viva_store/ProdutosFire.dart';
import 'package:viva_store/Class/Produto.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
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
    'cama',
    'mesa e banho'
  ];
  String categoriaSelecionada = 'todos';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(),
      appBar: AppBar(
        title: const Text(
          "Viva Store",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _key.currentState?.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
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
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 190,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://s2.glbimg.com/1o2J-rf2G9qtlQlm82gaq-mFBec=/0x129:1024x952/924x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2023/7/i/ME2AxRRoygUyFPCDe0jQ/3.png',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.blue),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CarouselSlider(
                    items: categorias.map((categoria) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            categoriaSelecionada = categoria;
                            if (categoriaSelecionada == 'todos') {
                              fetchProdutos(); // Buscar todos os produtos novamente
                            } else {
                              fetchProdutosByCategory(
                                  categoriaSelecionada); // Buscar os produtos pela categoria selecionada
                            }
                          });
                        },
                        child: Container(
                          color: categoria == categoriaSelecionada
                              ? Colors.grey[400]
                              : Colors.grey[200],
                          child: Center(
                            child: Text(
                              categoria.toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: categoria == categoriaSelecionada
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 40,
                      viewportFraction: 0.25,
                      initialPage: categorias.indexOf(categoriaSelecionada),
                      enableInfiniteScroll: false,
                      onPageChanged: (index, _) {
                        setState(() {
                          categoriaSelecionada = categorias[index];
                          if (categoriaSelecionada == 'todos') {
                            fetchProdutos(); // Buscar todos os produtos novamente
                          } else {
                            fetchProdutosByCategory(
                                categoriaSelecionada); // Buscar os produtos pela categoria selecionada
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    childAspectRatio: 0.8,
                    children: produtoList
                        .map(
                          (produto) => _buildCard(
                            context,
                            produto.nome_prod,
                            produto.desc_prod,
                            produto.valor.toStringAsFixed(2),
                            produto.imageUrl,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String name,
    String description,
    String price,
    String imagePath,
  ) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Padding(padding: EdgeInsets.all(4)),
          Text(
            description,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const Padding(padding: EdgeInsets.all(4)),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
