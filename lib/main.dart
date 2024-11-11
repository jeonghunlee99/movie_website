import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webpageprac/widget/all_movies.dart';
import 'homepage.dart';


void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  final _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/all',
      builder: (context, state) => const AllMoviesScreen(),
    ),
  ]);

  Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey[600]),
    fillColor: Colors.white,
    ),
          fontFamily: 'NotoSansKR'
    ),);
  }
}

