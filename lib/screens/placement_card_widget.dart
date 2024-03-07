import 'package:flutter/material.dart';

import 'package:shah_anchor_app/models/placement.dart';

import '../constants.dart';
import '../utils/app_text.dart';

class PlacementCardWidget extends StatefulWidget {
  PlacementCardWidget({Key? key, required this.item, this.heroSuffix})
      : super(key: key);
  final Placement item;
  final String? heroSuffix;

  @override
  State<PlacementCardWidget> createState() => _PlacementCardWidgetState();
}

class _PlacementCardWidgetState extends State<PlacementCardWidget> {
  final double width = 174;

  final double height = 250;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  @override
  Widget build(BuildContext context) {
    print(widget.item);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: "GroceryItem:" +
                      widget.item.company.companyName +
                      "-" +
                      (widget.heroSuffix ?? ""),
                  child: imageWidget(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              text: widget.item.jobTitle,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: widget.item.jobDescription,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7C7C7C),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                AppText(
                  text: widget.item.company.location,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                addWidget()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.asset("assets/images/company.png"),
    );
  }

  Widget addWidget() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: kPrimaryColor),
      child: Center(
        child: Icon(
          Icons.library_add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
