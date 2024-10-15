part of '../screens/image_gallery_screen.dart';

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
      padding: EdgeInsets.all(12),
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
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete image'),
                    content: Text('Are you sure you want delete this image?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _removeImage(index);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.images[index],
                    fit: BoxFit.cover,
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
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.badge.withOpacity(0.6),
                    ),
                    child: Text(
                      'Tap to view',
                      style:
                          TextStyle(color: AppColors.background, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
