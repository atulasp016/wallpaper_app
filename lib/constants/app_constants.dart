import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/utils/app_images.dart';

class AppConstant {
  static const String PEXELS_API_KEY =
      'mJ5yhar6h6xnTN6kLdceqVpvfRNOXzG91rydPl3r0Ul6DUglhbSgzwyt';

  static const List<Map<String, dynamic>> mColors = [
    {'color': Color(0xfffdb7b9), 'code': 'fdb7b9'},
    {'color': Color(0xff68bfc1), 'code': '68bfc1'},
    {'color': Color(0xff292929), 'code': '292929'},
    {'color': Color(0xffff9b0b), 'code': 'ff9b0b'},
    {'color': Color(0xffb646ea), 'code': 'b646ea'},
    {'color': Color(0xFF2E3E5C), 'code': '2E3E5C'},
    {'color': Color(0xFF1FCC79), 'code': '1FCC79'},
    {'color': Color(0xFFFF4081), 'code': 'FF4081'},
    {'color': Color(0xFF40C4FF), 'code': '40C4FF'},
    {'color': Color(0xFFFFAB40), 'code': 'FFAB40'},
    {'color': Color(0xFFD7CCC8), 'code': 'D7CCC8'},
    {'color': Color(0xFF3F51B5), 'code': '3F51B5'},
    {'color': Color(0xFF009688), 'code': '009688'},
    {'color': Color(0xFFFF5722), 'code': 'FF5722'},
  ];
  static final List<CategoryModel> mCategory = [
    CategoryModel(
        title: 'Abstract',
        image:
            'https://images.pexels.com/photos/2130475/pexels-photo-2130475.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    CategoryModel(
        title: 'Nature',
        image:
            'https://images.pexels.com/photos/1172064/pexels-photo-1172064.jpeg?auto=compress&cs=tinysrgb&w=400'),
    CategoryModel(
        title: 'Space',
        image:
            'https://images.pexels.com/photos/2832084/pexels-photo-2832084.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    CategoryModel(
        title: 'Animals',
        image:
            'https://images.pexels.com/photos/792381/pexels-photo-792381.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    CategoryModel(
        title: 'Ocean',
        image:
            'https://images.pexels.com/photos/189349/pexels-photo-189349.jpeg?cs=srgb&dl=pexels-sebastian-189349.jpg&fm=jpg'),
    CategoryModel(
        title: 'People',
        image:
            'https://images.pexels.com/photos/837358/pexels-photo-837358.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    CategoryModel(
        title: 'Fruits',
        image:
            'https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    CategoryModel(
        title: 'Sports',
        image:
            'https://images.pexels.com/photos/46798/the-ball-stadion-football-the-pitch-46798.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  ];
  static final List<Map<String, dynamic>> dataList = [
    {'icon': AppImages.IC_INFO, 'text': 'info'},
    {'icon': AppImages.IC_DOWNLOAD, 'text': 'save'},
    {'icon': AppImages.IC_APPLY, 'text': 'Apply'},
  ];
}

// Primary Colors

// Accent Colors
