import 'package:wallpaper_app/data/remote/api_helpers.dart';
import 'package:wallpaper_app/data/remote/app_urls.dart';

class WallPaperRepository {
  ApiHelper apiHelper;
  WallPaperRepository({required this.apiHelper});

  ///search
  Future<dynamic> getSearchWallpapers(String mQuery,
      {String mColor = '', int mPage = 1}) async {
    try {
      return await apiHelper.getAPI(
          url: '${AppUrls.SEARCH_WALL_URL}?query=$mQuery&color=$mColor&page=$mPage');
    } catch (e) {
      rethrow;
    }

  }

  ///trending
  Future<dynamic> getTrendingWallpapers() async {
    try {
      return await apiHelper.getAPI(url: AppUrls.TRANDING_WALL_URL);
    } catch (e) {
      rethrow;
    }
  }
}
