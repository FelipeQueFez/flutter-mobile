import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String imagePath =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('View image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Voltar para a tela anterior'),
          ),
        ],
      ),
    );
  }
}
