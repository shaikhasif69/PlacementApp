import 'package:shah_anchor_app/components/custom_buttons.dart';
import 'package:shah_anchor_app/constants.dart';
// import 'package:brain_school/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shah_anchor_app/screens/dashboard.dart';
import 'package:sizer/sizer.dart';

import 'home_screen.dart';

late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  static String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  //changes current state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //when user taps anywhere on the screen, keyboard hides
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor:kPrimaryColor,
        body: Column(
          children: [
            Container(
              width: 100.w,
              height: 35.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 50,),
                    Image.asset(
                    'assets/images/collegePlacement.png',
                    height: 20.h,
                    width: 60.w,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Hi", style: TextStyle(fontSize: 24),), Text(" Students!", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26, color: Colors.white),)],),
                  Text("Sign in to continue", style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(children: [Text("Hi", style: TextStyle(fontSize: 20),)],),
                  //     // Text('Hi Student',
                  //     //     style: Theme.of(context).textTheme.titleMedium),
                  //     // Text('Sign in to continue',
                  //     //     style: Theme.of(context).textTheme.subtitle2),
                  //     sizedBox,
                  //   ],
                  // ),
                
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        sizedBox,
                        SizedBox(height: 30,),
                        buildEmailField(),
                        sizedBox,
                        buildPasswordField(),
                        sizedBox,
                        DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            }
                          },
                          title: 'SIGN IN',
                          iconData: Icons.arrow_forward_outlined,
                        ),
                        sizedBox,
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Forgot Password',
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Mobile Number/Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_off_outlined,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return 'Must be more than 5 characters';
        }
      },
    );
  }
}
