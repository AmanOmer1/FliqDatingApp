import 'package:fliq_dating_app/Screens/PhoneNumberScreen.dart';
import 'package:fliq_dating_app/Screens/SplashScreenButton.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/assetsplash.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(color: Colors.black54),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    'Connect. Meet. Love.\nWith Fliq Dating',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SignInButton(
                  onPressed: () {},
                  text: 'Sign in with Google',
                  color: const Color.fromARGB(255, 77, 73, 73),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  icon: Icons.g_mobiledata,
                ),
                SignInButton(
                  onPressed: () {},
                  text: 'Sign in with Facebook',
                  color: Colors.blue,
                  textColor: Colors.white,
                  icon: Icons.facebook,
                ),
                SignInButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PhoneNumberScreen(),
                      ),
                    );
                  },
                  text: 'Sign in with phone number',
                  color: Colors.pink,
                  textColor: Colors.white,
                  icon: Icons.phone,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
