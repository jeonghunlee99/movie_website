import 'package:flutter/material.dart';
import '../../model/movie_model.dart';

class MainPopular extends StatelessWidget {
  final List<MovieModel> movies; // 데이터를 외부에서 받아서 사용

  const MainPopular({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 한 줄에 3개의 아이템을 표시
        childAspectRatio: 0.8,
      ),
      itemCount: movies.length, // 영화 개수
      itemBuilder: (context, index) {
        final movie = movies[index]; // 각 영화 데이터
        return Card(
          child: Column(
            children: [
              // 영화 포스터 이미지 표시
              Expanded(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
              // 영화 제목 표시
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
        );
      },
    );
  }
}
