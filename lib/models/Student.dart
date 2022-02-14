class Student {
  final String? student_id;
  final String? student_pwd;
  final String? student_name;
  final String? student_gender;
  final String? student_mobile;
  final String? student_email;

  Student(
      { required this.student_id,
        required this.student_pwd,
        required this.student_name,
        required this.student_gender,
        required this.student_mobile,
        required this.student_email,
      });

  Student.fromMap(Map<String, dynamic> res)
      : student_id = res["student_id"],
        student_pwd = res["student_pwd"],
        student_name = res["student_name"],
        student_gender = res["student_gender"],
        student_mobile = res["student_mobile"],
        student_email = res["student_email"];

  Map<String, Object?> toMap() {
    return {'student_id':student_id,'student_name': student_name, 'student_gender': student_gender, 'student_mobile': student_mobile, 'student_email': student_email, 'student_pwd': student_pwd};
  }
}