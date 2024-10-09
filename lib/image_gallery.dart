import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'routes.dart';

part './custom_images.dart';

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  final List<File> images = [
    // 'assets/images/image1.jpg',
    // 'assets/images/image2.jpg',
    // 'assets/images/image3.png',
    // Adicione mais caminhos de imagens
  ];

  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          images.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // void _addImage() {
  //   setState(() {
  //     images.add('assets/images/image4.jpg'); // Adiciona uma nova imagem
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CustomImages(images: images),
          ],
        ),
      ),
    );
  }
}
