import 'package:flutter/material.dart';

class CustomBottomNaviagation extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNaviagation({super.key, required this.currentIndex});

  void onItemTap(BuildContext context, int index) {
    
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Categorías'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
      ],
    );
  }
}
