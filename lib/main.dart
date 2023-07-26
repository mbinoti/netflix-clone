import 'package:flutter/material.dart';
import 'package:netflix_clone/controller.dart';
import 'package:netflix_clone/home.dart';
import 'package:netflix_clone/repository.dart';

void main() {
  runApp(NetflixCloneApp());
}

class NetflixCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MovieController movieController =
        MovieController(movieRepository: MovieRepository());

    return MaterialApp(
      title: 'Netflix Clone',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NetflixHomePage(movieController: movieController),
    );
  }
}
