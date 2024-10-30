import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../data/movie_data.dart';
import '../model/movie_model.dart';

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
    getMovieListData(); // 데이터 로드 호출
  }

  getMovieListData() async {
    var data = MovieData();
    _movieList = await data.movieList(); // 영화 데이터 API 호출
  }

  // CustomSearchDelegate를 호출하는 메서드
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝에 배치
          children: [
            Row(
              children: [
                Lottie.asset('lottie/movie.json', height: 80),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _startSearch(context), // 검색 시작
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
      fillColor: Colors.white, // 배경 색상
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15), // 힌트 글씨 색상
    ),
  );

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
        Navigator.pop(context); // 뒤로가기 버튼 클릭 시 검색화면 닫기
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = movieList
        .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].title),
          onTap: () {
            close(context, results[index]); // 결과 선택 시 닫기
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = movieList.where((movie) {
      return movie.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].title),
          onTap: () {
            query = suggestions[index].title; // 선택된 제목으로 쿼리 업데이트
            showResults(context); // 결과 표시
          },
        );
      },
    );
  }
}
