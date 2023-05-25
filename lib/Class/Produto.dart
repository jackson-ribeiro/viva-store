// ignore_for_file: file_names

import 'package:uuid/uuid.dart' show Uuid;

class Produto {
  late String id = const Uuid().v4();
  final String nome_prod;
  final double valor;
  final int estoque;
  final String imageUrl;
  final String desc_prod;
  final String categoria;

  Produto({
    required this.nome_prod,
    required this.valor,
    required this.estoque,
    required this.imageUrl,
    required this.desc_prod,
    required this.categoria,
  });

  // Getters
  String get getId => id;
  String get getNomeProd => nome_prod;
  double get getValor => valor;
  int get getEstoque => estoque;
  String get getImageUrl => imageUrl;
  String get getDescProd => desc_prod;
  String get getCategoria => categoria;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome_prod': nome_prod,
      'valor': valor,
      'imageUrl': imageUrl,
      'desc_prod': desc_prod,
      'categoria': categoria,
      'estoque': estoque,
    };
  }
}
