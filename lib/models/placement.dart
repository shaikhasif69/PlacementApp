class Placement {
  final String id;
  final Company company;
  final String jobTitle;
  final String jobDescription;
  final double minimumCGPA;
  final List<Schedule> schedule;
  final DateTime createdAt;
  final DateTime updatedAt;

  Placement({
    required this.id,
    required this.company,
    required this.jobTitle,
    required this.jobDescription,
    required this.minimumCGPA,
    required this.schedule,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Placement.fromJson(Map<String, dynamic> json) {
    return Placement(
      id: json['_id'] ?? '',
      company: Company.fromJson(json['company']),
      jobTitle: json['jobTitle'] ?? '',
      jobDescription: json['jobDescription'] ?? '',
      minimumCGPA: (json['minimumCGPA'] ?? 0).toDouble(),
      schedule: List<Schedule>.from(
          json['schedule'].map((schedule) => Schedule.fromJson(schedule))),
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
    );
  }
}

class Company {
  final String id;
  final String email;
  final String companyName;
  final String password;
  final String passwordConf;
  final String companyId;
  final List<dynamic> jobsPosted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String location;

  Company({
    required this.id,
    required this.email,
    required this.companyName,
    required this.password,
    required this.passwordConf,
    required this.companyId,
    required this.jobsPosted,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      companyName: json['companyName'] ?? '',
      password: json['password'] ?? '',
      passwordConf: json['passwordConf'] ?? '',
      companyId: json['companyId'] ?? '',
      jobsPosted: json['jobsPosted'] ?? [],
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
      location: json['location'] ?? '',
    );
  }
}

class Schedule {
  final DateTime startTime;
  final DateTime endTime;

  Schedule({
    required this.startTime,
    required this.endTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      startTime: DateTime.parse(json['startTime'] ?? ''),
      endTime: DateTime.parse(json['endTime'] ?? ''),
    );
  }
}
