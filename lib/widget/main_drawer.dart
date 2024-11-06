import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () { context.push('/all');},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("All Movies"),
              ),
          ),
          const SizedBox(
            height: 20,
          ),

        ]
      ),
    );
  }
}
