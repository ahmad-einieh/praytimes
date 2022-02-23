class Data {
  final data;
  final nameOfMethod;

  const Data({required this.data, required this.nameOfMethod});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
      nameOfMethod: json['data']['meta']['method']['name'],
    );
  }
}
