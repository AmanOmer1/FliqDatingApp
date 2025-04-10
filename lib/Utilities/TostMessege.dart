import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TostService {
  showSucessMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.yellow,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
// otp success message 