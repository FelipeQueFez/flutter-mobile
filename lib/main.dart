import 'package:flutter/material.dart';
import 'package:image_gallery_app/image_view.dart';

import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        Routes.home: (context) => ImageGallery(),
        Routes.imageView: (context) => ImageView(),
      },
    );
  }
}

class ImageGallery extends StatelessWidget {
  final List<String> images = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.png',
    // Adicione mais caminhos de imagens
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de colunas
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.imageView,
                arguments: images[index],
              );
            },
            child: Card(
              child: Image.asset(images[index]),
            ),
          );
        },
      ),
    );
  }
}
