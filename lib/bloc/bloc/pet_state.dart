import 'package:pet_adaption_app/data/models/pet_model.dart';

//import '../data/models/pet_model.dart';

abstract class PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final List<PetModel> pets;
  PetLoaded({required this.pets});
}

class PetError extends PetState {
  final String message;
  PetError(this.message);
}