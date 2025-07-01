import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adaption_app/data/models/pet_model.dart';
import 'pet_event.dart';
import 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  PetBloc() : super(PetLoading()) {
    on<LoadPetsEvent>((event, emit) async {
      await Future.delayed(Duration(seconds: 1));
      List<String> petNames = [
  'Bruno', 'Luna', 'Simba', 'Milo', 'Coco', 
  'Bella', 'Charlie', 'Daisy', 'Rocky', 'Lucy',
  'Oscar', 'Misty', 'Leo', 'Ginger', 'Choco'
];

      // Step 1: Local asset image paths
      List<String> petImages = [
        'assets/images/cam.jpg',
        'assets/images/cat7.jpg',
        'assets/images/dog6.jpg',
        'assets/images/cat8.jpg',
        'assets/images/dog7.jpg',
        'assets/images/cat9.jpg',
        'assets/images/dog10.jpg',
        'assets/images/cat10.jpg',
        'assets/images/dog11.jpg',
        'assets/images/cat11.jpg',
        'assets/images/dog12.jpg',
        'assets/images/cat13.jpg',
        'assets/images/dog13.jpg',
        'assets/images/dog15.jpg',
        'assets/images/cat14.jpg',
      ];

      // Step 2: Generate dummy pets with asset images
      final pets = List.generate(
        15,
        (i) => PetModel(
          id: 'pet_$i',
          name: petNames[i % petNames.length],
          age: 2 + (i % 10),
          breed: i % 2 == 0 ? 'Dog' : 'Cat',
          imageUrl: petImages[i % petImages.length], // dynamic image assignment
          price: 1000 + i * 500,
        ),
      );

      emit(PetLoaded(pets: pets));
    });
  }
}
