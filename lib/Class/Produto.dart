import 'package:uuid/uuid.dart' show Uuid;

class Produto {
  String id = const Uuid().v4();
  late final String nome_prod;
  late final double valor;
  late final int estoque;
  late final String imageUrl;
  late final String desc_prod;
  late final String categoria;

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

  // Setters
  set setId(String newId) {
    id = newId;
  }

  set setNomeProd(String newNomeProd) {
    nome_prod = newNomeProd;
  }

  set setValor(double newValor) {
    valor = newValor;
  }

  set setEstoque(int newEstoque) {
    estoque = newEstoque;
  }

  set setImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  set setDescProd(String newDescProd) {
    desc_prod = newDescProd;
  }

  set setCategoria(String newCategoria) {
    categoria = newCategoria;
  }

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
