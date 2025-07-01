import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pet_adaption_app/bloc/bloc/pet_bloc.dart';
import 'package:pet_adaption_app/bloc/bloc/pet_state.dart';
//import 'package:pet_adaption_app/bloc/pet_bloc.dart';
//import 'package:pet_adaption_app/bloc/pet_state.dart';
import '../widgets/pet_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("WELCOME"),
        actions: [
          ElevatedButton(onPressed:(){
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sorry Unavailable!'),
              duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
            ),
          );
          } , child: Text('LOGIN'))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: InputDecoration(
                hintText: 'Search pets  by Pet ID(Ex Pet 1  GiveSpace)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            
          ),
        ),
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          if (state is PetLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is PetLoaded) {
            final adoptedBox = Hive.box('adoptions');

            // ✅ Proper search filtering (no need for null check)
            final filteredPets = state.pets
                .where((pet) => pet.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

            if (filteredPets.isEmpty) {
              return Center(child: Text('No pets found for "$query"'));
            }

            return ListView.builder(
              itemCount: filteredPets.length,
              itemBuilder: (_, i) {
                final pet = filteredPets[i];
                final isAdopted = adoptedBox.get(pet.id, defaultValue: false);

                return Stack(
                  children: [
                    PetCard(pet: pet),
                    if (isAdopted)
                      Positioned(
                        top: 10,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Already Adopted',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          }

          return Center(child: Text('Failed to load pets'));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF42A5F5),
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/favorites');
          if (index == 2) Navigator.pushNamed(context, '/history');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
