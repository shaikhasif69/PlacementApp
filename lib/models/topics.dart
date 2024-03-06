class Option {
  late String value;
  late String detail;
  late bool correct;

  Option({required this.correct, required this.value, required this.detail});
  Option.fromMap(Map data) {
    value = data['value'];
    detail = data['detail'] ?? '';
    correct = data['correct'];
  }
}

class Question {
  late String text;
  late List<Option> options;
  Question({required this.options, required this.text});

  Question.fromMap(Map data) {
    text = data['text'] ?? '';
    options =
        (data['options'] as List ?? []).map((v) => Option.fromMap(v)).toList();
  }
}

class Quiz {
  String id;
  String title;
  String description;
  String video;
  String topic;
  List<Question> questions;

  Quiz(
      {required this.title,
      required this.questions,
      required this.video,
      required this.description,
      required this.id,
      required this.topic});

  factory Quiz.fromMap(Map data) {
    print("i am from the quizz map: " + data.toString());
    return Quiz(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        topic: data['topic'] ?? '',
        description: data['description'] ?? '',
        video: data['video'] ?? '',
        questions: (data['questions'] as List ?? [])
            .map((v) => Question.fromMap(v))
            .toList());
  }
}

class Topic {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  Topic(
      {required this.id,
      required this.title,
      required this.description,
      required this.img,
      required this.quizzes});

  factory Topic.fromMap(Map<String, dynamic> data) {
    print("this is the data: " + data.toString());
    return Topic(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      img: data['img'] ?? 'default.png',
      quizzes:
          (data['quizzes'] as List ?? []).map((v) => Quiz.fromMap(v)).toList(),
    );
  }
}

class Report {
  String uid;
  int total;
  dynamic topics;

  Report({required this.uid, this.topics,required this.total });

  factory Report.fromMap(Map data) {
    return Report(
      uid: data['uid'],
      total: data['total'] ?? 0,
      topics: data['topics'] ?? {},
    );
  }

}
