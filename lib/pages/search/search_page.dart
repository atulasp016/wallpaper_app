import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/pages/download.dart';
import 'package:wallpaper_app/pages/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/utils/app_styles.dart';
import 'package:wallpaper_app/widgets/wallpaper_bg_widget.dart';

class SearchDetailPage extends StatefulWidget {
  String? query;
  String? color;
  SearchDetailPage({super.key, required this.query, this.color});

  @override
  State<SearchDetailPage> createState() => _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  List<PhotosModel> allWallpapers = [];

  ScrollController? scrollController;
  int totalWallPaperPageCount = 0;
  int totalNoPages = 1;
  int pageCount = 1;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        ///end of list
        print('End of List');
        totalNoPages = totalWallPaperPageCount ~/ 15 + 1;
        if (totalNoPages > pageCount) {
          pageCount++;
          BlocProvider.of<SearchCubit>(context).getSearchWallpaper(
              query: widget.query!, color: widget.color!, page: pageCount);
        } else {
          print('You\'ve reached the end of this category wallpapers!!');
        }
      }
    });
    BlocProvider.of<SearchCubit>(context)
        .getSearchWallpaper(query: widget.query!, color: widget.color!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: BlocListener<SearchCubit, SearchState>(
          listener: (_, state) {
            if (state is SearchLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      pageCount != 1 ? 'Next Page Loading..' : 'Loading')));
            } else if (state is SearchErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg)));
            } else if (state is SearchLoadedState) {
              totalWallPaperPageCount = state.totalWallpapers;
              allWallpapers.addAll(state.listPhotos);
              setState(() {});
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                controller: scrollController,
                children: [
                  const SizedBox(height: 11),
                  getText(
                      title: widget.query!,
                      style: mTextStyle35(
                          mFontWeight: FontWeight.bold,
                          mColor: AppColors.blackColor)),
                  getText(
                    title: '$totalWallPaperPageCount\twallpaper available',
                    style: mTextStyle16(
                        mColor: Colors.grey, mFontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 11),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: allWallpapers.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 9 / 14),
                        itemBuilder: (_, index) {
                          var eachPhotos = allWallpapers[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    index == allWallpapers.length - 1 ? 8 : 0),
                            child: WallPaperBgWidget(
                              urlImage: eachPhotos.src!.portrait!,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DownloadPage(
                                            imgModel: eachPhotos.src!,
                                            mIndex: index)));
                              },
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget getText({required String title, TextStyle? style}) {
    return Text(
      title,
      style: style,
    );
  }
}
