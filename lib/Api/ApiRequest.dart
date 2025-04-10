import 'dart:convert' as convert;
import 'dart:convert';

import 'package:fliq_dating_app/Api/ApiResponce.dart';
import 'package:fliq_dating_app/constants/ApiConstants.dart';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRequest {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<ApiResponce> apiRequest(url, params) async {
    final SharedPreferences prefs = await _prefs;
    print('test responceeeeeeeeeeeeee1');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print('test responceeeeeeeeeeeeee2');
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print('test responceeeeeeeeeeeeee3');
    Map newParams = Map();
    newParams.addAll(params);

    var _fcmToken = prefs.getString("fcmToken") ?? "";
    newParams["fcmToken"] = _fcmToken;

    newParams["version"] = version;
    newParams["buildNumber"] = buildNumber;
    newParams["appType"] = 1;

    print(HOSTNAME + url);
    print(newParams);
    var body = json.encode(newParams);
    print('test responceeeeeeeeeeeeee4');
    // final SharedPreferences prefs = await _prefs;
    var _userToken =
        prefs.getString("user_token") ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2IjoiMjAyNS0wMi0yNlQwOToyMDowOS40MjVaIiwidyI6IjY3YmVkY2M5MmNkMWQ2Zjk1Y2M3YzA3NSIsIngiOjEwLCJ1IjowLCJhIjp0cnVlLCJtIjoiKzk3MTUwNTM2MDQwNSIsIm4iOiJSaXNoYWQgS2Fra2lyaSIsImlhdCI6MTc0MDc0NDEzNn0.efH4fVe0jmp8t6gScJ33RUoj7xPajO-yHC1ENjlOsQc";
    print('test responceeeeeeeeeeeeee5');
    var header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + _userToken,
    };
    print('test responceeeeeeeeeeeeee6');
    print(header);
    return await http
        .post(Uri.parse(HOSTNAME + url), body: body, headers: header)
        .then((response) {
          print('test responceeeeeeeeeeeeee7');
          print(response);
          print('test responceeeeeeeeeeeeee8');
          if (response.statusCode == 200) {
            print('test responceeeeeeeeeeeeee9');
            var jsonResponse = convert.jsonDecode(response.body);
            print('test responceeeeeeeeeeeeee10');
            return ApiResponce(data: jsonResponse, errorMessage: '');
          } else if (response.statusCode == 208) {
            print('test responceeeeeeeeeeeeee11');
            var jsonResponse = convert.jsonDecode(response.body);
            return ApiResponce(
              error: true,
              errorMessage:
                  publicSelectedLanguage == "en"
                      ? jsonResponse['message']
                      : jsonResponse['message_ar'],
              statusCode: response.statusCode,
              data: null,
            );
          } else {
            var jsonResponse = convert.jsonDecode(response.body);
            return ApiResponce(
              error: true,
              errorMessage: jsonResponse['message'],
              statusCode: response.statusCode,
              data: null,
            );
          }
        })
        .catchError((err) {
          print(err);
          return ApiResponce(
            error: true,
            statusCode: 500,
            data: null,
            errorMessage: '',
          );
        });
  }
}
