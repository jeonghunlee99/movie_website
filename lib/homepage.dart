import 'package:flutter/material.dart';
import 'package:webpageprac/model/movie_model.dart';
import 'package:webpageprac/skeleton_loading/carousel_skeleton.dart';
import 'package:webpageprac/skeleton_loading/now_skeleton.dart';
import 'package:webpageprac/skeleton_loading/popular_skeleton.dart';
import 'package:webpageprac/widget/icon_searchbar.dart';
import 'package:webpageprac/widget/main_drawer.dart';
import 'package:webpageprac/widget/footer.dart';
import 'package:webpageprac/widget/main_widget/main_carousel_slider.dart';
import 'package:webpageprac/widget/main_widget/main_now.dart'; // MainNow 위젯 가져오기
import 'package:webpageprac/widget/main_widget/main_popular.dart';
import 'data/movie_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieModel> _topratedMovie = [];
  List<MovieModel> _popularMovies = []; // 인기 영화를 저장할 리스트
  List<MovieModel> _nowPlayingMovies = []; // Now playing 영화를 저장할 리스트

  bool isLoading = true; // Top Rated 영화 로딩 상태
  bool isPopularLoading = true; // Popular 영화 로딩 상태
  bool isNowPlayingLoading = true; // Now Playing 영화 로딩 상태

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMovieData();
      getPopularMoviesData(); // Popular 영화 데이터도 로드
      getNowPlayingMoviesData(); // Now Playing 영화 데이터 로드
    });
  }

  // Top rated 영화 데이터를 가져오는 함수
  getMovieData() async {
    var data = MovieData();
    _topratedMovie = await data.fetchTopRatedMovie();
    setState(() {
      isLoading = false;
    });
  }

  // Popular 영화 데이터를 가져오는 함수
  getPopularMoviesData() async {
    var data = MovieData();
    _popularMovies = await data.fetchPopularMovies(); // Popular API 호출
    setState(() {
      isPopularLoading = false;
    });
  }

  // Now Playing 영화 데이터를 가져오는 함수
  getNowPlayingMoviesData() async {
    var data = MovieData();
    _nowPlayingMovies = await data.fetchNowPlayingMovies(); // Now Playing API 호출

    // 데이터를 변환할 필요 없음, 그대로 사용
    setState(() {
      isNowPlayingLoading = false; // 로딩 상태 해제
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IconSearchbar(),
      drawer: const MainDrawer(),
      backgroundColor: Colors.black, // 배경색을 검정색으로 설정
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Top rated movies",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // 글자 색상을 흰색으로 설정
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
                        ? const CarouselSkeleton() // 로딩 중에는 CarouselSkeleton
                        : MainCarouselSlider(topratedMoives: _topratedMovie), // 로딩 완료 시 데이터를 보여줌
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
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // 글자 색상을 흰색으로 설정
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // 삼항 연산자로 로딩 중에는 NowsSkeleton, 로딩 후에는 MainNow 위젯
                      isNowPlayingLoading
                          ? const NowsSkeleton() // 로딩 중에는 스켈레톤
                          : MainNow(nowPlayingMovies: _nowPlayingMovies), // 로딩 완료 후 실제 데이터
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // 글자 색상을 흰색으로 설정
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
                    // 3항 연산자로 로딩 중에는 스켈레톤, 로딩 완료 시에는 데이터를 표시
                    child: isPopularLoading
                        ? const PopularSkeleton() // 로딩 중에는 PopularSkeleton
                        : MainPopular(movies: _popularMovies)
                  );
                },
              ),
            ),
            const Footer(), // Footer 추가
          ],
        ),
      ),
    );
  }
}
