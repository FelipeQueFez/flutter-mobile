import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'image_gallery.dart';
import 'routes.dart';
import 'image_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => ImageGallery(),
        Routes.imageView: (context) => ImageView(),
      },
    );
  }
}
