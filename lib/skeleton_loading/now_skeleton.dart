import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NowsSkeleton extends StatelessWidget {
  const NowsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: ListView.builder(
          shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 7,
        itemBuilder: (context ,index){
            return ListTile(
              leading: Container(
                color: Colors.grey[800],
                width: 80,
                height: 120,
              ),
              title: Container(
                height: 20,
                color: Colors.grey[800],
              ),
              subtitle: Container(
                height: 40,
                  color: Colors.grey[800],
              ),
            );
        })
    );
  }
}
