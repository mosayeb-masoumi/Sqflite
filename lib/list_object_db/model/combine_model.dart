
final String tableCombine = 'combine';

class CombineModelFields {
  static final List<String> values = [
    /// Add all fields
    id, title, createdTime, detailModel, detailList,
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String createdTime = 'createdTime';
  static final String detailModel = 'detailModel';
  static final String detailList = 'detailList';

}



class CombineModel{
  final int? id;
  final String title;
  final DateTime createdTime;
  final String detailModel;
  final String detailList;

  CombineModel(
      {this.id,
        required this.title,
        required this.createdTime,
        required this.detailModel,
        required this.detailList,});


  CombineModel copy({
    int? id,
    String? title,
    DateTime? createdTime,
    String? detailModel,
    String? detailList,
  }) =>
      CombineModel(
        id: id ?? this.id,
        title: title ?? this.title,
        createdTime: createdTime ?? this.createdTime,
        detailModel: detailModel ?? this.detailModel,
        detailList: detailList ?? this.detailList,
      );



  static CombineModel fromJson(Map<String, Object?> json) => CombineModel(
    id: json[CombineModelFields.id] as int?,
    title: json[CombineModelFields.title] as String,
    createdTime: DateTime.parse(json[CombineModelFields.createdTime] as String),
    detailModel: json[CombineModelFields.detailModel] as String,
    detailList: json[CombineModelFields.detailList] as String,
  );

  // static CombineModel fromJson(Map<String, Object?> json){
  //  return CombineModel(
  //     id: json[CombineModelFields.id] as int?,
  //     title: json[CombineModelFields.title] as String,
  //     createdTime: DateTime.parse(json[CombineModelFields.createdTime] as String),
  //    detailModel: json[CombineModelFields.detailModel] as String,
  //    detailList: json[CombineModelFields.detailList] as String,
  //
  //   );
  // }

  Map<String, Object?> toJson() => {
    CombineModelFields.id: id,
    CombineModelFields.title: title ,
    CombineModelFields.createdTime: createdTime.toIso8601String(),
    CombineModelFields.detailModel: detailModel,
    CombineModelFields.detailList: detailList,
  };

}