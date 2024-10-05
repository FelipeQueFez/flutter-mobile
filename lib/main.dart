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
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                ListTile(title: Text('item1')),
                ListTile(title: Text('item2')),
                ListTile(title: Text('item3')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
