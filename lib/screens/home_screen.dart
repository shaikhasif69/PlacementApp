import 'package:shah_anchor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/placement.dart';
import '../services/api_calls.dart';
import '../widgets/quizz_topic.dart';
import '../widgets/splash_screen.dart';
import '../widgets/student_data.dart';
import 'calendar_page.dart';
import 'placement_page.dart';
import '../models/users.dart';
import 'resource_uploadscreen.dart';
import 'submit_resume.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Placement>> _placementData;
  late String _userName = '';
  late String _rollNum = '';
  late String _cgpa = '';
  late String _isSelected = '';

  @override
  void initState() {
    super.initState();
    _placementData = fetchPlacementData();
    print("i am here in in the init state and this is the data : " +
        _placementData.toString());
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
      _rollNum = prefs.getString("userRoll") ?? '';
      _cgpa = prefs.getString("cgpa") ?? "8.4";
      _isSelected = prefs.getString("isSelected") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          //we will divide the screen into two parts
          //fixed height for first half
          Container(
            width: 100.w,
            height: 40.h,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StudentName(
                          studentName: _userName,
                        ),
                        kHalfSizedBox,
                        StudentClass(
                            studentClass:
                                'Class X-II A | Roll no: ' + _rollNum),
                        kHalfSizedBox,
                        StudentYear(studentYear: '2020-2021'),
                      ],
                    ),
                    kHalfSizedBox,
                    StudentPicture(
                        picAddress: 'assets/images/student_profile.jpeg',
                        onPress: () {
                          // go to profile detail screen here
                          // Navigator.pushNamed(
                          //     context, MyProfileScreen.routeName);
                        }),
                  ],
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StudentDataCard(
                      onPress: () {
                        //go to attendance screen
                      },
                      title: 'Your CGPA this year',
                      value: _cgpa,
                    ),
                    StudentDataCard(
                      onPress: () {
                        //go to fee due screen
                        // Navigator.pushNamed(context, FeeScreen.routeName);
                      },
                      title: 'Selection Status',
                      value: _isSelected,
                    ),
                  ],
                )
              ],
            ),
          ),

          //other will use all the remaining height of screen
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              width: 100.w,
              decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                //for padding
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizzTopics(),
                                ));
                          },
                          icon: 'assets/icons/quiz.svg',
                          title: 'Take Quiz',
                        ),
                        HomeCard(
                          onPress: () {
                            //go to assignment screen here
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ResourceUploadScreen()));
                          },
                          icon: 'assets/icons/assignment.svg',
                          title: 'Resources',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                           Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder<List<Placement>>(
          future: _placementData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Or any loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return PlacementPage(placementItems: snapshot.data!);
            }
          },
        ),
      ),
    );
                          },
                          icon: 'assets/icons/event.svg',
                          title: 'Placements',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            CalendarPage(title: "Calendar",)));
                          },
                          icon: 'assets/icons/timetable.svg',
                          title: 'Calendar',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/ask.svg',
                          title: 'Ask',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadResume()));
                          },
                          icon: 'assets/icons/resume.svg',
                          title: 'Submit\nResume',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            // Navigator.pushNamed(
                            //     context, DateSheetScreen.routeName);
                          },
                          icon: 'assets/icons/datesheet.svg',
                          title: 'DateSheet',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                          },
                          icon: 'assets/icons/logout.svg',
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.onPress,
      required this.icon,
      required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: Colors.black,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
