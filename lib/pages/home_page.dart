import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color:Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
