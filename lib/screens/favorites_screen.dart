import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/models/pet_model.dart';
import '../widgets/pet_card.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(); // Loop the rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box('favorites');
    final pets = favoritesBox.values.cast<PetModel>().toList();

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Pets')),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: pets.isEmpty
            ? Center(
                key: ValueKey('empty_favorites'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotationTransition(
                      turns: _controller,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.pinkAccent, Colors.orangeAccent],
                          ),
                        ),
                        child: Icon(Icons.favorite, size: 40, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No favorites yet.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                key: ValueKey('favorites_list'),
                itemCount: pets.length,
                itemBuilder: (_, i) {
                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 500 + i * 100),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) => Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    ),
                    child: PetCard(pet: pets[i]),
                  );
                },
              ),
      ),
    );
  }
}
