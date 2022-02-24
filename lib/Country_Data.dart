class CountryData{
  final /*List<String>*/ data;

  const CountryData({required this.data});


  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      data: json['data'],
    );
  }
}