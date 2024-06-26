import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/remote/api_helpers.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/pages/home/home.dart';
import 'package:wallpaper_app/pages/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/pages/home/cubit/home_cubit.dart';
import 'package:wallpaper_app/pages/home/home_bnb.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/utils/app_colors.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) => HomeCubit(
            wallPaperRepository: WallPaperRepository(apiHelper: ApiHelper()))),
    BlocProvider(
        create: (context) => SearchCubit(
            wallPaperRepository: WallPaperRepository(apiHelper: ApiHelper()))),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper App',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppColors.primaryLightColor),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
