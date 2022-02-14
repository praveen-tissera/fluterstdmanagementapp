class Course {
  final int course_id;
  final String? course_name;

  Course(
      { required this.course_id,
        required this.course_name,});

  Course.fromMap(Map<String, dynamic> res)
      : course_id = res["course_id"],
        course_name = res["course_name"];

  Map<String, Object?> toMap() {
    return {'course_id':course_id,'course_name': course_name};
  }
}