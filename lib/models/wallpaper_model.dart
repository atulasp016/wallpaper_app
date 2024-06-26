class WallpaperData {
  int? total_results;
  int? page;
  int? per_page;
  List<PhotosModel>? photos;
  String? next_page;

  WallpaperData({
    required this.total_results,
    required this.page,
    required this.per_page,
    required this.photos,
    required this.next_page,
  });

  factory WallpaperData.fromJson(Map<String, dynamic> json) {
    List<PhotosModel> mPhotos = [];

    for (Map<String, dynamic> eachPhotos in json['photos']) {
      mPhotos.add(PhotosModel.fromJson(eachPhotos));
    }
    return WallpaperData(
      total_results: json['total_results'],
      page: json['page'],
      per_page: json['per_page'],
      photos: mPhotos,
      next_page: json['next_page'],
    );
  }
}

class PhotosModel {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  String? avg_color;
  SrcModel? src;
  bool? liked;
  String? alt;

  PhotosModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographer_url,
    required this.photographer_id,
    required this.avg_color,
    required this.src,
    required this.liked,
    required this.alt,
  });

  factory PhotosModel.fromJson(Map<String, dynamic> json) {
    return PhotosModel(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographer_url: json['photographer_url'],
      photographer_id: json['photographer_id'],
      avg_color: json['avg_color'],
      src: SrcModel.fromJson(json['src']),
      liked: json['liked'],
      alt: json['alt'],
    );
  }
}

class SrcModel {
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  SrcModel({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  factory SrcModel.fromJson(Map<String, dynamic> json) {
    return SrcModel(
      original: json['original'],
      large2x: json['large2x'],
      large: json['large'],
      medium: json['medium'],
      small: json['small'],
      portrait: json['portrait'],
      landscape: json['landscape'],
      tiny: json['tiny'],
    );
  }
}
