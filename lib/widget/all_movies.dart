import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/movie_data.dart';
import '../model/movie_model.dart';

class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({super.key});

  @override
  AllMoviesScreenState createState() => AllMoviesScreenState();
}

class AllMoviesScreenState extends State<AllMoviesScreen> {
  final MovieData movieData = MovieData();
  final ScrollController _scrollController = ScrollController();
  final List<MovieModel> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _fetchMovies();
      }
    });
  }

  Future<void> _fetchMovies() async {
    setState(() => _isLoading = true);
    try {
      final newMovies = await movieData.movieList(page: _currentPage);
      setState(() {
        _movies.addAll(newMovies);
        _currentPage++;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("데이터를 불러오는데 실패했습니다.")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text("All Movies"),
      ),
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.7,
        ),
        itemCount: _movies.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _movies.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final movie = _movies[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(movie.title),
                  content: Text(movie.overview),
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
          );
        },
      ),
    );
  }
}
