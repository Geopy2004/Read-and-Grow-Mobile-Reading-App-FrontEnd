import 'package:shared_preferences/shared_preferences.dart';

class Student {
  final int id; // student_id
  final int? userId; // user_id from users table
  final String studentName;
  final String? studentLrn;
  final String? studentGrade;
  final String? studentSection;
  final String? username;
  final String avatarLetter;
  final String? profilePicture;
  final int? classRoomId;

  Student({
    required this.id,
    this.userId,
    required this.studentName,
    this.studentLrn,
    this.studentGrade,
    this.studentSection,
    this.username,
    String? avatarLetter,
    this.profilePicture,
    this.classRoomId,
  }) : avatarLetter =
            avatarLetter ??
            (studentName.isNotEmpty ? studentName[0].toUpperCase() : 'S');

  /// ✅ NEW: copyWith method
  Student copyWith({
    int? id,
    int? userId,
    String? studentName,
    String? studentLrn,
    String? studentGrade,
    String? studentSection,
    String? username,
    String? avatarLetter,
    String? profilePicture,
    int? classRoomId,
  }) {
    return Student(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      studentName: studentName ?? this.studentName,
      studentLrn: studentLrn ?? this.studentLrn,
      studentGrade: studentGrade ?? this.studentGrade,
      studentSection: studentSection ?? this.studentSection,
      username: username ?? this.username,
      avatarLetter: avatarLetter ?? this.avatarLetter,
      profilePicture: profilePicture ?? this.profilePicture,
      classRoomId: classRoomId ?? this.classRoomId,
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    final name = json['student_name'] ?? '';
    return Student(
      id: json['student_id'] != null
          ? (json['student_id'] is int
              ? json['student_id']
              : int.tryParse(json['student_id'].toString()) ?? 0)
          : (json['id'] is int
              ? json['id']
              : int.tryParse(json['id'].toString()) ?? 0),
      userId: json['user_id'] is int
          ? json['user_id']
          : int.tryParse(json['user_id']?.toString() ?? ''),
      studentName: name,
      studentLrn: json['student_lrn'],
      studentGrade: json['student_grade']?.toString(),
      studentSection: json['student_section']?.toString(),
      username: json['username'],
      avatarLetter: name.isNotEmpty ? name[0].toUpperCase() : 'S',
      profilePicture: json['profile_picture'],
      classRoomId: json['class_room_id'] is int
          ? json['class_room_id']
          : int.tryParse(json['class_room_id']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'student_name': studentName,
        'student_lrn': studentLrn,
        'student_grade': studentGrade,
        'student_section': studentSection,
        'username': username,
        'avatarLetter': avatarLetter,
        'class_room_id': classRoomId,
        'profile_picture': profilePicture,
      };

  static Future<Student> fromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('student_name') ?? '';
    return Student(
      id: int.tryParse(prefs.getString('student_id') ?? '') ?? 0,
      userId: int.tryParse(prefs.getString('user_id') ?? ''),
      studentName: name,
      studentLrn: prefs.getString('student_lrn'),
      studentGrade: prefs.getString('student_grade'),
      studentSection: prefs.getString('student_section'),
      username: prefs.getString('username'),
      avatarLetter: name.isNotEmpty ? name[0].toUpperCase() : 'S',
      profilePicture: prefs.getString('profile_picture'),
      classRoomId:
          int.tryParse(prefs.getString('class_room_id') ?? '') ?? null,
    );
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (id != 0) await prefs.setString('student_id', id.toString());
    if (userId != null) await prefs.setString('user_id', userId.toString());
    if (studentName.isNotEmpty) {
      await prefs.setString('student_name', studentName);
    }
    if (studentLrn != null) {
      await prefs.setString('student_lrn', studentLrn!);
    }
    if (studentGrade != null) {
      await prefs.setString('student_grade', studentGrade!);
    }
    if (studentSection != null) {
      await prefs.setString('student_section', studentSection!);
    }
    if (username != null) {
      await prefs.setString('username', username!);
    }
    if (profilePicture != null) {
      await prefs.setString('profile_picture', profilePicture!);
    }
    if (classRoomId != null) {
      await prefs.setString('class_room_id', classRoomId.toString());
    }
  }
}
