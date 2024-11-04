import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../data/movie_data.dart';
import '../model/movie_model.dart';
import 'movie_dialog.dart';

class IconSearchbar extends StatefulWidget implements PreferredSizeWidget {
  const IconSearchbar({super.key});

  @override
  IconSearchbarState createState() => IconSearchbarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class IconSearchbarState extends State<IconSearchbar> {
  List<MovieModel> _movieList = [];

  @override
  void initState() {
    super.initState();
    getMovieListData();
  }

  getMovieListData() async {
    var data = MovieData();
    _movieList = await data.movieList();
  }

  void _startSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(_movieList),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Lottie.asset('lottie/movie.json', height: 80),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _startSearch(context),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<MovieModel> {
  final List<MovieModel> movieList;

  CustomSearchDelegate(this.movieList)
      : super(
    searchFieldLabel: 'search movies!',
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.search,
    searchFieldDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
    ),
  );

  void showMovieDialog(BuildContext context, MovieModel movie) {
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
  }

  Widget buildListView(BuildContext context, List<MovieModel> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Text(movie.title),
          onTap: () => showMovieDialog(context, movie),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = movieList
        .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return buildListView(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = movieList.where((movie) {
      return movie.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return buildListView(context, suggestions);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
