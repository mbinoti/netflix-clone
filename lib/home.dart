import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflix_clone/controller.dart';
import 'movie.dart';

class NetflixHomePage extends StatefulWidget {
  final MovieController movieController;

  NetflixHomePage({required this.movieController});

  @override
  _NetflixHomePageState createState() => _NetflixHomePageState();
}

class _NetflixHomePageState extends State<NetflixHomePage> {
  late Future<Map<String, List<Movie>>> movieFuture;

  @override
  void initState() {
    super.initState();
    movieFuture = widget.movieController.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.network(
          'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg',
          fit: BoxFit.cover,
          height: 56,
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Search button pressed');
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map<String, List<Movie>>>(
        future: movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView(
              children: snapshot.data!.entries
                  .map<Widget>((entry) =>
                      MovieCategory(category: entry.key, movies: entry.value))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}

class MovieCategory extends StatelessWidget {
  final String category;
  final List<Movie> movies;

  MovieCategory({required this.category, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
