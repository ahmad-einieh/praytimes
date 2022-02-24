class CityData {
  final /*List<String>*/ data;

  const CityData({required this.data});

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      data: json['data'],
    );
  }
}
