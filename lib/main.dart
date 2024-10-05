import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'routes.dart';
import 'image_view.dart';
import 'dart:math' as math;

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
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => ImageGallery(),
        Routes.imageView: (context) => ImageView(),
      },
    );
  }
}

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  final List<String> images = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.png',
    // Adicione mais caminhos de imagens
  ];

  void _addImage() {
    setState(() {
      images.add('assets/images/image4.jpg'); // Adiciona uma nova imagem
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addImage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child: Text(
                'Hello Flutter',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),
            Text('Hello world'),
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            Column(
              children: [
                Text('item 1'),
                Text('item 2'),
                Text('item 3'),
              ],
            ),
            Row(
              children: [
                Text('item 1'),
                Text('item 2'),
                Text('item 3'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                print('TOCOU NO BOTAO');
              },
              child: Text('Incrementar'),
            ),
            Icon(
              Icons.star,
              color: Colors.blue,
              size: 30,
            ),
            Card(
              child: ListTile(
                title: Text('titulo'),
                subtitle: Text('subtitulo'),
                leading: Icon(Icons.info),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            DropdownButton<String>(
              items: ['Option 1', 'Option 2', 'Option 3'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
              value: 'Option 1',
            ),
            Switch(value: false, onChanged: (value) {}),
            Checkbox(value: false, onChanged: (value) {}),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red,
                    width: 200,
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    width: 200,
                    height: 50,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 100,
              height: 20,
              child: Text(
                'HELLO WORLD COM SIZEDBOX',
                style: TextStyle(color: Colors.green),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red,
                    width: 200,
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    width: 200,
                    height: 50,
                  ),
                ),
              ],
            ),
            _CustomImages(images: images),
            ListView.builder(
              itemCount: 400,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _CustomAnimation();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomImages extends StatefulWidget {
  const _CustomImages({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<_CustomImages> createState() => __CustomImagesState();
}

class __CustomImagesState extends State<_CustomImages> {
  void _removeImage(int index) {
    setState(() {
      widget.images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Número de colunas
      ),
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.imageView,
              arguments: widget.images[index],
            );
          },
          onLongPress: () {
            _removeImage(index);
          },
          child: Card(
            child: Image.asset(widget.images[index]),
          ),
        );
      },
    );
  }
}

class _CustomAnimation extends StatefulWidget {
  @override
  State<_CustomAnimation> createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<_CustomAnimation> {
  Color _color = Colors.blue;
  double _width = 200.0;
  double _height = 200.0;

  @override
  void initState() {
    super.initState();

    // runs every 1 second
    Timer.periodic(new Duration(seconds: 1), (timer) {
      _change();
    });
  }

  void _change() {
    var rng = Random();
    var randomColor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    setState(() {
      _color = randomColor;
      _width = rng.nextInt(200).toDouble();
      _height = rng.nextInt(200).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      width: _width,
      height: _height,
      color: _color,
      child: const Center(
        child: Text(
          'Tap me!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
