// import 'package:brain_school/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shah_anchor_app/screens/login_screen.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      print("hello world!");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Placement',
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                Text('Buddy',
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.w600)),
              ],
            ),
            Image.asset(
              'assets/images/collegeStudent.png',
              //25% of height & 50% of width
              height: 55.h,
              width: 60.w,
            ),
          ],
        ),
      ),
    );
  }
}
