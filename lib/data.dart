import 'package:hive/hive.dart';
part 'data.g.dart';

@HiveType(typeId: 0)

///=======================> klid zakhire class ma dar dataBase

class TaskEntity extends HiveObject {
  @HiveField(0)

  ///================================> jaygah  dar databse Hive
  String name = '';
  @HiveField(1)
  bool isComplet = false;
  @HiveField(2)
  Priority priority = Priority.low;
}

/// sakht ahmiyat task ha
@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  normal,
  @HiveField(2)
  hight
}
  // flutter packages pub run build_runner build