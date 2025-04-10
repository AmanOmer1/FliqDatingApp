import 'package:flutter/cupertino.dart';

class Publicprovider extends ChangeNotifier {
  var user_token = "";

  var SendOtp = [];
  SendOtpData(passData) {
    SendOtp = passData[""];
    notifyListeners();
  }

  var VerifyOtp = [];
  VerifyOtpData(passData) {
    VerifyOtp = passData[""];
    notifyListeners();
  }

  void setToken(passtoken) {
    user_token = passtoken[""];
    notifyListeners();
  }
}
