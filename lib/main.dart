
import 'package:flutter/material.dart';
import 'package:shah_anchor_app/widgets/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, device){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Brain',
          home: SplashScreen(),
      );
    });
  }
}
