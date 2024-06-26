import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/download.dart';
import 'package:wallpaper_app/pages/home/home.dart';
import 'package:wallpaper_app/pages/profile.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/utils/app_images.dart';

class HomeBNB extends StatefulWidget {
  const HomeBNB({super.key});

  @override
  State<HomeBNB> createState() => _HomeBNBState();
}

class _HomeBNBState extends State<HomeBNB> {
  int pageIndex = 0;

  List pages = [
    HomePage(),
    const Center(
      child: Text(
        'Download',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 30,
        ),
      ),
    ),
    const Center(
      child: Text(
        'Profile',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 30,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: AppColors.secondaryLightColor,
        iconSize: 30,
        enableFeedback: true,
        elevation: 5,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(AppImages.IC_IMAGE,width: 30,), label: ''),
          BottomNavigationBarItem(
              icon: Image.asset(AppImages.IC_DOWNLOAD,width: 30,), label: ''),
          BottomNavigationBarItem(
              icon: Image.asset(AppImages.IC_PROFILE,width: 30,), label: ''),
        ],
      ),
    );
  }
}
