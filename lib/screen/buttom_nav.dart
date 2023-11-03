import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cwc23/bcodez/color.dart';
import 'package:cwc23/screen/emni.dart';

import 'package:cwc23/views/home.dart';
import 'package:cwc23/views/livetv.dart';
import 'package:cwc23/views/matches.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _pages = [HomeScreen(), CricketScoreWidget(), MatchesScreen()];

  int _indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          color: AppColor.purpleclr,
          index: _indexPage,
          onTap: (index) {
            setState(() => this._indexPage = index);
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: AppColor.whiteclr,
            ),
            Icon(
              Icons.live_tv,
              color: AppColor.whiteclr,
            ),
            Icon(
              Icons.schedule_sharp,
              color: AppColor.whiteclr,
            )
          ]),
      body: _pages[_indexPage],
    );
  }
}
