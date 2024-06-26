import 'package:flutter/material.dart';
import 'package:wallpaper_app/utils/app_colors.dart';

class WallPaperBgWidget extends StatelessWidget {
  String urlImage;
  VoidCallback? onTap;
  double height;
  double width;

  WallPaperBgWidget({
    super.key,
    required this.urlImage,
     this.onTap,
    this.height = 200,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.primaryLightColor,
          borderRadius: BorderRadius.circular(8),
          image:
              DecorationImage(image: NetworkImage(urlImage), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
