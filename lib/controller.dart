import 'dart:async';
import 'package:netflix_clone/repository.dart';

import 'movie.dart';

class MovieController {
  final MovieRepository movieRepository;

  MovieController({required this.movieRepository});

  Future<Map<String, List<Movie>>> fetchMovies() async {
    try {
      List<Movie> popularMovies = await movieRepository.fetchMovies('popular');
      List<Movie> topRatedMovies =
          await movieRepository.fetchMovies('top_rated');
      List<Movie> upcomingMovies =
          await movieRepository.fetchMovies('upcoming');
      return {
        'Popular': popularMovies,
        'Top Rated': topRatedMovies,
        'Upcoming': upcomingMovies,
      };
    } catch (e) {
      throw e;
    }
  }
}
