import 'package:flutter/material.dart';
import 'package:webpageprac/model/movie_model.dart';
import 'package:webpageprac/skeleton_loading/carousel_skeleton.dart';
import 'package:webpageprac/skeleton_loading/now_skeleton.dart';
import 'package:webpageprac/skeleton_loading/popular_skeleton.dart';
import 'package:webpageprac/widget/icon_searchbar.dart';
import 'package:webpageprac/widget/main_drawer.dart';
import 'package:webpageprac/widget/footer.dart';
import 'package:webpageprac/widget/main_widget/main_carousel_slider.dart';
import 'package:webpageprac/widget/main_widget/main_now.dart';
import 'package:webpageprac/widget/main_widget/main_popular.dart';
import 'data/movie_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieModel> _topratedMovie = [];
  List<MovieModel> _popularMovies = [];
  List<MovieModel> _nowPlayingMovies = [];

  bool isLoading = true;
  bool isPopularLoading = true;
  bool isNowPlayingLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMovieData();
      getPopularMoviesData();
      getNowPlayingMoviesData();
    });
  }


  getMovieData() async {
    var data = MovieData();
    _topratedMovie = await data.fetchTopRatedMovie();
    setState(() {
      isLoading = false;
    });
  }


  getPopularMoviesData() async {
    var data = MovieData();
    _popularMovies = await data.fetchPopularMovies();
    setState(() {
      isPopularLoading = false;
    });
  }


  getNowPlayingMoviesData() async {
    var data = MovieData();
    _nowPlayingMovies = await data.fetchNowPlayingMovies();

    setState(() {
      isNowPlayingLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IconSearchbar(),
      drawer: const MainDrawer(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Top rated movies",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: isLoading
                        ? const CarouselSkeleton()
                        : MainCarouselSlider(topratedMoives: _topratedMovie),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Now playing",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      isNowPlayingLoading
                          ? const NowsSkeleton()
                          : MainNow(nowPlayingMovies: _nowPlayingMovies),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Explore popular movies",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double gridviewHeight = (constraints.maxWidth / 5) * 1.3 * 4;
                  return SizedBox(
                    height: gridviewHeight,
                    child: isPopularLoading
                        ? const PopularSkeleton()
                        : MainPopular(movies: _popularMovies)
                  );
                },
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
