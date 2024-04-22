import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'generated/model.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
@Entity()
class User {
  @Id(assignable: true)
  int? id;
  String? name;
  int? age;
  String? town;

  User({
    this.id,
    this.name,
    this.age,
    this.town,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
@Entity()
class Orders {
  @Id(assignable: true)
  int? id;
  int? customerId;
  double? total;
  String? description;

  final customer = ToOne<User>();

  Orders({
    this.id,
    this.customerId,
    this.description,
    this.total,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
