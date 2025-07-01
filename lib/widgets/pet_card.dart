import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/models/pet_model.dart';

class PetCard extends StatelessWidget {
  final PetModel pet;
  const PetCard({required this.pet});

  @override
  Widget build(BuildContext context) {
    final isAsset = pet.imageUrl.startsWith('assets/images');

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/details', arguments: pet),
      child: Hero(
        tag: pet.id,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[300],
              backgroundImage: isAsset
                  ? AssetImage(pet.imageUrl) as ImageProvider
                  : CachedNetworkImageProvider(pet.imageUrl),
            ),
            title: Text(pet.name),
            subtitle: Text('${pet.breed} - ${pet.age} age'),
            trailing: Text('₹${pet.price.toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}
