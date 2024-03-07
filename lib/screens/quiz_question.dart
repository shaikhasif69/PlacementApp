import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shah_anchor_app/models/topics.dart';

import '../constants.dart';

class QuizzQuestions extends StatefulWidget {
  Topic data;
  QuizzQuestions({super.key, required this.data});

  @override
  State<QuizzQuestions> createState() => _QuizzQuestionsState();
}

class _QuizzQuestionsState extends State<QuizzQuestions> {
  int correct = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.4)),
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(fontWeight: FontWeight.w800),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.5)),
                child: Text(
                  "Question: " + widget.data.quizzes[0].questions[index].text,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount:
                      widget.data.quizzes[0].questions[index].options.length,
                  itemBuilder: (context, key) {
                    print(
                        widget.data.quizzes[0].questions[index].options.length);
                    print("the size: ");
                    return InkWell(
                      onTap: () {
                        print(widget.data.quizzes[0].questions.length);
                        print("aboveee");
                        if (widget.data.quizzes[0].questions[index].options[key]
                            .correct) {
                          correct++;
                          print("how many correct: " + correct.toString());
                        }
                        if (widget.data.quizzes[0].questions.length - 1 >
                            index) {
                          setState(() {
                            print("this is index: " + index.toString());
                            index++;
                          });
                        } else {
                          showDialog(
                            context: (context),
                            builder: (context) => AlertDialog(
                              content: Text(
                                "You're score is: " + correct.toString(),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Done"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(widget.data.quizzes[0].questions[index]
                                      .options[key].value +
                                  " : "),
                              Text(widget.data.quizzes[0].questions[index]
                                  .options[key].detail),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
