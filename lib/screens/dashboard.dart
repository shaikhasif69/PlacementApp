import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  List category = [
    "Category",
    "Free Course",
    "Classes",
    "Book Store",
    "LiveCourse",
    "LeaderBoard"
  ];
  List<Color> catColors = [
    Color(0xFFF9E897),
    Color(0xFFAD88C6),
    Color(0xFFFF3EA5),
    Color(0xFFA5DD9B),
    Color(0xFFFFA447),
    Color(0xFF864AF9),
  ];
  List<Icon> catIcon = [
    Icon(Icons.category),
    Icon(Icons.assessment),
    Icon(Icons.live_tv_rounded),
    Icon(Icons.book),
    Icon(Icons.video_library),
    Icon(Icons.leaderboard)
  ];

  List imageList = ["Flutter", "React Native", "Python", "C++"];
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
       value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 10),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.dashboard,
                        size: 30,
                      ),
                      Icon(
                        Icons.notifications_active,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 15),
                    child: Text(
                      "Hi! Student(name)",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    // margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "search here...",
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 18),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 25,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: category.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 1.1),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                print("hello world!");
                                print(index);
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: catColors[index],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: catIcon[index],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              category[index],
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.6)),
                            )
                          ],
                        );
                      }),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Course",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(fontSize: 12),
                        )
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: imageList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              (MediaQuery.of(context).size.height - 50 - 20) /
                                  (4 * 240),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => CourseScreen(
                            //               imageList[index],
                            //             )));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[300]),
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/images/${imageList[index]}.png",
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  imageList[index],
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(.6)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "55 Videos",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(.6)),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: 30,
            selectedFontSize: 18,
            unselectedFontSize: 14,
            selectedItemColor: Colors.purple[400],
            unselectedItemColor: Colors.grey[400],
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment), label: "Courses"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Wishlist"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Account"),
            ]),
      ),
    );
  }
}
