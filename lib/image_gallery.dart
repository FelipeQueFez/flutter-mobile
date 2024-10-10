import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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
  final List<String> _imagesUrls = [];
  bool _loading = false;
  final ImagePicker _picker = ImagePicker();
  AccelerometerEvent? _accelerometerEvent;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (_auth.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, Routes.login);
        return;
      });
    }

    accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerEvent = event;
      });
    });

    _listImages();

    super.initState();
  }

  void _listImages() async {
    setState(() {
      _loading = true;
    });

    final ListResult result =
        await FirebaseStorage.instance.ref('uploads').list();

    final List<String> urls = await Future.wait(
      result.items.map((element) async {
        return await element.getDownloadURL();
      }),
    );

    setState(() {
      _loading = false;
      _imagesUrls.addAll(urls);
    });
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        var file = File(pickedFile.path);

        _uploadImage(file);
      }
    } catch (e) {
      print(e);
    }
  }

  void _uploadImage(File file) async {
    try {
      setState(() {
        _loading = true;
      });

      String fileName = file.path.split('/').last;

      var storageRef = FirebaseStorage.instance.ref('uploads/$fileName');
      await storageRef.putFile(file);

      var url = await storageRef.getDownloadURL();

      setState(() {
        _loading = false;
        _imagesUrls.add(url);
      });
    } catch (e) {
      print(e);
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text('Acelerometro: \n'
                  'X: ${_accelerometerEvent?.x.toStringAsFixed(2) ?? '0.00'} \n'
                  'Y: ${_accelerometerEvent?.y.toStringAsFixed(2) ?? '0.00'} \n'
                  'Z: ${_accelerometerEvent?.z.toStringAsFixed(2) ?? '0.00'} \n'),
            ),
            if (_loading)
              const CircularProgressIndicator()
            else
              _CustomImages(images: _imagesUrls),
          ],
        ),
      ),
    );
  }
}
