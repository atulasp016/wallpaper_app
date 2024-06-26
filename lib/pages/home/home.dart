import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/constants/app_constants.dart';
import 'package:wallpaper_app/pages/download.dart';
import 'package:wallpaper_app/pages/home/cubit/home_cubit.dart';
import 'package:wallpaper_app/pages/search/search_page.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/utils/app_styles.dart';
import 'package:wallpaper_app/widgets/wallpaper_bg_widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: ListView(
        children: [
          ///1
          Container(height: 11),

          ///2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
            child: TextField(
              controller: searchController,
              enableSuggestions: true,
              style: mTextStyle22(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 31),
                fillColor: AppColors.secondaryLightColor,
                filled: true,
                hintText: 'Find Wallpaper',
                hintStyle: mTextStyle12(mColor: Colors.grey.shade400),
                suffixIcon: InkWell(
                  onTap: () {
                    if (searchController.text.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchDetailPage(
                                  query: searchController.text,
                                  color:
                                      AppConstant.mColors.length.toString())));
                    }
                  },
                  child: Icon(CupertinoIcons.search,
                      color: Colors.grey.shade400, size: 25),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),

          ///3
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 11.0, horizontal: 16),
              child: getText(
                  title: 'Best of the month',
                  textStyle: mTextStyle22(mFontWeight: FontWeight.bold))),

          SizedBox(
              height: 250,
              child: BlocBuilder<HomeCubit, HomeState>(builder: (_, state) {
                if (state is HomeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeErrorState) {
                  return Center(
                      child: Text(
                    'Error: ${state.errorMsg}',
                    style: const TextStyle(color: Colors.black),
                  ));
                } else if (state is HomeLoadedState) {
                  return ListView.builder(
                      itemCount: state.listPhotos.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        var eachPhotos = state.listPhotos[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 11,
                              right: index == state.listPhotos.length - 1
                                  ? 11
                                  : 0),
                          child: Hero(
                            tag: index,
                            child: WallPaperBgWidget(
                                urlImage: eachPhotos.src!.portrait!,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DownloadPage(
                                              imgModel: eachPhotos.src!,
                                              mIndex: index)));
                                }),
                          ),
                        );
                      });
                }
                return Container();
              })),

          ///4
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: getText(
                  title: 'Color Tone',
                  textStyle: mTextStyle22(mFontWeight: FontWeight.bold))),

          SizedBox(
            height: 50,
            child: ListView.builder(
                itemCount: AppConstant.mColors.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 8,
                        right: index == AppConstant.mColors.length - 1 ? 5 : 0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchDetailPage(
                                        query: searchController.text.isNotEmpty
                                            ? searchController.text
                                            : 'Nature',
                                        color: AppConstant.mColors[index]
                                            ['code'],
                                      )));
                        },
                        child: getColorToneWidget(
                            mColor: AppConstant.mColors[index]['color'])),
                  );
                }),
          ),

          ///5
          const SizedBox(height: 21),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: getText(
                  title: 'Categories',
                  textStyle: mTextStyle22(mFontWeight: FontWeight.bold))),

          GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 11),
              itemCount: AppConstant.mCategory.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 11,
                  crossAxisSpacing: 11,
                  childAspectRatio: 7 / 4),
              itemBuilder: (_, index) {
                var eachData = AppConstant.mCategory[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchDetailPage(
                                  query: eachData.title,
                                  color: AppConstant.mColors.length.toString(),
                                )));
                  },
                  child: getCategoryWidget(
                      title: eachData.title,
                      urlImage: eachData.image,
                      textStyle: mTextStyle16(
                          mColor: AppColors.whiteColor,
                          mFontWeight: FontWeight.bold)),
                );
              }),
        ],
      ),
    );
  }

  Widget getText({required String title, required TextStyle textStyle}) {
    return Text(title, style: textStyle);
  }

  Widget getColorToneWidget({required Color mColor}) {
    return Container(
      height: 50,
      width: 50,
      decoration:
          BoxDecoration(color: mColor, borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget getCategoryWidget(
      {required String title,
      required TextStyle textStyle,
      required String urlImage}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryLightColor,
          borderRadius: BorderRadius.circular(8),
          image:
              DecorationImage(image: NetworkImage(urlImage), fit: BoxFit.fill)),
      child: Center(
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}
