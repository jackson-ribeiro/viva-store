import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:viva_store/Class/Produto.dart';

class ProdutoFire {
  static Future<List<Produto>> getProducts() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('produto').get();

    List<Produto> products = [];

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      String id = data['id_produto'];
      String nome_prod = data['nome_prod'];
      double valor = double.parse(data['valor']);
      int estoque = int.parse(data['estoque']);
      String imageUrl = data['imagem_prod'];
      String desc_prod = data['desc_prod'];
      String categoria = data['categoria_prod'];

      Produto produtos = Produto(
        nome_prod: nome_prod,
        valor: valor,
        estoque: estoque,
        imageUrl: imageUrl,
        desc_prod: desc_prod,
        categoria: categoria,
      );
      produtos.id = id;

      products.add(produtos);
    }

    return products;
  }

  static Future<List<Produto>> getProductsByCategory(String category) async {
    List<Produto> produtos = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('produto')
          .where('categoria_prod',
              isEqualTo: category)
          .get();

      querySnapshot.docs.forEach((doc) {
        Produto produto = Produto(
          nome_prod: doc['nome_prod'],
          desc_prod: doc['desc_prod'],
          valor:
              double.parse(doc['valor'].toString()),
          imageUrl: doc['imagem_prod'],
          categoria: doc['categoria_prod'],
          estoque: int.parse(doc['estoque'].toString()),
        );
        produtos.add(produto);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar produtos por categoria: $e');
      }
    }

    return produtos;
  }

  static Future<List<Produto>> searchProducts(String search) async {
    List<Produto> produtos = [];

    if (search.isNotEmpty) {
      try {
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection('produto').get();

        querySnapshot.docs.forEach((doc) {
          Produto produto = Produto(
            nome_prod: doc['nome_prod'],
            desc_prod: doc['desc_prod'],
            valor: double.parse(doc['valor'].toString()),
            imageUrl: doc['imagem_prod'],
            categoria: doc['categoria_prod'],
            estoque: int.parse(doc['estoque'].toString()),
          );

          // Verificar se o nome do produto contém a letra pesquisada (ignorando maiúsculas e minúsculas)
          if (produto.nome_prod.toLowerCase().contains(search.toLowerCase())) {
            produtos.add(produto);
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('Erro ao buscar produtos: $e');
        }
      }
    } else {
      produtos = await getProducts(); // Obter todos os produtos
    }

    return produtos;
  }
}
