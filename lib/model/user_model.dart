
final String tableUsers = 'users';

class UserModelFields {
  static final List<String> values = [
    /// Add all fields
    id, isMarried, phoneNumber, name, family, createdTime
  ];

  static final String id = '_id';
  static final String isMarried = 'isMarried';
  static final String phoneNumber = 'phoneNumber';
  static final String name = 'name';
  static final String family = 'family';
  static final String createdTime = 'createdTime';
}


class UserModel {

  final int? id;
  final bool isMarried;
  final int phoneNumber;
  final String name;
  final String family;
  final DateTime createdTime;

  UserModel(
      {this.id,
      required this.isMarried,
      required this.phoneNumber,
      required this.name,
      required this.family,
      required this.createdTime});


  UserModel copy({
    int? id,
    bool? isMarried,
    int? phoneNumber,
    String? name,
    String? family,
    DateTime? createdTime,
  }) =>
      UserModel(
        id: id ?? this.id,
        isMarried: isMarried ?? this.isMarried,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        name: name ?? this.name,
        family: family ?? this.family,
        createdTime: createdTime ?? this.createdTime,
      );

  static UserModel fromJson(Map<String, Object?> json) => UserModel(
    id: json[UserModelFields.id] as int?,
    isMarried: json[UserModelFields.isMarried] == 1,
    phoneNumber: json[UserModelFields.phoneNumber] as int,
    name: json[UserModelFields.name] as String,
    family: json[UserModelFields.family] as String,
    createdTime: DateTime.parse(json[UserModelFields.createdTime] as String),
  );

  Map<String, Object?> toJson() => {
    UserModelFields.id: id,
    UserModelFields.isMarried: isMarried ? 1 : 0,
    UserModelFields.phoneNumber: phoneNumber,
    UserModelFields.name: name,
    UserModelFields.family: family,
    UserModelFields.createdTime: createdTime.toIso8601String(),
  };

}
