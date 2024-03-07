class Topic {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.img,
    required this.quizzes,
  });
  factory Topic.fromMap(Map<String, dynamic> data) {
    print("i see .. i am creating the problem kya?");
    return Topic(
      id: data['_id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      img: data['img'] ?? 'default.png',
      // quizzes: (data['quizzes'] as List<dynamic>? ?? []).map((v) {
      //   // Ensure that each element in the quizzes list is a Map
      //   if (v is Map<String, dynamic>) {
      //     return Quiz.fromMap(v);
      //   } else {
      //     // If the element is not a Map, return a default Quiz or handle it as needed
      //     return Quiz(
      //       id: '',
      //       title: '',
      //       description: '',
      //       video: '',
      //       topic: '',
      //       questions: [],
      //     );
      //   }
      // }).toList(),
      // quizzes: _parseQuizzes(data['quizzes']),
        quizzes: (data['quizzes'] as List<dynamic> ?? []).map((v) => Quiz.fromMap(v)).toList(),
    );
  }
  static List<Quiz> _parseQuizzes(dynamic quizzesData) {
    if (quizzesData is List) {
      // If quizzesData is a list, parse each item as a Quiz object
      return quizzesData.map((v) => Quiz.fromMap(v)).toList();
    } else if (quizzesData is Map<String, dynamic>) {
      // If quizzesData is a single object, create a list with one Quiz object
      return [Quiz.fromMap(quizzesData)];
    } else {
      // If quizzesData is neither a list nor a map, return an empty list or handle it as needed
      return [];
    }
  }
}

class Quiz {
  final String id;
  final String title;
  final String description;
  final String video;
  final String topic;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.video,
    required this.topic,
    required this.questions,
  });

  factory Quiz.fromMap(Map<String, dynamic> data) {
    print("m i creating the problem ? ");
    return Quiz(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      video: data['video'] ?? '',
      topic: data['topic'] ?? '',
      // questions: (data['questions'] as List<dynamic> ?? [])
      //     .map((v) => Question.fromMap(v))
      //     .toList(),
      questions: _parseQuestions(data['questions']),
    );
  }
  static List<Question> _parseQuestions(dynamic questionsData) {
    if (questionsData is List) {
      // If questionsData is a list, parse each item as a Question object
      return questionsData.map((v) => Question.fromMap(v)).toList();
    } else if (questionsData is Map<String, dynamic>) {
      // If questionsData is a single object, create a list with one Question object
      return [Question.fromMap(questionsData)];
    } else {
      // If questionsData is neither a list nor a map, return an empty list or handle it as needed
      return [];
    }
  }
}

class Question {
  final String id;
  final String text;
  final List<Option> options;

  Question({
    required this.id,
    required this.text,
    required this.options,
  });

  factory Question.fromMap(Map<String, dynamic> data) {
    print("or do YOU??");
    return Question(
      id: data['id'] ?? '',
      text: data['text'] ?? '',
      options: (data['options'] as List<dynamic> ?? [])
          .map((v) => Option.fromMap(v))
          .toList(),
    );
  }
}

class Option {
  final String value;
  final String detail;
  final bool correct;

  Option({
    required this.value,
    required this.detail,
    required this.correct,
  });

  factory Option.fromMap(Map<String, dynamic> data) {
    return Option(
      value: data['value'] ?? '',
      detail: data['detail'] ?? '',
      correct: data['correct'] ?? false,
    );
  }
}
