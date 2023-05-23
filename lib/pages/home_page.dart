import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: Drawer(),
        appBar: AppBar(
          title: Text(
            "Viva Store",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _key.currentState?.openDrawer();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.send, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 2.0)),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {}),
                ),
              ),
              SizedBox(
                  height:
                      16), // Adiciona um espaço de 16 pixels entre o TextField e o banner azul
              Container(
                height: 190,
                color: Colors.blue,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BANNER"),
                  ],
                ),
              ),
              SizedBox(
                  height:
                      16), // Adiciona um espaço de 16 pixels entre o banner azul e o carrossel
              CarouselSlider(items: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.orange,
                )
              ], options: CarouselOptions(height: 150)),
              SizedBox(
                  height:
                      16), // Adiciona um espaço de 16 pixels entre o carrossel e os cartões
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: _buildCard(context, 'Item A', 'Descrição do Item A',
                        '\$10', 'assets/item_a.png')),
                SizedBox(width: 8),
                Expanded(
                    child: _buildCard(context, 'Item B', 'Descrição do Item B',
                        '\$20', 'assets/item_b.png')),
              ]),
              SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: _buildCard(context, 'Item C', 'Descrição do Item C',
                        '\$30', 'assets/item_c.png')),
                SizedBox(width: 8),
                Expanded(
                    child: _buildCard(context, 'Item D', 'Descrição do Item D',
                        '\$40', 'assets/item_d.png')),
              ])
            ])));
  }

  Widget _buildCard(BuildContext context, String name, String description,
      String price, String imagePath) {
    return Card(
        elevation: 4,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: (MediaQuery.of(context).size.width / 3) - 12,
            width: (MediaQuery.of(context).size.width / 3) - 12,
          ), // Define a altura e largura da imagem como um terço da largura da tela menos a margem horizontal
          Padding(padding: EdgeInsets.all(8)),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Padding(padding: EdgeInsets.all(4)),
          Text(description, style: TextStyle(fontSize: 12)),
          Padding(padding: EdgeInsets.all(4)),
          Text(price, style: TextStyle(fontWeight: FontWeight.bold))
        ]));
  }
}
