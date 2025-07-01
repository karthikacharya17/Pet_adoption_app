import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_adaption_app/bloc/bloc/pet_bloc.dart';
import 'package:pet_adaption_app/bloc/bloc/pet_event.dart';
//import 'bloc/pet_bloc.dart';
//import 'bloc/pet_event.dart';
import 'data/models/pet_model.dart';
import 'routes.dart';
import 'themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PetModelAdapter());
  await Hive.openBox('favorites');
  await Hive.openBox('adoptions');
  await Hive.openBox('history');
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PetBloc()..add(LoadPetsEvent())),
      ],
      child: MaterialApp(
        title: 'Pet Adoption App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: appRoutes,
      ),
    );
  }
}