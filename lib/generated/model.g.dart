// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      town: json['town'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('age', instance.age);
  writeNotNull('town', instance.town);
  return val;
}

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      id: json['id'] as int?,
      customerId: json['customer_id'] as int?,
      description: json['description'] as String?,
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('total', instance.total);
  writeNotNull('description', instance.description);
  return val;
}
