import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shah_anchor_app/services/api_calls.dart';

import '../models/topics.dart';
import '../screens/quiz_question.dart';

class QuizzTopics extends StatelessWidget {
  const QuizzTopics({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>?>(
      future: fetchTopics(),
      builder: (BuildContext context, AsyncSnapshot<List<Topic>?> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              // Your blurred background
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
              ),
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              ),
            ],
          );
        } else if (snap.hasError) {
          print("Error: ${snap.error}");
          return Center(
            child: Text(
              'Error fetching data ${snap.error}', // Handle error if data fetching fails
            ),
          );
        } else if (snap.hasData) {
          print("Data fetched successfully!");
          print(snap.data);
          List<Topic> topics = snap.data ?? [];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text('Topics'),
              actions: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.userCircle, color: Colors.pink[200]),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                )
              ],
            ),
            drawer: TopicDrawer(topics: topics),
            body: GridView.count(
              crossAxisCount: 2,
              primary: false,
              padding: EdgeInsets.all(20),
              crossAxisSpacing: 10.0,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
          );
        } else {
          return Container(); // Default return statement
        }
      },
    );
  }
}
class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: topic.img,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => TopicScreen(topic: topic),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/apptitude2.png',
                  height: 120,
                  width: 80,
                  fit: BoxFit.contain,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      topic.title,
                      style: TextStyle(
                          height: 1.5, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                ),
                // )
                // TopicProgress(topic: topic),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;

  TopicScreen({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            Hero(
              tag: topic.img,
              child: Image.asset('assets/images/apptitude.png',
                  width: MediaQuery.of(context).size.width),
            ),
            Text(
              topic.title,
              style:
                  TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            QuizList(topic: topic)
          ]),
        ),
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  QuizList({required this.topic});

  @override
  Widget build(BuildContext context) {
    print("this is topic: " + topic.id.toString());
    return Column(
        children: topic.quizzes.map((quiz) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 4,
        margin: EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => QuizzQuestions(
                  data: topic,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                quiz.title,
                // style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                quiz.description,
                overflow: TextOverflow.fade,
                // style: Theme.of(context).textTheme.subhead,
              ),
              // leading: QuizBadge(topic: topic, quizId: quiz.id),
            ),
          ),
        ),
      );
    }).toList());
  }
}

class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;
  TopicDrawer({required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: topics.length,
          itemBuilder: (BuildContext context, int idx) {
            Topic topic = topics[idx];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    topic.title,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
                QuizList(topic: topic)
              ],
            );
          },
          separatorBuilder: (BuildContext context, int idx) => Divider()),
    );
  }
}
