import 'package:flutter/material.dart';
import '../../model/movie_model.dart';
import '../movie_dialog.dart';

class MainPopular extends StatelessWidget {
  final List<MovieModel> movies;

  const MainPopular({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 0.8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MouseRegion(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => MovieDialog(
                  title: movie.title,
                  overview: movie.overview,
                  posterPath: movie.posterPath,
                  releaseDate: movie.releaseDate,
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
