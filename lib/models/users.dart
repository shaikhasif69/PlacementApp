class UserData {
  final String id;
  final String email;
  final String username;
  final String password;
  final String passwordConf;
  final String rollNumber;
  final double cgpa;
  final List<AppliedPlacement> appliedPlacements;

  UserData({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.passwordConf,
    required this.rollNumber,
    required this.cgpa,
    required this.appliedPlacements,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      passwordConf: json['passwordConf'],
      rollNumber: json['rollNumber'],
      cgpa: json['cgpa'],
      appliedPlacements: (json['appliedPlacements'] as List<dynamic>)
          .map((placementJson) =>
              AppliedPlacement.fromJson(placementJson))
          .toList(),
    );
  }
}

class AppliedPlacement {
  final String status;
  final String id;
  final String placementId;

  AppliedPlacement({
    required this.status,
    required this.id,
    required this.placementId,
  });

  factory AppliedPlacement.fromJson(Map<String, dynamic> json) {
    return AppliedPlacement(
      status: json['status'],
      id: json['_id'],
      placementId: json['placement'],
    );
  }
}
