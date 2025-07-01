import 'package:hive/hive.dart';
part 'pet_model.g.dart';

@HiveType(typeId: 0)
class PetModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final String breed;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  final double price;

  PetModel({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.imageUrl,
    required this.price,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        breed: json['breed'],
        imageUrl: json['imageUrl'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'breed': breed,
        'imageUrl': imageUrl,
        'price': price,
      };
}