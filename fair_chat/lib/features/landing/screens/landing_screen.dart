import 'package:flutter/material.dart';
import 'package:fair_chat/common/utils/colors.dart';
import 'package:fair_chat/common/widgets/custom_button.dart';
import 'package:fair_chat/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Welcome to FairChat',
              style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepOrangeAccent),
            ),
            Expanded(
              child: Image.asset(
                'assets/BACKGROUNDFC.png',
                width: size.width * 1.2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Already Have an Account or New User Tap on "Continue Login" Button ',
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'CONTINUE LOGIN',
                onPressed: () => navigateToLoginScreen(context),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
