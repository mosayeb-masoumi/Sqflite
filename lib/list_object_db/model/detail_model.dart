
class DetailModel {
  String? name;
  String? family;
  String? city;

  DetailModel({required this.name,required this.family,required this.city});

  static DetailModel fromJson(Map<String, dynamic> json) {
    return DetailModel(
        name: json['name'],
        family: json['family'],
        city : json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['family'] = this.family;
    data['city'] = this.city;
    return data;
  }

}
