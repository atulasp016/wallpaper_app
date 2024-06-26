part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitialState extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchLoadedState extends SearchState {
  List<PhotosModel> listPhotos;
  int totalWallpapers;
  SearchLoadedState({required this.listPhotos, required this.totalWallpapers});
}

final class SearchErrorState extends SearchState {
  String errorMsg;
  SearchErrorState({required this.errorMsg});
}
