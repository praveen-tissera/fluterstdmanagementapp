class Batch {
  final String? batch_id;
  final String? batch_name;
  final String? batch_st_date;

  Batch(
      { required this.batch_id,
        required this.batch_name,
        required this.batch_st_date,});

  Batch.fromMap(Map<String, dynamic> res)
      : batch_id = res["batch_id"],
        batch_name = res["batch_name"],
        batch_st_date = res["batch_st_date"];

  Map<String, Object?> toMap() {
    return {'batch_id':batch_id,'batch_name': batch_name, 'batch_st_date': batch_st_date};
  }
}