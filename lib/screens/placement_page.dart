import 'package:flutter/material.dart';
import 'package:shah_anchor_app/models/placement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'placement_card_widget.dart';

class PlacementPage extends StatefulWidget {
  final List<Placement> placementItems;
  PlacementPage({super.key, required this.placementItems});

  @override
  State<PlacementPage> createState() => _PlacementPageState();
}

class _PlacementPageState extends State<PlacementPage> {
  late String _username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('userName') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                // Text("hello there! User name here "),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello there!   ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]),
                    ),
                    Text(
                      _username,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 22.0),
                //       child: Text("Placements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 15),
                  child: subTitle("Placement"),
                ),
                getHorizontalItemSlider(widget.placementItems),
                 Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 15),
                  child: subTitle("Near-by Placements"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.placementItems.length,
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
                                color: Colors.grey[200]),
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/covers/topic1.png",
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.placementItems.first.jobTitle,
                                  style: TextStyle(
                                      fontSize: 18,
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
                      }),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

Widget getHorizontalItemSlider(List<Placement> placementItem) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    height: 250,
    child: ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: placementItem.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onItemClicked(context, placementItem[index]);
          },
          child: PlacementCardWidget(
            item: placementItem[index],
            heroSuffix: "home_screen",
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 20,
        );
      },
    ),
  );
}

void onItemClicked(BuildContext context, Placement placementItem) {
  print("hurray!");
  // Navigator.push(
  //   context,
  // MaterialPageRoute(
  //     builder: (context) => PlacementPage(
  //         // groceryItem,
  //         // heroSuffix: "home_screen",
  //         )),
  // );
}

Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          "See All",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor),
        ),
      ],
    );
  }