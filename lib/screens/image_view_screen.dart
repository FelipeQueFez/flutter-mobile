import 'package:flutter/material.dart';

import '../app_colors.dart';

class ImageViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String imagePath =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      backgroundColor: AppColors.backgroundScreen,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: AppColors.background,
        ),
        title: Text(
          'View image',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.background,
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(10),
          child: Image.network(
            imagePath,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.error,
                  color: AppColors.error,
                ),
              );
            },
          ),
          decoration: BoxDecoration(
            color: AppColors.background,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
