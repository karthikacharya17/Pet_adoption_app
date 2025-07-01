import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/history_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomeScreen(),
  '/details': (context) => DetailsScreen(),
  '/favorites': (context) => FavoritesScreen(),
  '/history': (context) => HistoryScreen(),
};