import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../app_colors.dart';
import '../routes.dart';

part '../widgets/custom_images.dart';

class ImageGalleryScreen extends StatefulWidget {
  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
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
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: AppColors.background,
        ),
        title: Text(
          'Image Gallery',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.background,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Accelerometer Data',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 8.0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'X: ${_accelerometerEvent?.x.toStringAsFixed(2) ?? '0.00'} \n',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Y: ${_accelerometerEvent?.y.toStringAsFixed(2) ?? '0.00'} \n',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Z: ${_accelerometerEvent?.z.toStringAsFixed(2) ?? '0.00'} \n',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _CustomImages(images: _imagesUrls),
                ],
              ),
            ),
    );
  }
}
