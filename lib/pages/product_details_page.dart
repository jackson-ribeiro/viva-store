import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget{
  String img;
  ProductDetails(this.img, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height / 1.7,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 224, 224),
                image: DecorationImage(
                  image: AssetImage("images/$img.png"),
                  fit: BoxFit.cover
                )
              ),
              child: Padding(
                padding:  const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    )
                  ],
                ),
                ),
            )
          ]
          ),
      ),
    );
  }

}