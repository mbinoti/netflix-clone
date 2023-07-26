import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart'; // Import your Movie model here

class MovieRepository {
  static String apiKey =
      '5cca41b43015e4fff1f5eac76d27a3c6'; // Replace with your actual TMDB API key

  Future<List<Movie>> fetchMovies(String category) async {
    final response = await http.get(
      'https://api.themoviedb.org/3/movie/$category?api_key=$apiKey&language=en-US'
          as Uri,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Iterable list = jsonResponse['results'];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
