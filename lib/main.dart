import 'package:flutter/material.dart';

void main() {
  runApp(MinhaPrimeiraTela());
}

class MinhaPrimeiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image gallery app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageGallery(),
    );
  }
}

class ImageGallery extends StatelessWidget {
  final List<String> images = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.png',
  ];

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titulo da minha pagina"),
      ),
      body: GridView.builder(
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de colunas
        ),
        itemBuilder: (context, index) {
          return Card(
            child: Image.asset(images[index]),
          );
        },
      ),
    );
  }
}
