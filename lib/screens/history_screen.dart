import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pet_adaption_app/data/models/pet_model.dart';
import 'package:pet_adaption_app/widgets/pet_card.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(); // Spinning forever
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyBox = Hive.box('history');
    final pets = historyBox.values.cast<PetModel>().toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Adoption History'),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: pets.isEmpty
            ? Center(
                key: ValueKey('empty'),
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
                            colors: [Colors.blueAccent, Colors.greenAccent],
                          ),
                        ),
                        child: Icon(Icons.pets, size: 40, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No adoptions yet.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                key: ValueKey('list'),
                itemCount: pets.length,
                itemBuilder: (context, i) {
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
