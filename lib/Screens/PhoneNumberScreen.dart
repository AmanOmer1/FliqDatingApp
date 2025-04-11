import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';

import 'package:fliq_dating_app/Screens/OtpVerficatnsScreen.dart';
import 'package:fliq_dating_app/Utilities/TostMessege.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TostService tostService = TostService();

  Future<void> sendOtp() async {
    final String phone = _phoneController.text;

    if (phone.isEmpty) {
      print("phone number empty");
      return;
    }

    final Map<String, dynamic> rawData = {
      'type': 'registration_otp_codes',
      'attributes': {'phone': phone},
    };
    print('test============1');
    final jsonData = json.encode({'data': rawData});
    print(jsonData);
    print('test============2');
    try {
      final response = await http.post(
        Uri.parse(
          'https://test.myfliqapp.com/api/v1/auth/registration-otp-codes/actions/phone/send-otp',
        ),
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
        },
        body: jsonData,
      );
      print('test============3');
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = json.decode(response.body);

        final message = decoded['message'] ?? 'OTP sent successfully';
        tostService.showSucessMessage(message);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpVerifictinScren(phone: phone),
          ),
        );
      } else {
        print("Erroroccurred===========");
      }
    } catch (e) {
      print("Erroroccurred======================");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'Enter your phone\nnumber',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(Icons.phone_iphone_outlined, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Spacer(),
              GestureDetector(
                onTap: sendOtp,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.3),
                        //alpha? itt cheyyenam
                        offset: Offset(0, 4),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
