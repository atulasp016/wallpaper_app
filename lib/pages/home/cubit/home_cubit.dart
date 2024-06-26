import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  WallPaperRepository wallPaperRepository;
  HomeCubit({required this.wallPaperRepository}) : super(HomeInitialState());

  void getTrendingWallpapers() async {
    emit(HomeLoadingState());
    try {
      var data = await wallPaperRepository.getTrendingWallpapers();
      var wallpaperModel = WallpaperData.fromJson(data);
      emit(HomeLoadedState(listPhotos: wallpaperModel.photos!));
    } catch (e) {
      emit(HomeErrorState(errorMsg: e.toString()));
    }
  }
}
