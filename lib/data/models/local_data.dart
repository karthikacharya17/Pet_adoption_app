import 'package:pet_adaption_app/data/models/pet_model.dart';

List<String> petImages = [
  'assets/images/dog1.jpg',
  'assets/images/cat1.jpg',
  'assets/images/dog3.jpg',
  'assets/images/cat2.jpg',
  'assets/images/dog1.jpg',
  'assets/images/cat3.jpg',
];

List<PetModel> dummyPets = List.generate(
  15,
  (i) => PetModel(
    id: 'pet_$i',
    name: 'Pet $i',
    age: 1 + (i % 10),
    breed: i % 2 == 0 ? 'Dog' : 'Cat',
    imageUrl: petImages[i % petImages.length], // ✅ Assign image dynamically
    price: 1000 + i * 500,
  ),
);
