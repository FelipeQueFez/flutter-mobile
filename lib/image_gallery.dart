import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  AccelerometerEvent? _accelerometerEvent;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerEvent = event;
      });
    });

    super.initState();
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        var file = File(pickedFile.path);

        setState(() {
          images.add(file);
        });

        _uploadImage(file);
      }
    } catch (e) {
      print(e);
    }
  }

  void _uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;

      await FirebaseStorage.instance.ref('uploads/$fileName').putFile(file);
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
            Text('Acelerometro: \n'
                'X: ${_accelerometerEvent?.x.toStringAsFixed(2) ?? '0.00'} \n'
                'Y: ${_accelerometerEvent?.y.toStringAsFixed(2) ?? '0.00'} \n'
                'Z: ${_accelerometerEvent?.z.toStringAsFixed(2) ?? '0.00'} \n'),
            _CustomImages(images: images),
          ],
        ),
      ),
    );
  }
}
