import 'package:flutter/material.dart';
import '../../model/movie_model.dart';

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
                color: Colors.white, // 제목 색상을 흰색으로 설정
              ),
            ),
            subtitle: Text(
              movie.overview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:  TextStyle(
                color: Colors.grey[600]
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // BorderRadius 적용
                    ),

                    title: Center( // 타이틀을 가운데 정렬
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center, // 텍스트 내부에서도 가운데 정렬
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12), // 이미지 모서리 둥글게
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',

                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20), // Container의 BorderRadius 추가
                              child: Container(
                                color: Colors.grey[200],
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.overview,
                                      style: const TextStyle(
                                        fontSize: 50,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Release Date: ${movie.releaseDate}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Close",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
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
