import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:hive/hive.dart';
import '../data/models/pet_model.dart';
import 'package:audioplayers/audioplayers.dart'; // ADD THIS


class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Box adoptionsBox;
  late Box favoritesBox;
  late PetModel pet;
  bool isAdopted = false;
  bool isFavorite = false;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
  super.initState();
  _audioPlayer = AudioPlayer();
  _playMusic();
  }
  void _playMusic() async {
  await _audioPlayer.play(AssetSource('audio/petthem.mp3'));
   }
   void dispose() {
        _audioPlayer.dispose(); // important to stop music
       super.dispose();
    }

  void didChangeDependencies() {
    super.didChangeDependencies();
    adoptionsBox = Hive.box('adoptions');
    favoritesBox = Hive.box('favorites');
    pet = ModalRoute.of(context)!.settings.arguments as PetModel;

    isAdopted = adoptionsBox.get(pet.id, defaultValue: false);
    isFavorite = favoritesBox.containsKey(pet.id);
  }

  void adoptPet() {
    adoptionsBox.put(pet.id, true);
    final historyBox = Hive.box('history');
    historyBox.add(pet);
    setState(() => isAdopted = true);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('🎉Congratulation Your Pet now adopted id:${pet.name}!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        favoritesBox.delete(pet.id);
        isFavorite = false;
      } else {
        favoritesBox.put(pet.id, pet);
        isFavorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final isAsset = pet.imageUrl.startsWith('assets/');

    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        actions: [
          Text('Add Favorite'),
          IconButton(
            
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: toggleFavorite,
          )
        ],
      ),
      body: Column(
        children: [
          Hero(
            tag: pet.id,
            child: SizedBox(
              height: 300,
              child: PhotoView(
  imageProvider: AssetImage(pet.imageUrl),
  minScale: PhotoViewComputedScale.contained,
  maxScale: PhotoViewComputedScale.covered * 2,
  backgroundDecoration: BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor,
  ),
)


            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pet.name, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Type: ${pet.breed}' ),
                const SizedBox(height: 8),
                Text('Age:  ${pet.age}'),
                const SizedBox(height: 8),
                Text('Price: ₹${pet.price.toStringAsFixed(2)}',style: TextStyle(color: Colors.amber),),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isAdopted ? null : adoptPet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAdopted
                        ? Color.fromARGB(255, 30, 138, 24)
                        : Color.fromARGB(255, 42, 76, 42),
                  ),
                  child: Text(
                    isAdopted ? 'Already Adopted' : 'Adopt Me',
                    style: TextStyle(
                      color: Color.fromARGB(255, 190, 200, 180),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
