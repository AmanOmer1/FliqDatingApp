import 'dart:convert';
import 'package:fliq_dating_app/Screens/ChatScreeen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifictinScren extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final String phone;

  OtpVerifictinScren({required this.phone});

  Future<void> verifyOtp(BuildContext context) async {
    final otp = otpController.text;

    final requestBody = {
      'data': {
        'type': 'registration_otp_codes',
        'attributes': {
          'phone': phone,
          'otp': int.tryParse(otp) ?? 0,
          'device_meta': {
            'type': 'mobile',
            'name': 'Flutter App',
            'os': 'Android/iOS',
            'browser': 'Flutter',
            'browser_version': '3.0',
            'user_agent': 'flutter_app',
            'screen_resolution': '1080x1920',
            'language': 'en-IN',
          },
        },
      },
    };

    try {
      final response = await http.post(
        Uri.parse(
          'https://test.myfliqapp.com/api/v1/auth/registration-otp-codes/actions/phone/verify-otp',
        ),
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = json.decode(response.body);
        print("${decoded['message']}");
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => Chatscreeen()));
      } else {
        print("error occurred======1");
      }
    } catch (e) {
      print("error occurred=======2");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Enter your verification\ncode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 40),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: otpController,
                keyboardType: TextInputType.number,
                onChanged: (_) {},
                textStyle: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  verifyOtp(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
