import 'package:flutter/material.dart';
import '../../model/movie_model.dart';
import '../movie_dialog.dart';

class MainNow extends StatelessWidget {
  final List<MovieModel> nowPlayingMovies;

  const MainNow({super.key, required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 555,
      child: ListView.builder(
        itemCount: nowPlayingMovies.length,
        itemBuilder: (context, index) {
          final movie = nowPlayingMovies[index];
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            title: Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              movie.overview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MovieDialog(
                    title: movie.title,
                    overview: movie.overview,
                    posterPath: movie.posterPath,
                    releaseDate: movie.releaseDate,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
