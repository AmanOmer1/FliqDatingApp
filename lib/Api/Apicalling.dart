import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';

class OtpApiService {
  Future<void> fetchData() async {
    final url = Uri.parse(
      'https://test.myfliqapp.com/api/v1/auth/registration-otp-codes/actions/phone/send-otp',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonApiData = json.decode(response.body);

      final decoded = Japx.decode(jsonApiData);
    } else {
      print('Failed: ${response.statusCode}');
    }
  }
}
