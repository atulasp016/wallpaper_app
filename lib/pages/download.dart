import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_app/constants/app_constants.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/utils/app_images.dart';
import 'package:wallpaper_app/utils/app_styles.dart';

class DownloadPage extends StatelessWidget {
  SrcModel imgModel;
  int mIndex;

  DownloadPage({super.key, required this.imgModel, required this.mIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: mIndex,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imgModel.portrait!),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    getActionBtn(
                        icImage: AppImages.IC_INFO,
                        title: 'Info',
                        onTap: () {
                          infoWallpaper();
                        }),
                    getActionBtn(
                        icImage: AppImages.IC_DOWNLOAD,
                        title: 'Save',
                        onTap: () {
                          saveWallpaper(context);
                        }),
                    getActionBtn(
                        bgColor: AppColors.mainColor,
                        icImage: AppImages.IC_APPLY,
                        title: 'Apply',
                        onTap: () {
                          applyWallpaper(context);
                        }),
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget getActionBtn(
      {required String title,
      required String icImage,
      required VoidCallback onTap,
      Color? bgColor}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(5),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: bgColor != null ? AppColors.mainColor : Colors.black38,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Image.asset(
                icImage,
                filterQuality: FilterQuality.low,
                color: AppColors.whiteColor,
                width: 30,
              ),
            ),
          ),
        ),
        Text(
          title,
          style: mTextStyle16(
              mColor: AppColors.whiteColor, mFontWeight: FontWeight.w500),
        ),
        SizedBox(height: 21)
      ],
    );
  }

  void infoWallpaper() {}

  void saveWallpaper(BuildContext context) {
    GallerySaver.saveImage(imgModel.portrait!).then((value) =>
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wallpaper saved onto gallery!!'))));
  }

  void applyWallpaper(BuildContext context) {
    Wallpaper.imageDownloadProgress(imgModel.portrait!).listen((event) {
      print(event);
    }, onDone: () {
      Wallpaper.homeScreen(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              options: RequestSizeOptions.RESIZE_FIT)
          .then((value) {
        print(value);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wallpaper set on HOME SCREEN!!')));
      });
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Download ERROR: $e,\tError while setting the wallpaper!!')));
    });
  }
}
