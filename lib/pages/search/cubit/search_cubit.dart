import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  WallPaperRepository wallPaperRepository;
  SearchCubit({required this.wallPaperRepository})
      : super(SearchInitialState());

  void getSearchWallpaper(
      {required String query, String color = '', int page = 1}) async {
    emit(SearchLoadingState());

    try {
      var mData = await wallPaperRepository.getSearchWallpapers(query,
          mColor: color, mPage: page);
      WallpaperData wallpaperData = WallpaperData.fromJson(mData);
      emit(SearchLoadedState(
          listPhotos: wallpaperData.photos!,
          totalWallpapers: wallpaperData.total_results!));
    } catch (e) {
      emit(SearchErrorState(errorMsg: e.toString()));
    }
  }
}
