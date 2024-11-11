import 'package:flutter/material.dart';

class MovieDialog extends StatelessWidget {
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;

  const MovieDialog({
    Key? key,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 크기를 가져옴
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 0.3; // 이미지 너비를 화면 너비에 따라 조정
    final contentWidth = screenWidth * 0.6; // 텍스트 영역 너비 조정

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      content: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/$posterPath',
                width: imageWidth, // 이미지 너비 제한
                height: imageWidth * 1.2, // 이미지 높이를 너비의 1.2배로 조정
                fit: BoxFit.contain, // 이미지 전체를 보여주도록 변경
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                width: contentWidth, // 텍스트 영역 너비 제한
                color: Colors.grey[200],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overview,
                      style: const TextStyle(
                        fontSize: 16,
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
                      'Release Date: $releaseDate',
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
  }
}
