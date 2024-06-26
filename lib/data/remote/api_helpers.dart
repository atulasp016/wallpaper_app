import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as httpClient;
import 'package:wallpaper_app/constants/app_constants.dart';
import 'package:wallpaper_app/data/exceptions/app_exceptions.dart';

class ApiHelper {
  Future<dynamic> getAPI({required String url}) async {
    var uri = Uri.parse(
      url,
    );

    try {
      var response = await httpClient
          .get(uri, headers: {'Authorization': AppConstant.PEXELS_API_KEY});
      return returnJsonResponse(response);
    } on SocketException catch (e) {
      throw (FetchDataException(errorMsg: 'No Internet!!'));
    }
  }

  dynamic returnJsonResponse(httpClient.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var mData = jsonDecode(response.body);
          return mData;
        }
      case 400:
        throw BadRequestException(errorMsg: response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(errorMsg: response.body.toString());

      case 500:
      case 502:
      default:
        throw FetchDataException(
            errorMsg:
                'Error occurred while Communication with Server with StatusCode : ${response.body}');
    }
  }
}
